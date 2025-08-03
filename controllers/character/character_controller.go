package character

import (
	"encoding/binary"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"maxion-zone4/models"
	databaseModel "maxion-zone4/models/database"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"os"
	"reflect"
	"regexp"
	"strconv"
	"strings"
	"time"

	"gorm.io/gorm"
)

const (
	staminaResetHour   = 6
	staminaResetMinute = 0
	statusFilePath     = "stamina_reset_status.txt"
)

// Nut Close
// func GetCharacterByKey(character_key string, character *models.CharacterInfo) {
// 	log.Print("Get Character By Key: ", character_key)

// 	var list []database.Character
// 	err := services.GameDB.Raw(`EXEC maxion_get_character_by_key @character_key = ?`, character_key).Scan(&list).Error
// 	if err != nil {
// 		return
// 	}

// 	var characterObj = list[0]
// 	wearCostumeOptionHex := hex.EncodeToString(characterObj.WearCostumeOption)

// 	response := fmt.Sprintf(
// 		"%d,%s,%d,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%d,%d,%d",
// 		characterObj.CharacterKey,
// 		strings.TrimSpace(characterObj.Name),
// 		characterObj.Type,
// 		strings.TrimSpace(characterObj.Style),
// 		characterObj.Promotion,
// 		characterObj.Money,
// 		characterObj.Level,
// 		characterObj.Experience,
// 		characterObj.LadderGroup,
// 		characterObj.LadderGrade,
// 		characterObj.LadderExp,
// 		characterObj.ClubKey,
// 		characterObj.WearCostumeFlag,
// 		wearCostumeOptionHex,
// 		characterObj.Attribute,
// 		characterObj.PromotionLevel,
// 		characterObj.CharacterColor,
// 	)

// 	log.Print("Response: ", response)

// 	// Send response to client
// 	err = services.SendTCP(message.USER_MESSAGE_GET_CHARACTER_BY_KEY_RETURN, response, character.Name)
// 	if err != nil {
// 		log.Print("Error sending response: ", err)
// 		return
// 	}
// }

func GetFriends(body string, character *models.CharacterInfo) {
	// Split message by comma first to get the character name from the message string
	if body != "" {
		character_name := body // Trim whitespace for safety

		var list []map[string]interface{}
		var result []map[string]interface{}
		err := services.GameDB.Raw(`EXEC maxion_get_friends @character_name_my = ?`, character_name).Scan(&list).Error
		if err != nil {
			return
		}

		for _, list := range list {
			if nameFriend, ok := list["name_friend"].(string); ok {
				if _, exists := services.Clients[strings.TrimSpace(nameFriend)]; exists {
					if nameFriend, ok := list["name_friend"].(string); ok {
						list["name_friend"] = strings.TrimSpace(nameFriend)
					}

					if name_my, ok := list["name_my"].(string); ok {
						list["name_my"] = strings.TrimSpace(name_my)
					}

					if gang_name, ok := list["gang_name"].(string); ok {
						list["gang_name"] = strings.TrimSpace(gang_name)
					}

					result = append(result, list)
				}
			}
		}

		response, err := json.Marshal(result)
		if err != nil {
			return
		}

		if response != nil && string(response) != "null" {

			log.Print("Response Get Friends: ", string(response))

			err = services.SendTCP(message.USER_MESSAGE_GET_FRIEND_RETURN_LIST, string(response), character.Name)
			if err != nil {
				log.Print("Error sending response: ", err)
				return
			}
		}
	} else {
		log.Print("Error: Invalid message body")
		return
	}
}

func GetFriendCount(character_name string, character *models.CharacterInfo) {
	var list map[string]interface{}
	err := services.GameDB.Raw(`EXEC maxion_get_friends_count @character_name_my = ?, @max_per_page = ?`, character_name, 10).Scan(&list).Error
	if err != nil {
		return
	}

	response, err := json.Marshal(list)
	if err != nil {
		return
	}

	log.Print("Response: ", string(response))

	err = services.SendTCP(message.USER_MESSAGE_GET_FRIEND_COUNT_RETURN, string(response), character.Name)
	if err != nil {
		log.Print("Error sending response: ", err)
		return
	}
}

