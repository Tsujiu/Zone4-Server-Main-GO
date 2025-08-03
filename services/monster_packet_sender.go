package services

import (
	"bytes"
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"sync"
)

func BroadcastMonsterToZone(zoneID int, m *models.Monster, template *models.MonsterTemplate) {
	if template == nil {
		fmt.Println("❌ Broadcast failed: template is nil for monster ID", m.ID, "Index", m.Index)
		return
	}

	packet := struct {
		Type    string                     `json:"type"`
		Payload models.MonsterCreatePacket `json:"payload"`
	}{
		Type: "MONSTER_CREATE",
		Payload: models.MonsterCreatePacket{
			MonsterId:          m.ID,
			Type:               m.Index,
			X:                  byte(m.Pos.X),
			Y:                  byte(m.Pos.Y),
			TargetX:            byte(m.Target.X),
			TargetY:            byte(m.Target.Y),
			Direction:          0, // เพิ่มระบบหมุนได้ภายหลัง
			Level:              template.Level,
			MaxLife:            template.HP,
			CurrentLife:        template.HP,
			PentagramAttribute: byte(template.Attribute),
			Name:               template.Name,
			Alive:              true,
		},
	}

	jsonData, err := json.Marshal(packet)
	if err != nil {
		fmt.Println("❌ Failed to marshal monster packet:", err)
		return
	}

	BroadcastToZone(zoneID, jsonData)
}

type PlayerConn struct {
	ZoneID int
	Send   func(data []byte)
}

var ConnectedPlayers = struct {
	sync.RWMutex
	players map[string]*PlayerConn
}{
	players: make(map[string]*PlayerConn),
}

// BroadcastToZone ส่ง packet ไปให้ทุก player ที่อยู่ใน zone นั้น
func BroadcastToZone(zoneID int, data []byte) {
	ConnectedPlayers.RLock()
	defer ConnectedPlayers.RUnlock()

	for _, player := range ConnectedPlayers.players {
		if player.ZoneID == zoneID {
			SafeSend(player, data)
		}
	}
}

func SendMonsterMoveToPlayer(p *Player, m *models.Monster) {
	data := map[string]interface{}{
		"monsterId": m.ID,
		"x":         m.Pos.X,
		"y":         m.Pos.Y,
	}
	jsonData, _ := json.Marshal(data)
	p.SendWithCode(message.SERVER_MESSAGE_MONSTER_MOVE, jsonData)
}

func BroadcastMonsterMoveToZone(zoneID int, m *models.Monster) {

	for _, player := range GetPlayersInZone(zoneID) {
		SendMonsterMoveToPlayer(player, m)
	}

	// if len(GetPlayersInZone(zoneID)) == 0 {
	// 	log.Printf("Player 0")
	// }

	// fmt.Printf("Broadcasting to %d players in zone %d\n", len(GetPlayersInZone(zoneID)), zoneID)
}

func BroadcastMonsterGroupMoveToZone(zoneID int, monsters []*models.Monster) {
	type MoveData struct {
		MonsterID int `json:"monsterId"`
		X         int `json:"x"`
		Y         int `json:"y"`
		Index     int `json:"index"` // ✅ ใส่ไว้เพื่อใช้ render sprite หรือ AI ฝั่ง client
	}

	var moves []MoveData
	for _, m := range monsters {
		moves = append(moves, MoveData{
			MonsterID: m.ID,
			X:         m.Pos.X,
			Y:         m.Pos.Y,
			Index:     m.Index,
		})
	}

	jsonData, err := json.Marshal(moves)
	if err != nil {
		log.Printf("❌ JSON marshal error: %v", err)
		return
	}

	for _, p := range GetPlayersInZone(zoneID) {
		p.SendWithCode(message.SERVER_MESSAGE_MONSTER_MOVE, jsonData)
	}

	// log.Printf("📦 Broadcast %d monster(s) to zone %d", len(monsters), zoneID)
}

func BuildMonsterGroupMovePacket(monsters []*models.Monster) []byte {
	buf := new(bytes.Buffer)

	// Packet header (ตามโปรโตคอลคุณ - สมมุติ PacketType = 0xC2 0xF3 0x01)
	buf.WriteByte(0xC2)
	buf.Write([]byte{0x00, 0x00}) // Placeholder for size, จะใส่ทีหลัง
	buf.WriteByte(0xF3)
	buf.WriteByte(0x01) // Subcode for "group monster move"

	// จำนวน Monster
	buf.WriteByte(byte(len(monsters)))

	for _, m := range monsters {
		buf.Write(EncodeMonsterMoveEntry(m))
	}

	// แทรกความยาว packet ที่ตำแหน่ง [1:3]
	packet := buf.Bytes()
	packetLen := len(packet)
	packet[1] = byte(packetLen >> 8)
	packet[2] = byte(packetLen & 0xFF)

	return packet
}

func EncodeMonsterMoveEntry(m *models.Monster) []byte {
	buf := new(bytes.Buffer)
	buf.WriteByte(byte(m.ID))    // Monster ID
	buf.WriteByte(byte(m.Pos.X)) // Pos X
	buf.WriteByte(byte(m.Pos.Y)) // Pos Y
	buf.WriteByte(byte(m.Index)) // Monster type index (template)
	return buf.Bytes()
}

func SendToPlayersInZone(zoneID int, packet []byte) {
	for _, player := range GetPlayersInZone(zoneID) {
		player.SendPacket(packet)
	}
}
