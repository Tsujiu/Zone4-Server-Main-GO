package services

import (
	"encoding/json"
	"maxion-zone4/models"
)

// SendAllMonstersToPlayer sends all monsters in a zone to a player upon entry
func SendAllMonstersToPlayer(zoneID int, sendFunc func(data []byte)) {
	MonsterManager.mu.RLock()
	defer MonsterManager.mu.RUnlock()

	monsters := MonsterManager.monsters[zoneID]

	for _, m := range monsters {
		tpl := MonsterTemplates[m.Index]
		if tpl == nil {
			continue
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
				Direction:          0,
				Level:              tpl.Level,
				MaxLife:            tpl.HP,
				CurrentLife:        tpl.HP,
				PentagramAttribute: byte(tpl.Attribute),
				Name:               tpl.Name,
				Alive:              true,
			},
		}

		if data, err := json.Marshal(packet); err == nil {
			sendFunc(data)
		}
	}
}