func GetCharacterRankingInformation(body string, character *models.CharacterInfo) {
	// Split message by comma first to get the character name from the message string
	if body != "" {
		parts := strings.Split(body, ",")
		if len(parts) < 2 {
			log.Println("Error: message body does not contain enough parts")
			return
		}

		character_key := parts[0]
		index := parts[1]

		var list map[string]interface{}
		err := services.GameDB.Raw(`EXEC maxion_getcharacter_ranking @Character_ID = ?`, character_key).Scan(&list).Error
		if err != nil {
			return
		}

		// ต่อ string จาก list ที่ได้มา
		response := fmt.Sprintf(
			"%s,%d,%s,%s,%d,%d,%d,%d,%s,%d,%d,%d",
			index,
			list["RankID"],
			strings.TrimSpace(list["rank_name"].(string)),
			strings.TrimSpace(list["badge_path"].(string)),
			list["badge_pos_x"],
			list["badge_pos_y"],
			list["character_key"],
			list["current_rank"],
			strings.TrimSpace(list["name"].(string)),
			list["level"],
			list["rank_protection_points"],
			list["behaviour_score"],
		)

		log.Print("Response: ", string(response))

		err = services.SendTCP(message.USER_MESSAGE_GET_CHARACTER_RANKING_INFO_RETURN, string(response), character.Name)
		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}
	}
}

func ScheduleResetStamina() {

	for {
		now := time.Now()
		today := now.Format("2006-01-02")

		if !isAlreadyResetToday(today) {

			// Stamina reset time
			resetTime := time.Date(now.Year(), now.Month(), now.Day(), staminaResetHour, staminaResetMinute, 0, 0, now.Location())

			if now.Before(resetTime) {
				// Sleep until reset time
				time.Sleep(resetTime.Sub(now))
			}

			// Perform reset
			// err := resetStamina() // Nut Close
			// if err != nil {
			// 	log.Printf("Error resetting stamina: %v", err)
			// } else {
			// 	log.Printf("Stamina reset performed at %v", time.Now())
			// 	markResetComplete(today)
			// }
		}

		// Sleep until next day
		nextDay := now.Add(24 * time.Hour)
		nextDayMidnight := time.Date(nextDay.Year(), nextDay.Month(), nextDay.Day(), 0, 0, 0, 0, now.Location())
		time.Sleep(nextDayMidnight.Sub(now))
	}

}

func isAlreadyResetToday(date string) bool {
	content, err := os.ReadFile(statusFilePath)
	if err != nil {
		return false
	}
	return strings.Contains(string(content), date)
}

func markResetComplete(date string) {
	content := fmt.Sprintf("IsAlreadyResetStamina:%s\n", date)
	err := os.WriteFile(statusFilePath, []byte(content), 0644)
	if err != nil {
		log.Printf("Error writing reset status: %v", err)
	}
}

func resetStamina() error {

	var list map[string]interface{}
	err := services.GameDB.Raw(`EXEC maxion_reset_stamina`).Scan(&list).Error
	if err != nil {
		return fmt.Errorf("failed to reset stamina: %v", err)
	}
	return nil
}

func GetCharacterStamina(body string, character *models.CharacterInfo) {

	if body != "" {

		var character_key, err = strconv.Atoi(body)
		if err != nil {
			log.Print("Error in convert string to int: ", err)
		}

		var list map[string]interface{}
		err = services.GameDB.Raw(`SELECT stamina, level FROM dbo.character WHERE character_key = ?`, character_key).Scan(&list).Error
		if err != nil {
			log.Print("Error in GetCharacterStamina: ", err)
		}

		var maxStamina int
		err = services.GameDB.Raw(`EXEC maxion_characters_use_stamina ?, ?;`, body, 1).Scan(&maxStamina).Error

		if err != nil {
			log.Print("Error in GetCharacterStamina: ", err)
		}

		// combine string into stamina,maxStamina
		response := fmt.Sprintf("%d,%d", list["stamina"], maxStamina)

		err = services.SendTCP(message.USER_MESSAGE_GET_CHARACTER_STAMINA, response, character.Name)
		if err != nil {
			log.Print("Error in GetCharacterStamina: ", err)
		}
	}
}

