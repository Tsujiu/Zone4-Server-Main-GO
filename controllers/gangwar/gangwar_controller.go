package gangwar

import (
	"log"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"strconv"
	"strings"
	"time"
)

// Gang war start day and time
const (
	gangWarStartDate time.Weekday = time.Wednesday
	gangWarStartHour int          = 20
)

func isCharacterGangLeader(characterKey int) (int, string) {

	// var gangKey int
	type Group struct {
		GangKey  int    `gorm:"column:n4GroupSN"`
		GangName string `gorm:"column:name"`
	}

	var gangDetails []Group
	result := services.GameDB.Table("group").
		Select("n4GroupSN", "name").
		Where("master_key = ? and alive_flag = 1", characterKey).
		Limit(1).
		Find(&gangDetails)

	if result.Error != nil {
		log.Println("Error: failed to get group data from database", result.Error)
		return -1, ""
	}

	if len(gangDetails) == 0 {
		return -1, ""
	}

	log.Println("Gang Key: ", gangDetails[0].GangKey)
	log.Println("Gang Name: ", gangDetails[0].GangName)

	return gangDetails[0].GangKey, gangDetails[0].GangName
}

func ExecuteGangWar() {
}

func ScheduleGangWar() {

	// Check if the gang war is already scheduled
	for {

		now := time.Now()
		nextGangWar := time.Date(now.Year(), now.Month(), int(gangWarStartDate), gangWarStartHour, 0, 0, 0, now.Location())

		// Check if the gang war is already scheduled
		if now.Before(nextGangWar) {
			time.Sleep(nextGangWar.Sub(now))
		}

		// Schedule the gang war

		// Wait for an hour to avoid scheduling multiple times
		time.Sleep(time.Hour)
	}
}

func GetParticipantsFromGangKey(body string, character *models.CharacterInfo) {

	if body == "" {
		log.Println("Error: body is empty")
		return
	}

	// Split the message body
	characterKey, err := strconv.Atoi(body)
	if err != nil {
		log.Println("Error: failed to convert character key to int", err)
		return
	}

	gangKey, gangName := isCharacterGangLeader(characterKey)

	if gangKey < 0 {
		log.Println("Error: sender character is not the guild's master")
		return
	}

	var participantsNames []string
	result := services.GameDB.Table("character").
		Select("character.name").
		Joins("INNER JOIN maxion_gangwar_registeration ON character.character_key = maxion_gangwar_registeration.character_key").
		Where("character.club_key = ?", gangKey).Pluck("name", &participantsNames)

	if result.Error != nil {
		log.Println("Error: failed to get participants from database", result.Error)
		return
	}

	if len(participantsNames) == 0 {
		log.Println("Error: no participants found")
		return
	}

	var response string

	response += gangName + ":"

	for i, name := range participantsNames {
		trimmedName := strings.TrimSpace(name)
		response += trimmedName
		if i < len(participantsNames)-1 {
			response += ","
		}

		log.Println("Participant name:", name)
	}

	err = services.SendTCP(message.USER_MESSAGE_GANGWAR_GET_PARTICIPANTS, response, character.Name)
	if err != nil {
		log.Println("Error: failed to send message", err)
		return
	}

}

