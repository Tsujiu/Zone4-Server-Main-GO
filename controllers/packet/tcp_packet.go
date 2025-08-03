package packet

import (
	"fmt"
	"log"
	character_controller "maxion-zone4/controllers/character"
	server_controller "maxion-zone4/controllers/server"
	user_controller "maxion-zone4/controllers/user"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"strconv"
	"strings"
)

var packetHandlerSingle = map[int]func(body string, username string){
	message.USER_MESSAGE_1200:                 user_controller.LoginUser,
	message.USER_MESSAGE_SELECT_CHARACTER:     character_controller.GetCharList,
	message.USER_MESSAGE_GET_CHARACTER_INFO:   character_controller.LoadDataCharacter,
	message.USER_MESSAGE_CHARACTER_STATUS:     user_controller.GetAccountRequest,
	message.USER_MESSAGE_GET_CHARACTER_SELECT: character_controller.CharacterSelect,
	message.SERVER_MESSAGE_GET_SERVER_LIST:    server_controller.GetServerList,
	message.SERVER_MESSAGE_GET_CHANNEL_LIST:   server_controller.GetChannelList,
	message.SERVER_MESSAGE_SELECT_CHANNEL:     server_controller.SelectChannel,
	message.USER_MESSAGE_LOAD_DEFAULT_CLASS:   character_controller.LoadDefaultClassType,
	message.USER_MESSAGE_CREATE_CHARACTER:     character_controller.CreateCharacter,
	message.USER_MESSAGE_SERVER_LOGOUT_USER:   user_controller.RemoveOnlineUser,
	message.SERVER_MESSAGE_LOAD_MONSTER:       character_controller.LoadMonsterCreate,
}

var packetHandlers = map[int]func(body string, character *models.CharacterInfo){
	// message.USER_MESSAGE_1200: user_controller.LoginUser,
}

// func ProcessTCP(packet string) {
// 	if packet == "" {
// 		log.Println("Invalid Packet from client")
// 		return
// 	}

// 	if len(packet) < 10 {
// 		log.Println("Invalid Packet Size from client")
// 		return
// 	}

// 	_, err := strconv.Atoi(packet[:10])
// 	if err != nil {
// 		log.Println("Invalid Size from packet: ", err)
// 		return
// 	}

// 	header, err := strconv.Atoi(strings.Split(packet[10:], "|")[0])
// 	if err != nil {
// 		log.Println("Invalid Header from packet: ", err)
// 		return
// 	}

// 	body := strings.Split(packet, "|")[1]
// 	if body == "" {
// 		log.Println("Invalid Body from packet: ", err)
// 		return
// 	}
// 	log.Println("Header msg: ", header)

// 	characterName := strings.Split(packet, "|")[2]
// 	if characterName == "" {
// 		log.Println("Invalid Character from packet: ", err)
// 		return
// 	} else {
// 		if !services.HasCharacter(characterName) {
// 			// Get User ID
// 			var user map[string]interface{}
// 			err := services.GameDB.Raw("SELECT user_key FROM dbo.character WHERE name = ?", characterName).Scan(&user).Error
// 			if err != nil {
// 				log.Println("Error in Get User ID: ", err)
// 				return
// 			}

// 			// Get Character Information
// 			var characters []models.CharacterInfo
// 			err = services.GameDB.Raw(`SET NOCOUNT ON; DECLARE @cnt INT; EXEC dbo.tt_get_characters_by_user_key_ex_20100528 @user_key = ?, @character_count=@cnt OUTPUT; SELECT @cnt AS character_count;`, user["user_key"]).Scan(&characters).Error
// 			if err != nil {
// 				log.Println("Error in Get Character Information: ", err)
// 				return
// 			}

// 			log.Print("Character: ", characters)

// 			for _, ch := range characters {
// 				ch.Name = strings.TrimSpace(ch.Name)
// 				services.SetCharacter(ch.Name, ch)
// 			}
// 		}
// 	}

// 	if handler, found := packetHandlers[header]; found {
// 		character, _ := services.GetCharacter(characterName)
// 		handler(body, &character)
// 	} else {
// 		log.Println("Unknown Packet Type")
// 	}
// }

func ProcessTCPSingle(packet string, username string) {
	if packet == "" {
		log.Println("Invalid Packet from client")
		return
	}

	header, err := strconv.Atoi(strings.Split(packet, "|")[0])
	if err != nil {
		log.Println("Invalid Header from packet: ", err)
		return
	}

	fmt.Println("ProcessTCPSingle packet: ", packet)

	body := strings.Split(packet, "|")[1]
	if body == "" {
		log.Println("Invalid Body from packet: ", err)
		return
	}
	if handler, found := packetHandlerSingle[header]; found {
		handler(body, username)
	} else {
		log.Println("Unknown Packet Type")
	}
	fmt.Println("Header msg: ", header)

}

func ProcessTCP(packet string) {
	if packet == "" {
		log.Println("Invalid Packet from client")
		return
	}

	header, err := strconv.Atoi(strings.Split(packet, "|")[0])
	if err != nil {
		log.Println("Invalid Header from packet: ", err)
		return
	}

	body := strings.Split(packet, "|")[1]
	if body == "" {
		log.Println("Invalid Body from packet: ", err)
		return
	}

	character := strings.Split(packet, "|")[2]
	if character == "" {
		log.Println("Invalid Body from packet: ", err)
		return
	}
	if handler, found := packetHandlers[header]; found {
		handler(body, nil)
	} else {
		log.Println("Unknown Packet Type")
	}

	fmt.Println("Header msg: ", header)

}