func ValidateStaminaEntry(body string, character *models.CharacterInfo) {

	if body == "" {
		log.Print("Error: Invalid message body in ValidateStaminaEntry")
		return
	}

	// The body should be the character_key, enum level
	// need to split the body with comma

	parts := strings.Split(body, ",")
	if len(parts) < 2 {
		log.Println("Error: message body does not contain enough parts")
		return
	}

	character_key := parts[0]
	level := parts[1]

	// Convert the character_key to int
	characterKeyInt, err := strconv.Atoi(character_key)

	if err != nil {
		log.Print("Error converting character_key to int:", err)
		return
	}

	// For now every entry will require 4 stamina
	staminaRequirement := 4

	// TODO: Move this stamina requirement to sql server
	var list map[string]interface{}
	err = services.GameDB.Raw("EXEC maxion_validate_stamina_entry @character_key = ?, @stamina_requirement = ?", characterKeyInt, staminaRequirement).Scan(&list).Error
	if err != nil {
		log.Printf("Error executing maxion_validate_stamina_entry: %v", err)
		return
	}

	canEnter := list["CanEnter"].(bool)

	if !canEnter {

		log.Printf("Character %d cannot enter level %s due to not having enough stamina", characterKeyInt, level)
		err = services.SendTCP(message.USER_MESSAGE_REJECT_STAMINA_ENTRY, "0", character.Name)

		if err != nil {
			log.Printf("Error sending response: %v", err)
		}
		return
	}

	log.Printf("Character %d can enter level %s", characterKeyInt, level)

	// Send the response
	err = services.SendTCP(message.USER_MESSAGE_VALIDATE_STAMINA_ENTRY, level, character.Name)
	if err != nil {
		log.Printf("Error sending response: %v", err)
		return
	}

}

// GetCharacterInformation ใช้สำหรับดึงข้อมูลตัวละครจากฐานข้อมูล
func GetCharacterInformation(body string, character *models.CharacterInfo) {
	if body != "" {
		body = models.User
	}

	var information map[string]models.CharacterInfo
	err := services.GameDB.Raw(`EXEC tt_get_characters_by_user_key_ex_20100528 ?`, body).Scan(&information).Error
	if err != nil {
		log.Print("Error in GetCharacterInformation: ", err)
		return
	}
}

func SetCharacterInformation(body string) {
	log.Print("SetCharacterInformation" + body)
}

// Create By Nut Prisoner
// ---------------------------------------
var nameAllCharacter = "AllCharacter"

func getCharacterList(account string) string {
	var count int64
	services.GameDB.Table("dbo.AccountCharacter").Where("Id = ?", account).Count(&count)

	if count == 0 {
		log.Println("No Data Found for account:", account)

		// สร้างข้อมูลใหม่
		newChar := databaseModel.AccountCharacter{
			Id: account,
		}

		// INSERT ข้อมูลเข้า Database
		err := services.GameDB.Create(&newChar).Error
		if err != nil {
			log.Println("Insert Error:", err)
		} else {
			fmt.Println("Insert AccountCharacter Successful!", newChar)
		}
	}

	// Get Account Character Data
	var dataAccountCharacter databaseModel.AccountCharacter
	errAccountCharacter := services.GameDB.Table("dbo.AccountCharacter").Where("Id = ?", account).Find(&dataAccountCharacter).Error
	if errAccountCharacter != nil {
		log.Println("Query Error AccountCharacter:", errAccountCharacter)
	} else {
		fmt.Printf("Query Result AccountCharacter: %+v\n", reflect.ValueOf(dataAccountCharacter))
	}

	// Get Character Data
	type CharacterWithGuild struct {
		AccountID string `gorm:"column:AccountID"`
		Name      string `gorm:"column:Name"`
		Class     uint8  `gorm:"column:Class"`
		CLevel    int    `gorm:"column:CLevel"`
		MLevel    int    `gorm:"column:MLevel"`
		GStatus   uint8  `gorm:"column:G_Status"`
	}

	var dataCharacter []CharacterWithGuild
	errCharacter := services.GameDB.Table("Character").
		Select("Character.AccountID, Character.Name, Character.Class, Character.CLevel, Character.MLevel, GuildMember.G_Status").
		Joins("LEFT JOIN GuildMember ON Character.Name = GuildMember.Name").
		Where("Character.AccountID = ?", account).
		Find(&dataCharacter).Error

	if errCharacter != nil {
		log.Println("Query Error Character:", errCharacter)
	} else {
		log.Printf("Query Result Character: %+v\n", reflect.ValueOf(dataCharacter))
	}

	characterMap := make(map[string]struct {
		Class   uint8
		CLevel  int
		MLevel  int
		GStatus uint8
	})

	for _, char := range dataCharacter {
		characterMap[char.Name] = struct {
			Class   uint8
			CLevel  int
			MLevel  int
			GStatus uint8
		}{
			Class:   char.Class,
			CLevel:  char.CLevel,
			MLevel:  char.MLevel,
			GStatus: char.GStatus,
		}
	}

	log.Printf("Query Result (Map): %+v\n", characterMap)

	// ใช้ Reflection ตรวจสอบ GameID1 - GameID10
	v := reflect.ValueOf(dataAccountCharacter)
	var gameIDs []string

	for i := 1; i <= 10; i++ {
		fieldName := fmt.Sprintf("GameID%d", i)
		field := v.FieldByName(fieldName)

		// ตรวจสอบว่า Field มีอยู่จริงและสามารถเข้าถึงได้
		if !field.IsValid() {
			log.Println("Field Not Found:", fieldName)
			gameIDs = append(gameIDs, "null")
			continue
		}

		// ถ้าเป็น `string` ธรรมดา
		if field.Kind() == reflect.String {
			key := field.String()
			if key == "" {
				gameIDs = append(gameIDs, "null")
			} else if dataChar, found := characterMap[key]; found {
				numLevel := dataChar.CLevel + dataChar.MLevel
				gameIDs = append(gameIDs, key+"-"+strconv.Itoa(int(dataChar.Class))+"-"+strconv.Itoa(numLevel)+"-"+strconv.Itoa(int(dataChar.GStatus)))
			} else {
				gameIDs = append(gameIDs, "null")
			}
			continue
		}

		// ถ้าเป็น Pointer ไปที่ String (`*string`)
		if field.Kind() == reflect.Ptr {
			if field.IsNil() {
				log.Println("⚠️", fieldName, "is nil")
				gameIDs = append(gameIDs, "null")
			} else {
				key := field.Elem().String()
				if dataChar, found := characterMap[key]; found {
					numLevel := dataChar.CLevel + dataChar.MLevel
					gameIDs = append(gameIDs, key+"-"+strconv.Itoa(int(dataChar.Class))+"-"+strconv.Itoa(numLevel)+"-"+strconv.Itoa(int(dataChar.GStatus)))
				} else {
					gameIDs = append(gameIDs, "null")
				}
			}
			continue
		}

		// ถ้าไม่ใช่ `string` หรือ `*string` ให้ใส่ `null`
		log.Println("Invalid Field Type:", fieldName)
		gameIDs = append(gameIDs, "null")
	}

	// รวมค่าเป็น String
	result := strings.Join(gameIDs, ",")
	log.Println("AllCharacter:", result)

	return result
}