func RegisterPlayers(body string, characterInfo *models.CharacterInfo) {

	// the body compose of the sender character key : then the receiver player name split by ,
	const requiredPlayerCount int = 3

	parts := strings.Split(body, ":")

	// First check if this character is truly the gang's leader
	senderCharacterKey := parts[0]

	if senderCharacterKey == "" {
		log.Println("Error: sender character key is empty")
		return
	}

	characterKey, err := strconv.Atoi(senderCharacterKey)
	if err != nil {
		log.Println("Error: failed to convert character key to int", err)
		return
	}

	gangKey, _ := isCharacterGangLeader(characterKey)

	if gangKey < 0 {
		log.Println("Error: sender character is not the guild's master")
		return
	}

	// Check if player exist in database
	characterNames := strings.Split(parts[1], ",")
	if len(characterNames) != requiredPlayerCount {
		log.Println("Error: not enough player names provided")
		return
	}

	type Participant struct {
		CharacterKey int `gorm:"column:character_key"`
		UserKey      int `gorm:"column:user_key"`
		GangKey      int `gorm:"column:n4GroupSN"`
		MemberLevel  int `gorm:"column:grade"`
	}

	var participants []Participant
	result := services.GameDB.Table("character").
		Select("character.character_key, character.user_key, group_user.n4GroupSN, group_user.grade").
		Joins("INNER JOIN group_user ON character.character_key = group_user.character_key").
		Where("character.name IN ?", characterNames).
		Find(&participants)

	if result.Error != nil {
		log.Println("Error: failed to get character data from database", result.Error)
		return
	}

	if len(participants) != requiredPlayerCount {
		log.Println("Error: some players are not found in the database")
		return
	}

	// Create a map to store user_keys
	userKeys := make(map[int]bool)

	// Check if the all the players are in the same gang
	// Check if all the characters belong to the same user
	// Check if all characters are members
	const requiredMemberLevel int = 5

	var participantsString string
	for i, character := range participants {

		if character.GangKey != gangKey {
			log.Println("Error: not all the players are in the same gang")
			services.SendTCP(message.USER_MESSAGE_GANGWAR_REGISTER_PLAYERS, "8006", characterInfo.Name)
			return
		}

		userKey := character.UserKey
		if userKeys[userKey] {
			log.Println("Error: some characters belong to the same user")
			services.SendTCP(message.USER_MESSAGE_GANGWAR_REGISTER_PLAYERS, "8007", characterInfo.Name)
			return
		}

		if character.MemberLevel > requiredMemberLevel {
			log.Println("Error: not all the players are members yet")
			services.SendTCP(message.USER_MESSAGE_GANGWAR_REGISTER_PLAYERS, "8008", characterInfo.Name)
			return
		}

		participantsString += strconv.Itoa(character.CharacterKey)

		if i < len(participants)-1 {
			participantsString += ","
		}

		userKeys[userKey] = true
	}

	result = services.GameDB.Exec("maxion_gangwar_register_players ?, ?", gangKey, participantsString)
	if result.Error != nil {
		log.Println("Error: failed to register players in database", result.Error)
		return
	}

	err = services.SendTCP(message.USER_MESSAGE_GANGWAR_REGISTER_PLAYERS, "1", characterInfo.Name)
	if err != nil {
		log.Printf("Error sending TCP message: %s", err)
		return
	}

}

// func RequestRegisterationMenu(body string) {

// 	if body == "" {
// 		log.Println("Error: body is empty")
// 		return
// 	}

// 	characterKey, error := strconv.Atoi(body)

// 	if error != nil {
// 		log.Println("Error: failed to convert character key to int", error)
// 		return
// 	}

// 	var gangName string
// 	result := services.GameDB.Table("group").Select("name").Where("master_key = ? and alive_flag = 1", characterKey).Limit(1).Pluck("name", &gangName)
// 	if result.Error != nil {
// 		log.Println("Error: failed to get group data from database", result.Error)
// 		return
// 	}

// 	if result.Error != nil {
// 		log.Println("Error: failed to get group data from database", result.Error)
// 		return
// 	}

// 	if gangName == "" {
// 		log.Println("Error: gang name is empty")
// 		err := services.SendTCP(message.USER_MESSAGE_GANGWAR_REQUEST_MENU, "0")
// 		if err != nil {
// 			log.Printf("Error sending TCP message: %s", err)
// 		}
// 		return
// 	}

// 	trimmedGangName := strings.TrimSpace(gangName)

// 	err := services.SendTCP(message.USER_MESSAGE_GANGWAR_REQUEST_MENU, trimmedGangName)
// 	if err != nil {
// 		log.Printf("Error sending TCP message: %s", err)
// 		return
// 	}
// }
