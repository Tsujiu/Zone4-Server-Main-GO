package packet

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/config"
	"maxion-zone4/controllers/shared"
	user_controller "maxion-zone4/controllers/user"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"net"
	"strconv"
	"strings"
	"time"

	skill "maxion-zone4/controllers/skill"
)

var udpPacketHandlers = map[int]func(string){
	message.USER_MESSAGE_1000:                 user_controller.LoginUserUDP,
	message.USER_MESSAGE_DISCONNECT_GO_SERVER: user_controller.DisconnectUser,
	message.USER_MESSAGE_GET_USE_SKILL:        skill.CharacterUseSkill,
	//message.USER_MESSAGE_SET_USE_SKILL_RETURN: skill.CharacterUseSkill,
	message.USER_MESSAGE_GET_USER_MOVE:          user_controller.MoveUserUDP,
	message.USER_MESSAGE_GET_USER_ATTACK:        user_controller.AttackUserUDP,
	message.USER_MESSAGE_GET_USER_ROTATE:        user_controller.RotateUserUDP,
	message.USER_MESSAGE_REGISTER_USER:          user_controller.LoginUserUDP,
	message.USER_MESSAGE_LOGOUT_USER:            user_controller.LogoutUserUDP,
	message.SERVER_MESSAGE_MONSTER_MOVE:         user_controller.MoveMonsterUDP,
	message.SERVER_MESSAGE_MONSTER_DEATH:        services.MonsterDeath,
	message.SERVER_MESSAGE_PLAYER_EQUIPPED_ITEM: services.PlayEquippedItem,
}

// type UDPClient struct {
// 	Addr          *net.UDPAddr
// 	NetworkID     string
// 	Position      Coordinates
// 	ClassID       int    // เพิ่ม ClassID เข้าไป
// 	Username      string // ชื่อบัญชีผู้เล่น
// 	CharacterName string // ชื่อตัวละครในเกม
// 	MapNumber     int    // หมายเลขของแผนที่
// }

// type Coordinates struct {
// 	X int `json:"x"`
// 	Y int `json:"y"`
// }

// var UDPClients = make(map[string]UDPClient) // key ยังคงเป็น addr.String() (หรือจะเปลี่ยนเป็น networkID ก็ได้)
// var UDPClientsMutex = sync.RWMutex{}

func ProcessUDP(packet string, addr *net.UDPAddr) {

	header, err := strconv.Atoi(strings.Split(packet, "|")[0])
	if err != nil {
		log.Println("UDP Invalid Header from packet: ", err)
		return
	}

	body := strings.Split(packet, "|")[1]
	if body == "" {
		log.Println("Invalid Body from packet: ", err)
		return
	}

	// ✅ Register client address
	if header == message.USER_MESSAGE_REGISTER_USER {

		var data models.RegisterUserDTO
		err := json.Unmarshal([]byte(body), &data)
		if err != nil {
			fmt.Println("❌ JSON parsing failed in ProcessUDP:", err)
			return
		}

		if len(body) > 1 {
			//networkID := strings.TrimSpace(data.ID)
			RegisterUDPClient(addr, body)
			SendExistingPlayersToNewClient(addr)
		}
	}
	// 🔍 ตรวจสอบว่าเป็น Header Logout หรือไม่
	if header == message.USER_MESSAGE_LOGOUT_USER {
		// ✅ ลบจาก UDPClients
		networkID := strings.TrimSpace(body)
		RemoveUDPClient(networkID)
	}

	if handler, found := udpPacketHandlers[header]; found {
		handler(body)
	} else {
		log.Println("Unknown Packet Type")
	}
	var resHeader int
	if header == message.USER_MESSAGE_GET_USER_MOVE {
		var moveData models.MoveDataDTO
		err := json.Unmarshal([]byte(body), &moveData)
		if err != nil {
			fmt.Println("❌ JSON parsing failed:", err)
			return
		}
		UpdateUDPClientPosition(addr, moveData)
		resHeader = message.USER_MESSAGE_SET_USER_MOVE_RETURN
	} else if header == message.USER_MESSAGE_GET_USER_ATTACK {
		resHeader = message.USER_MESSAGE_SET_USER_ATTACK_RETURN
	} else if header == message.USER_MESSAGE_GET_USER_ROTATE {
		resHeader = message.USER_MESSAGE_SET_USER_ROTATE_RETURN
	} else if header == message.USER_MESSAGE_REGISTER_USER {
		resHeader = message.USER_MESSAGE_REGISTER_USER_RETURN
	} else if header == message.USER_MESSAGE_LOGOUT_USER {
		resHeader = message.USER_MESSAGE_LOGOUT_USER_RETURN
	} else if header == message.USER_MESSAGE_GET_USE_SKILL {
		resHeader = message.USER_MESSAGE_SET_USE_SKILL_RETURN
	}

	BroadcastUDP(resHeader, body, addr)
}