func GetCharList(Body string, username string) {
	fmt.Print("GetCharList")
	nameAllCharacter = getCharacterList(username)

	if nameAllCharacter != "" {
		fmt.Println("GetCharList Username: ", username)
		fmt.Println("GetCharList Result: ", nameAllCharacter)
		services.SendTCPUser(message.USER_MESSAGE_GET_CHARACTER_LIST, nameAllCharacter, username)
		// return nameAllCharacter
	} else {
		fmt.Println("GetCharList Error: ", Body)
		// return ""
	}
}

func LoadDataCharacter(body string, username string) {
	fmt.Println("LoadDataCharacter: ", body)
	fmt.Println("LoadDataCharacter: ", username)

	var data []databaseModel.Character
	err := services.GameDB.Table("Character").Select("AccountID, Name, cLevel, Class, Inventory").Where("AccountID = ?", username).Find(&data).Error
	if err != nil {
		log.Println("Query Error:", err)
	} else {
		// log.Printf("Query Result: %+v\n", len(data))

		var character string

		// วนลูปแสดงผลทีละแถว
		for _, char := range data {

			// var rawInventory []byte

			fmt.Printf("AccountID: %s, Name: %s, Level: %d, Class: %d\n", char.AccountID, char.Name, char.CLevel, char.Class)
			character += fmt.Sprintf(";AccountID:%s,Name:%s,Level:%d,Class:%d", char.AccountID, char.Name, char.CLevel, char.Class)

			// inventory := ConvertRawInventory(rawInventory)
			// // แปลงข้อมูลเป็น Item Array
			// items := ConvertInventory(inventory)

			// for i, item := range items {
			// 	if !item.IsEmpty {
			// 		section, index := GetItemSectionAndIndex(item.ItemType)
			// 		fmt.Printf("Slot %d - ItemType: %d, IsEmpty: %t , %d, %d\n", i, item.ItemType, item.IsEmpty, section, index)
			// 	}
			// }
		}

		if len(character) > 0 {
			fmt.Println("data:", character)
			services.SendTCPUser(message.USER_MESSAGE_UPDATE_CHARACTER_LIST, nameAllCharacter, username)
		} else {
			services.SendTCPUser(message.USER_MESSAGE_UPDATE_CHARACTER_LIST_ERROR, "Error Update Character List : ", username)
		}
	}
}

