package gameplay

import (
	"encoding/json"
	"log"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"maxion-zone4/utils"
	"reflect"
	"strings"
)

// สร้างห้องใหม่
func CreateRoom(body string, character *models.CharacterInfo) {
	if body == "" {
		return
	}

	// Parse body to Room struct
	room := models.Room{}
	err := utils.Parse([]byte(body), &room)
	if err != nil {
		utils.LogMessage(err.Error())
		return
	}

	// Check if room already exists from redis
	roomExists, err := services.CheckRedisKeyExists("Room_" + room.Key)
	if err != nil {
		utils.LogMessage(err.Error())
		return
	}

	if roomExists {
		// Delete the existing room
		err = services.DeleteRedisKey("Room_" + room.Key)
		if err != nil {
			utils.LogMessage(err.Error())
			return
		}
	}

	var currentRank map[string]interface{}

	err = services.GameDB.Raw("EXEC maxion_get_avg_rank @character_name = ?;", room.Host).Scan(&currentRank).Error
	if err != nil {
		utils.LogMessage(err.Error())
		return
	}

	if val, ok := currentRank["summary"].(int64); ok {
		room.Rank = int(val)
	} else {
		room.Rank = 0
	}

	// แปลงเป็น JSON string
	roomJSON, err := json.Marshal(room)
	if err != nil {
		log.Println("Error: failed to marshal JSON", err)
		return
	}

	// บันทึก JSON ลง Redis
	err = services.PushRedis("Room_"+room.Key, string(roomJSON))
	if err != nil {
		log.Println("Error: failed to push JSON to Redis", err)
		return
	}

	err = services.SetRedisKey("Character_Room_"+room.Host, room.Key)
	if err != nil {
		log.Println("Error: failed to push JSON to Redis", err)
		return
	}

	// ส่งข้อความไปยังผู้ใช้งาน
	err = services.SendTCP(message.USER_MESSAGE_RANKING_CREATE_ROOM, "", character.Name)
	if err != nil {
		log.Println("Error: failed to send TCP message", err)
		return
	}

}

// เข้าร่วมห้อง
func JoinRoom(body string, character *models.CharacterInfo) {
	if body == "" {
		log.Println("Error: body is empty")
		return
	}

	// Split the message body
	parts := strings.Split(body, ",")
	if len(parts) < 2 {
		log.Println("Error: message body does not contain enough parts")
		return
	}

	roomKey := parts[0]
	characterName := parts[1]

	// Validate roomKey and characterName
	if roomKey == "" {
		var err error
		roomKey, err = services.GetRedisKey("Character_Room_" + characterName)
		if err != nil {
			log.Println("Error: failed to get room key from Redis", err)
			return
		}
		return
	}

	if characterName == "" {
		log.Println("Error: characterName is empty")
		return
	}

	// Prepare Redis key
	redisKey := strings.TrimSpace("Room_" + roomKey)

	// Retrieve room data from Redis as a list test
	roomJSONList, err := services.GetRedisKeyListValue(redisKey)
	if err != nil {
		log.Println("Error: failed to get room data from Redis", err)
		return
	}

	var room models.Room
	err = json.Unmarshal([]byte(strings.Join(roomJSONList, "")), &room)
	if err != nil {
		log.Println("Error: failed to parse room JSON", err)
		return
	}

	// Check if character is in room.Character or not if not exit then Push character to room.Character
	if !utils.Contains(room.Character, characterName) {
		room.Character = append(room.Character, characterName)
	}

	// Merge array to string from room.Character
	characters := strings.Join(room.Character, ",")

	// Recalculate rank using the characterName
	var currentRank map[string]interface{}
	err = services.GameDB.Raw("EXEC maxion_get_avg_rank @character_name = ?;", characters).Scan(&currentRank).Error
	if err != nil {
		log.Println("Error recalculating rank:", err)
		return
	}

	room.Rank = int(currentRank["summary"].(int64))

	// // Push the updated room data back to Redis using SET
	roomJSON, err := json.Marshal(room)
	if err != nil {
		log.Println("Error: failed to marshal room to JSON", err)
		return
	}

	err = services.UpdateRedisListIndex(redisKey, 0, string(roomJSON))
	if err != nil {
		log.Println("Error: failed to update room data in Redis", err)
		return
	}

	services.SendTCP(message.USER_MESSAGE_RANKING_JOIN_ROOM, "", character.Name)
}

// ออกจากห้อง
func LeaveRoom(body string, character *models.CharacterInfo) {
	if body == "" {
		log.Println("Error: body is empty")
		return
	}

	// Split the message body
	parts := strings.Split(body, ",")
	if len(parts) < 2 {
		log.Println("Error: message body does not contain enough parts")
		return
	}

	roomKey := parts[0]
	characterName := parts[1]

	// Validate roomKey and characterName
	if roomKey == "" {
		log.Println("Error: roomKey is empty")
		return
	}

	if characterName == "" {
		log.Println("Error: characterName is empty")
		return
	}

	// Prepare Redis key
	redisKey := strings.TrimSpace("Room_" + roomKey)

	// Retrieve room data from Redis as a list test
	roomJSONList, err := services.GetRedisKeyListValue(redisKey)
	if err != nil {
		log.Println("Error: failed to get room data from Redis", err)
		return
	}

	var room models.Room
	err = json.Unmarshal([]byte(strings.Join(roomJSONList, "")), &room)
	if err != nil {
		log.Println("Error: failed to parse room JSON", err)
		return
	}

	// Check if character is in room. if yes then remove character from room.Character
	if utils.Contains(room.Character, characterName) {
		room.Character = utils.RemoveStringFromSlice(room.Character, characterName)
	}

	// Merge array to string from room.Character
	characters := strings.Join(room.Character, ",")
	// Recalculate rank using the characterName
	var currentRank map[string]interface{}
	err = services.GameDB.Raw("EXEC maxion_get_avg_rank @character_name = ?;", characters).Scan(&currentRank).Error
	if err != nil {
		log.Println("Error recalculating rank:", err)
		return
	}

	val, ok := currentRank["summary"]
	if !ok {
		log.Println("Error: 'summary' key not found in currentRank:", currentRank)
		return
	}

	fval, ok := val.(float64)
	if !ok {
		log.Println("Error: 'summary' is not float64, got:", reflect.TypeOf(val))
		return
	}

	room.Rank = int(fval)

	// // Push the updated room data back to Redis using SET
	roomJSON, err := json.Marshal(room)
	if err != nil {
		log.Println("Error: failed to marshal room to JSON", err)
		return
	}

	err = services.UpdateRedisListIndex(redisKey, 0, string(roomJSON))
	if err != nil {
		log.Println("Error: failed to update room data in Redis", err)
		return
	}

	// Check if room is empty, if yes then delete the room
	if len(room.Character) == 0 {
		err = services.DeleteRedisKey(redisKey)
		if err != nil {
			log.Println("Error: failed to delete room", err)
			return
		}
	}
}