func BroadcastUDP(header int, body string, excludeAddr *net.UDPAddr) {
	packet := strconv.Itoa(header) + "|" + body
	response, err := models.EncryptMessage(packet)
	if err != nil {
		log.Println("Error encrypting UDP packet:", err)
		return
	}

	shared.UDPClientsMutex.RLock()
	defer shared.UDPClientsMutex.RUnlock()

	for _, client := range shared.UDPClients {
		// ข้าม client ตัวเอง (ผู้ส่ง)
		if excludeAddr != nil && client.Addr.String() == excludeAddr.String() {
			continue
		}

		_, err := config.ConnUDP.WriteToUDP([]byte(response), client.Addr)
		if err != nil {
			log.Printf("❌ Failed to send to [%s] (%s): %v\n", client.NetworkID, client.Addr, err)
		} else {
			log.Printf("✅ Broadcasted to [%s] (%s)\n", client.NetworkID, client.Addr)
		}
	}
}

func SendExistingPlayersToNewClient(newClientAddr *net.UDPAddr) {
	shared.UDPClientsMutex.RLock()
	defer shared.UDPClientsMutex.RUnlock()

	for _, client := range shared.UDPClients {
		if client.Addr.String() == newClientAddr.String() {
			continue
		}

		// ✅ สร้าง RegisterUserDTO
		userDTO := models.RegisterUserDTO{
			ID: client.NetworkID,
			Coord: models.CoordDTO{
				X: client.Position.X,
				Y: client.Position.Y,
			},
			ClassID:       client.ClassID, // << เพิ่มตรงนี้
			Username:      client.Username,
			CharacterName: client.CharacterName,
			MapNumber:     client.MapNumber,
		}

		// ✅ Serialize เป็น JSON
		body, err := json.Marshal(userDTO)
		if err != nil {
			log.Println("❌ JSON Marshalling failed:", err)
			continue
		}

		// ✅ สร้าง Packet ใหม่
		packet := strconv.Itoa(message.USER_MESSAGE_REGISTER_USER_RETURN) + "|" + string(body)

		response, err := models.EncryptMessage(packet)
		if err != nil {
			log.Println("Error encrypting user data for new client:", err)
			continue
		}

		_, err = config.ConnUDP.WriteToUDP([]byte(response), newClientAddr)
		if err != nil {
			log.Printf("❌ Failed to send existing client to new client: %v\n", err)
		} else {
			log.Printf("✅ Sent existing client [%s] to new client (%s)\n", client.NetworkID, newClientAddr)
		}
	}
}