const InventoryBinarySize = 32 // ขนาดของข้อมูล Inventory ที่ดึงจากฐานข้อมูล
const MaxInventoryItems = 12   // จำนวนไอเท็มสูงสุดที่ต้องดึง
const InventoryEntrySize = 4

type InventoryItem struct {
	ItemType uint16
	IsEmpty  bool
}

// แปลง `dbInventory` เป็น `InventoryItem[]`
func ConvertInventory(dbInventory []byte) []InventoryItem {
	var items []InventoryItem

	// ตรวจสอบขนาดของ dbInventory (ต้องมีอย่างน้อย 4 ไบต์ต่อไอเท็ม)
	if len(dbInventory) < InventoryEntrySize*MaxInventoryItems {
		fmt.Println("Error: Inventory data is too short! Expected:", InventoryEntrySize*MaxInventoryItems, "Got:", len(dbInventory))
		return nil
	}

	for i := 0; i < MaxInventoryItems; i++ {
		offset := i * InventoryEntrySize // ใช้ 4 ไบต์ต่อไอเท็ม

		itemTypeLow := uint16(dbInventory[offset])
		itemType9thBit := (uint16(dbInventory[offset+2]) & 0x80) >> 7
		itemType10to13 := (uint16(dbInventory[offset+3]) & 0xF0) >> 4

		itemType := itemTypeLow | (itemType9thBit << 8) | (itemType10to13 << 9)

		isEmpty := dbInventory[offset] == 0xFF && itemType9thBit == 1 && itemType10to13 == 0xF

		items = append(items, InventoryItem{
			ItemType: itemType,
			IsEmpty:  isEmpty,
		})
	}

	return items
}

func ConvertRawInventory(rawInventory []byte) []byte {

	dbInventory := make([]byte, MaxInventoryItems*4) // 4 ไบต์ต่อไอเท็ม

	if len(rawInventory) < MaxInventoryItems*4 {
		return dbInventory
	}

	for i := 0; i < MaxInventoryItems; i++ {
		offset := i * InventoryBinarySize // ตำแหน่งเริ่มต้นของไอเท็ม
		dbOffset := i * 4                 // ตำแหน่งของ dbInventory (เก็บ 4 ไบต์ต่อไอเท็ม)

		if rawInventory[offset] == 0xFF && (rawInventory[offset+7]&0x80) == 0x80 && (rawInventory[offset+10]&0xF0) == 0xF0 {
			// ไอเท็มว่าง
			dbInventory[dbOffset] = 0xFF
			dbInventory[dbOffset+1] = 0xFF
			dbInventory[dbOffset+2] = 0xFF
			dbInventory[dbOffset+3] = 0xFF
		} else {
			// ไอเท็มจริง
			dbInventory[dbOffset] = rawInventory[offset]     // 8 บิตแรกของ ItemType
			dbInventory[dbOffset+1] = rawInventory[offset+1] // Item Level
			dbInventory[dbOffset+2] = rawInventory[offset+7] // 8-bit บิตที่ 9
			dbInventory[dbOffset+3] = rawInventory[offset+9] // 9-12 บิตของ ItemType
		}
	}

	return dbInventory
}

// แปลง ItemType เป็น Section และ Index
func GetItemSectionAndIndex(itemType uint16) (section int, index int) {
	section = int(itemType) / 512
	index = int(itemType) % 512
	return section, index
}

func CharacterSelect(body string, username string) {
	parts := strings.Split(body, ",")
	if len(parts) < 3 {
		log.Println("Invalid data format, expected")
		return
	}

	characterName := parts[2] // ดึงค่าชื่อตัวละคร
	accountID := parts[0]     // แปลง string -> int

	log.Println("characterName:", characterName, accountID)

	var data databaseModel.Character
	result := services.GameDB.Table("Character").Select("AccountID, Name, cLevel, Class, Life, MaxLife, Mana, MaxMana, Inventory, MapNumber, MapPosX, MapPosY").Where("Name = ?", characterName).First(&data)
	if result.Error != nil {
		if result.Error == gorm.ErrRecordNotFound {
			log.Println("Character not found", characterName)
		} else {
			log.Println("Database error:", result.Error)
		}
	} else {
		log.Println("Character found:", data.Name)
		log.Printf("Query Result: %+v\n", reflect.ValueOf(data))
	}

	items := SendInventoryToClient(data.Inventory)
	zoneID := data.MapNumber

	// สร้างโครงสร้าง JSON
	response := map[string]interface{}{
		"AccountID": data.AccountID,
		"Name":      data.Name,
		"Level":     data.CLevel,
		"Class":     data.Class,
		"Life":      data.Life,
		"MaxLife":   data.MaxLife,
		"Mana":      data.Mana,
		"MaxMana":   data.MaxMana,
		"Items":     json.RawMessage(items), // JSON Inventory
		"MapNumber": data.MapNumber,
		"MapPosX":   data.MapPosX,
		"MapPosY":   data.MapPosY,
	}

	// แปลงเป็น JSON String
	responseJSON, err := json.Marshal(response)
	if err != nil {
		log.Println("JSON Marshal failed:", err)
		return
	}

	fmt.Println("responseJSON : ", string(responseJSON))

	//fmt.Printf("items: %s", items)

	// ส่งมอนสเตอร์ทั้งหมดใน zone ไปยัง client หลังเลือกตัวละครสำเร็จ
	services.SendAllMonstersToPlayer(int(zoneID), func(dataResponse []byte) {
		services.SendTCPUser(message.SERVER_MESSAGE_MONSTER_CREATE, string(dataResponse), username)
	})

	// ลงทะเบียนเมื่อ Player login เข้ามา
	services.PlayerRegis(accountID, characterName, int(zoneID), data)

	services.SendTCPUser(message.USER_MESSAGE_SET_SELECT_CHARACTER, string(responseJSON), username)

	log.Println("Player: ", accountID)
	log.Println("Selected Character: ", characterName)
}

// ขนาดของไอเท็มใน database (32 ไบต์)
const ItemSize = 32

// โครงสร้างข้อมูลไอเท็ม
type Item struct {
	Index                int     `json:"index"`                   // ตำแหน่งในกระเป๋า (Inventory Slot)
	Type                 uint16  `json:"type"`                    // ค่ารวม Section << 8 | ItemIndex
	Section              byte    `json:"section"`                 // หมวดหมู่ของไอเท็ม เช่น 6 = โล่
	ItemIndex            byte    `json:"item_index"`              // ลำดับของไอเท็มใน Section นั้น
	Level                byte    `json:"level"`                   // ระดับไอเท็ม เช่น +9
	Option1              byte    `json:"option1"`                 // ออปชันพิเศษ (Excellent)
	Option2              byte    `json:"option2"`                 // Luck Option (โชค)
	Option3              byte    `json:"option3"`                 // Additional Option (เสริม)
	Durability           byte    `json:"durability"`              // ความคงทนของไอเท็ม
	Serial               uint64  `json:"serial"`                  // หมายเลขเฉพาะของไอเท็ม (ไม่ซ้ำกัน)
	OptionNew            byte    `json:"option_new"`              // ออปชันเสริมเพิ่มเติม
	SetOption            byte    `json:"set_option"`              // ค่าเซตไอเท็ม เช่น Ancient/Socket Set
	SocketOptions        [5]byte `json:"socket_options"`          // ค่า Socket (0xFF = ช่องว่าง)
	SocketBonusOption    byte    `json:"socket_bonus_option"`     // โบนัสเมื่อใส่ Socket ครบ
	PeriodItemOption     byte    `json:"period_item_option"`      // ไอเท็มแบบจำกัดเวลา (1 = ใช่)
	JewelOfHarmonyOption byte    `json:"jewel_of_harmony_option"` // ค่า Harmony Option จาก Jewel
	ItemEffectEx         byte    `json:"item_effect_ex"`          // เอฟเฟกต์พิเศษ เช่น Wing, Glow
	MainAttribute        byte    `json:"main_attribute"`          // ธาตุหลักของไอเท็ม (เช่น ไฟ, น้ำ)
}

func SendInventoryToClient(data []byte) string {
	const ItemSize = 32

	// ✅ ตรวจสอบขนาดข้อมูล
	if len(data)%ItemSize != 0 {
		fmt.Printf("invalid inventory data length: %d bytes (not divisible by %d)\n", len(data), ItemSize)
		return "{}" // ส่ง JSON เปล่า
	}

	itemCount := len(data) / ItemSize
	items := make([]Item, 0, itemCount)

	// ✅ แปลงข้อมูลแต่ละไอเท็ม
	for i := 0; i < itemCount; i++ {
		start := i * ItemSize
		end := start + ItemSize

		item, isEmpty := ConvertItem(data[start:end], i)
		if item == nil || isEmpty {
			continue
		}
		items = append(items, *item)
	}

	// ✅ แปลง slice เป็น JSON
	jsonData, err := json.Marshal(items)
	if err != nil {
		fmt.Printf("error encoding inventory json: %v\n", err)
		return "{}"
	}

	return string(jsonData)
}