func RegisterUDPClient(addr *net.UDPAddr, body string) {
	clientKey := addr.String()

	shared.UDPClientsMutex.Lock()
	defer shared.UDPClientsMutex.Unlock()

	var data models.RegisterUserDTO
	err := json.Unmarshal([]byte(body), &data)
	if err != nil {
		fmt.Println("❌ JSON parsing failed in ProcessUDP:", err)
		return
	}

	// Check if the client is already registered with the same networkID
	if existingClient, exists := shared.UDPClients[clientKey]; exists {
		if existingClient.NetworkID == data.ID {
			log.Println("UDP Client already registered:", data.ID, "@", clientKey)
			return
		}
	}

	// ✅ เพิ่มตำแหน่งที่ส่งมาใน UDPClient
	shared.UDPClients[clientKey] = &shared.UDPClient{
		Addr:      addr,
		NetworkID: data.ID,
		Position: shared.Coordinates{
			X: data.Coord.X,
			Y: data.Coord.Y,
		},
		ClassID:       data.ClassID,
		Username:      data.Username,      // <-- เพิ่มตรงนี้
		CharacterName: data.CharacterName, // <-- เพิ่มตรงนี้
		MapNumber:     data.MapNumber,     // <-- เพิ่มตรงนี้
	}

	log.Printf("✅ UDP Client registered: %s @ %s (Position: %d, %d)", data.ID, clientKey, data.Coord.X, data.Coord.Y)
}

var ctx = context.Background()

func UpdateUDPClientPosition(addr *net.UDPAddr, moveData models.MoveDataDTO) {
	clientKey := addr.String()
	x := moveData.Position.X
	y := moveData.Position.Y
	zoneID := moveData.MapNumber

	shared.UDPClientsMutex.Lock()
	defer shared.UDPClientsMutex.Unlock()

	if client, exists := shared.UDPClients[clientKey]; exists {
		client.Position.X = x
		client.Position.Y = y
		client.MapNumber = zoneID
		shared.UDPClients[clientKey] = client

		rdb := services.RedisClient

		// สร้างข้อมูลการเคลื่อนไหว
		move := models.CharacterMove{
			Username:      client.Username,      //"testuser123",
			CharacterName: client.CharacterName, //"DarkWizard",
			MapNumber:     client.MapNumber,     //0,
			PosX:          x,
			PosY:          y,
			Timestamp:     time.Now(),
		}

		// แปลง struct เป็น JSON
		data, err := json.Marshal(move)
		if err != nil {
			log.Printf("❌ JSON marshal error: %v", err)
			return
		}

		_, ok := services.PlayerManager.Players[client.Username]
		if !ok {
			log.Printf("⚠️ Player %s no longer exists in PlayerManager", client.Username)
			return
		}

		playerInfo := services.PlayerManager.Players[client.Username]
		services.PlayerManager.Players[client.Username].CurrentLife = int(playerInfo.MaxLife)
		services.PlayerManager.Players[client.Username].Pos = models.Vec2{X: x, Y: y}

		// บันทึกลง Redis (เก็บแบบ list โดยใช้ LPUSH)
		redisKey := fmt.Sprintf("character:move:%s", move.CharacterName)
		if err := rdb.LPush(ctx, redisKey, data).Err(); err != nil {
			log.Printf("❌ Redis LPUSH error: %v", err)
			return
		}

		log.Printf("✅ Updated position for %s to (%d, %d)", client.NetworkID, x, y)
	} else {
		log.Printf("⚠️ Client %s not found to update position", clientKey)
	}
}

func RemoveUDPClient(body string) {

	var data models.RegisterUserDTO
	err := json.Unmarshal([]byte(body), &data)
	if err != nil {
		fmt.Println("❌ JSON parsing failed in ProcessUDP:", err)
		return
	}

	shared.UDPClientsMutex.Lock()
	defer shared.UDPClientsMutex.Unlock()

	// ✅ Loop ผ่าน UDPClients ทั้งหมดเพื่อตรวจสอบ ID
	for key, client := range shared.UDPClients {
		if client.NetworkID == data.ID {
			// ถ้าเจอให้ลบออกจาก Map
			delete(shared.UDPClients, key)
			log.Printf("✅ Removed UDPClient with ID: %s (Key: %s)", data.ID, key)
			return
		}
	}

	log.Printf("⚠️ No UDPClient found with ID: %s", data.ID)
	//delete(UDPClients, data.ID)
}