// แปลง byte array เป็น Item Struct
func ConvertItem(data []byte, inventoryIndex int) (*Item, bool) {
	const ItemSize = 32
	if len(data) < ItemSize {
		fmt.Println("invalid item data length:", len(data))
		return nil, true
	}

	// ถอดค่า itemType จาก 3 ช่วงบิต
	itemTypeLow := uint16(data[0])
	itemType9thBit := (uint16(data[7]) & 0x80) >> 7 // bit 7 ของ byte[7]
	itemType10to13 := (uint16(data[9]) & 0xF0) >> 4 // bit 4-7 ของ byte[9]
	itemType := itemTypeLow | (itemType9thBit << 8) | (itemType10to13 << 9)

	section := byte(itemType >> 8)     // บิต 8-13 = Section
	itemIndex := byte(itemType & 0xFF) // บิต 0-7 = Index ภายใน Section

	// ตรวจสอบว่าเป็นไอเท็มว่าง (Empty Slot)
	isEmpty := data[0] == 0xFF && itemType9thBit == 1 && itemType10to13 == 0xF
	if isEmpty {
		return nil, true
	}

	// อ่าน Serial 64-bit (Hi << 32 | Lo)
	serialLo := binary.LittleEndian.Uint32(data[16:20])
	serialHi := binary.LittleEndian.Uint32(data[20:24])
	serial := (uint64(serialHi) << 32) | uint64(serialLo)

	return &Item{
		Index:                inventoryIndex,
		Type:                 itemType,
		Section:              section,
		ItemIndex:            itemIndex,
		Level:                (data[2] >> 3) & 0x0F,
		Option1:              (data[2] >> 7) & 0x01,
		Option2:              (data[2] >> 2) & 0x01,
		Option3:              data[2] & 0x03,
		Durability:           data[3],
		Serial:               serial,
		OptionNew:            data[8],
		SetOption:            data[9],
		SocketOptions:        [5]byte{data[10], data[11], data[12], data[13], data[14]},
		SocketBonusOption:    data[15],
		PeriodItemOption:     (data[9] >> 1) & 0x01,
		JewelOfHarmonyOption: data[10],
		ItemEffectEx:         data[11],
		MainAttribute:        data[12],
	}, false
}

type DataDefaultClass struct {
	Class      int `json:"class" gorm:"column:Class"`
	Strength   int `json:"strength" gorm:"column:Strength"`
	Dexterity  int `json:"dexterity" gorm:"column:Dexterity"`
	Vitality   int `json:"vitality" gorm:"column:Vitality"`
	Energy     int `json:"energy" gorm:"column:Energy"`
	Leadership int `json:"leadership" gorm:"column:Leadership"`
}

func GetDefaultClassData(classID int) (databaseModel.DefaultClassType, error) {
	var data databaseModel.DefaultClassType

	// Query จากฐานข้อมูล
	result := services.GameDB.Table("DefaultClassType").Select("Class, Strength, Dexterity, Vitality, Energy, Leadership").Where("Class = ?", classID).First(&data)

	// ถ้ามี Error ระหว่าง Query
	if result.Error != nil {
		log.Println("Query Error:", result.Error)
		return data, errors.New("Error loading default class type query")
	}

	// ถ้าไม่มีข้อมูล
	if result.RowsAffected == 0 {
		log.Println("⚠️ No data found for class ID:", classID)
		return data, errors.New("No data found for class ID")
	}

	log.Println("Query Result:", reflect.ValueOf(data))
	return data, nil
}

func LoadDefaultClassType(body string, username string) {
	fmt.Println("LoadDefaultClassType: ", body)
	fmt.Println("LoadDefaultClassType: ", username)

	// แปลง `body` เป็น `int`
	classID, err := strconv.Atoi(body)
	if err != nil {
		log.Println("Invalid Class ID:", body)
		services.SendTCPUser(message.USER_MESSAGE_LOAD_DEFAULT_CLASS_ERROR, "Error Load Default Class Type: Invalid Class ID", username)
		return
	}

	data, err := GetDefaultClassData(classID)
	if err != nil {
		fmt.Println(err.Error())
		services.SendTCPUser(message.USER_MESSAGE_LOAD_DEFAULT_CLASS_ERROR, err.Error(), username)
		return
	}

	// แปลงเป็น JSON
	jsonData, err := json.Marshal(data)
	if err != nil {
		log.Println("Error converting to JSON:", err)
		services.SendTCPUser(message.USER_MESSAGE_LOAD_DEFAULT_CLASS_ERROR, "Error Load Default Class Type Convert JSON", username)
		return
	}

	// ส่งข้อมูลกลับ
	services.SendTCPUser(message.USER_MESSAGE_LOAD_DEFAULT_CLASS_RETURN, string(jsonData), username)
}

func ExecCreateCharacter(accountID, name string, class, serverCode int) (int, error) {
	// var rawResult []byte
	// err := services.GameDB.Raw("EXEC Maxion_CreateCharacter @AccountID = ?, @Name = ?, @Class = ?, @ServerCode = ?", accountID, name, class, serverCode).Scan(&rawResult).Error
	// if err != nil {
	// 	return 0, fmt.Errorf("SQL execution failed: %w", err)
	// }
	// if len(rawResult) == 0 {
	// 	return 0, fmt.Errorf("empty result from stored procedure")
	// }
	// // Convert first byte to int
	// result := int(rawResult[0])
	// return result, nil

	row := services.GameDB.Raw("EXEC Maxion_CreateCharacter @AccountID = ?, @Name = ?, @Class = ?, @ServerCode = ?", accountID, name, class, serverCode).Row()
	var resultBytes []byte
	if err := row.Scan(&resultBytes); err != nil {
		return 0, err
	}
	if len(resultBytes) == 0 {
		return 0, fmt.Errorf("empty result")
	}
	return int(resultBytes[0]), nil
}

func CreateCharacter(body string, username string) {
	// body = AccountId,ServerCode,CharName,ClassId
	fmt.Println("CreateCharacter Body: ", body)

	parts := strings.Split(body, ",")

	if len(parts) < 4 {
		log.Println("Invalid data format")
		return
	}

	accountId := parts[0]
	svCode := parts[1]
	charName := parts[2]
	class := parts[3]

	matched, err := regexp.MatchString(`^[a-zA-Z0-9_ ]+$`, charName)
	if err != nil {
		log.Println("Regex error:", err)
		return
	}

	if !matched {
		log.Println("❌ Invalid character name:", charName)
		services.SendTCPUser(message.USER_MESSAGE_CREATE_CHARACTER_ERROR, "Invalid character name: only A-Z, a-z, 0-9, space, and underscore (_) allowed", username)
		return
	}

	fmt.Println("CreateCharacter AccountId: ", accountId)
	fmt.Println("CreateCharacter ServerCode: ", svCode)
	fmt.Println("CreateCharacter CharName: ", charName)
	fmt.Println("CreateCharacter ClassId: ", class)

	// แปลง `body` เป็น `int`
	classId, err := strconv.Atoi(class)
	if err != nil {
		log.Println("Invalid Class ID:", class)
		return
	}

	serverCode, err := strconv.Atoi(svCode)
	if err != nil {
		log.Println("Invalid Server Code:", svCode)
		return
	}

	result, err := ExecCreateCharacter(accountId, charName, classId, serverCode)
	if err != nil {
		log.Println("Error occurred while creating character: ", err)
	}

	msg := "Character name already exists"
	event := message.USER_MESSAGE_CREATE_CHARACTER_ERROR

	switch result {
	case 0x01:
		msg = "Character created successfully!"
		event = message.USER_MESSAGE_CREATE_CHARACTER_RETURN
	case 0x03:
		msg = "No available slot to create a character"
		event = message.USER_MESSAGE_CREATE_CHARACTER_RETURN
	case 0x02:
		msg = "Unknown error occurred"
		event = message.USER_MESSAGE_CREATE_CHARACTER_RETURN
	}

	fmt.Println("CreateCharacter Return: ", msg)
	services.SendTCPUser(event, msg, username)
}

func LoadMonsterCreate(body string, username string) {
	parts := strings.Split(body, ",")
	accountID := parts[0]
	zoneID, _ := strconv.Atoi(parts[1])

	services.PlayerManager.Players[accountID].ZoneID = zoneID

	// ส่งมอนสเตอร์ทั้งหมดใน zone ไปยัง client หลังเลือกตัวละครสำเร็จ
	services.SendAllMonstersToPlayer(zoneID, func(dataResponse []byte) {
		services.SendTCPUser(message.SERVER_MESSAGE_MONSTER_CREATE, string(dataResponse), accountID)
	})
}
