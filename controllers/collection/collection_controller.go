package collection

import (
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"strconv"
	"strings"
)

type DTOMyCollectionInput struct {
	CharacterKey int `json:"character_key"`
}

func GetAllListItemCollection(body string, character *models.CharacterInfo) {

	// ================ ได้ข้อมูลมาจาก Redis collection_list ================
	dataCollectionList, err := services.GetRedisKey("collection_list")
	if err != nil {
		log.Println("Error getting dataCollectionList from Redis:", err)
		return
	}

	err = services.SendTCP(message.USER_MESSAGE_COLLECTION_GET_MY_COLLECTION_RETURN, string(dataCollectionList), character.Name)
	if err != nil {
		log.Print("Error sending response: ", err)
		return
	}
}

func SendMailCollection(body string, character *models.CharacterInfo) {

	if body != "" {

		messageSplit := strings.Split(body, ",")
		// ตรวจสอบค่า messageSplit เพื่อแทนค่า null
		var character_key_to, item_number, item_duration, item_count, title, messageMail, coin, gran, category_id, collection_id interface{}
		if len(messageSplit) > 0 && messageSplit[0] != "" {
			character_key_to = messageSplit[0]
		} else {
			character_key_to = nil
		}

		if len(messageSplit) > 1 && messageSplit[1] != "" {
			item_number = messageSplit[1]
		} else {
			item_number = nil
		}

		if len(messageSplit) > 2 && messageSplit[2] != "" {
			item_duration = messageSplit[2]
		} else {
			item_duration = nil
		}

		if len(messageSplit) > 3 && messageSplit[3] != "" {
			item_count = messageSplit[3]
		} else {
			item_count = nil
		}

		if len(messageSplit) > 4 && messageSplit[4] != "" {
			title = messageSplit[4]
		} else {
			title = nil
		}

		if len(messageSplit) > 5 && messageSplit[5] != "" {
			messageMail = messageSplit[5]
		} else {
			messageMail = nil
		}

		if len(messageSplit) > 6 && messageSplit[6] != "" {
			coin = messageSplit[6]
		} else {
			coin = nil
		}

		if len(messageSplit) > 7 && messageSplit[7] != "" {
			gran = messageSplit[7]
		} else {
			gran = nil
		}

		if len(messageSplit) > 8 && messageSplit[8] != "" {
			category_id = messageSplit[8]
		} else {
			category_id = nil
		}

		if len(messageSplit) > 9 && messageSplit[9] != "" {
			collection_id = messageSplit[9]
		} else {
			collection_id = nil
		}

		var list []map[string]interface{}
		err := services.GameDB.Raw(`EXEC maxion_send_mail @character_key_to = ?, @item_number = ? , @item_duration = ? , @item_count = ? ,@title = ? , @message = ? , @coin = ? , @gran = ? `,
			character_key_to, item_number, item_duration, item_count, title, messageMail, coin, gran).Scan(&list).Error

		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}

		var update_receive_rewards []map[string]interface{}
		errReward := services.GameDB.Raw(`EXEC maxion_crud_character_collection @character_key= ?, @collection_id= ?, @category_id= ?, @status= ?, @receive_rewards= ?, @mode = 4`,
			character_key_to, category_id, collection_id, "receive", 1).Scan(&update_receive_rewards).Error

		if errReward != nil {
			log.Print("Error sending response: ", errReward)
			return
		}

		var listHistory []map[string]interface{}
		errHistory := services.GameDB.Raw(`EXEC maxion_get_history_item_collection @character_key = ?, @category_id = ?`, character_key_to, category_id).Scan(&listHistory).Error
		if errHistory != nil {
			log.Print("Error sending response: ", err)
			return
		}
		// ข้อมูลจาก DB โดยเช็คว่ามีของชิ้นนี้ในกระเป๋าจิงๆหรือไม่
		response_listHistory, errHistory := json.Marshal(listHistory)
		if errHistory != nil {
			log.Print("Error sending response_items: ", errHistory)
			return
		}

		log.Print("Response Inventory : ", string(response_listHistory))

		errHistory = services.SendTCP(message.USER_MESSAGE_COLLECTION_COMPLETE_MY_COLLECTION_RETURN, string(response_listHistory), character.Name)
		if errHistory != nil {
			log.Print("Error sending response: ", errHistory)
			return
		}

	} else {
		log.Print("Error in Function SendMailCollection : Invalid message body")
		return
	}

}

// RegisterItemToCollection
func HistoryItemCollection(body string, character *models.CharacterInfo) {
	if body != "" {

		messageSplit := strings.Split(body, ",")
		// ตรวจสอบค่า messageSplit เพื่อแทนค่า null
		var character_key, category_id interface{}
		if len(messageSplit) > 0 && messageSplit[0] != "" {
			character_key = messageSplit[0]
		} else {
			character_key = nil
		}

		if len(messageSplit) > 1 && messageSplit[1] != "" {
			category_id = messageSplit[1]
		} else {
			category_id = nil
		}

		// ======================= สำหรับGet ข้อมูลการลงทะเบียแล้วของ Item ==========================================
		var list []map[string]interface{}
		err := services.GameDB.Raw(`EXEC maxion_get_history_item_collection @character_key = ?, @category_id = ?`, character_key, category_id).Scan(&list).Error
		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}
		// ข้อมูลจาก DB โดยเช็คว่ามีของชิ้นนี้ในกระเป๋าจิงๆหรือไม่
		response_items, err := json.Marshal(list)
		if err != nil {
			log.Print("Error sending response_items: ", err)
			return
		}

		log.Print("Response Inventory : ", string(response_items))

		err = services.SendTCP(message.USER_MESSAGE_COLLECTION_COMPLETE_MY_COLLECTION_RETURN, string(response_items), character.Name)
		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}
	} else {
		log.Print("Error in Function HistoryItemCollection : Invalid message body")
		return
	}
}

func RegisterItemToCollection(body string, character *models.CharacterInfo) {
	returnValue := fmt.Sprintf(
		"%s,%s,%d",
		"", //  item number รหัสของ item
		"", // possesion index รหัสของช่องใน กระเป๋า
		0,  // active = 1 (Yes), active = 0 (No)
	)

	if body != "" {
		messageSplit := strings.Split(body, ",")
		// ตรวจสอบค่า messageSplit เพื่อแทนค่า null
		var character_key, itemNumber, possesionIndex, collectionId, categoryID_for_history interface{}
		if len(messageSplit) > 0 && messageSplit[0] != "" {
			character_key = messageSplit[0]
		} else {
			character_key = nil
		}

		if len(messageSplit) > 1 && messageSplit[1] != "" {
			itemNumber = messageSplit[1]
		} else {
			itemNumber = nil
		}

		if len(messageSplit) > 2 && messageSplit[2] != "" {
			possesionIndex = messageSplit[2]
		} else {
			possesionIndex = nil
		}

		if len(messageSplit) > 3 && messageSplit[3] != "" {
			collectionId = messageSplit[3]
		} else {
			collectionId = nil
		}
		// ======================= สำหรับเช็คว่า item นี้ มีในกระเป๋าจิงหรือไม่ ==========================================
		var list []map[string]interface{}
		err := services.GameInventoryDB.Raw(`EXEC maxion_get_item_in_inventory @character_key = ?, @itemNumber = ?, @possesionIndex = ?`, character_key, itemNumber, possesionIndex).Scan(&list).Error
		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}
		// ข้อมูลจาก DB โดยเช็คว่ามีของชิ้นนี้ในกระเป๋าจิงๆหรือไม่
		response_items, err := json.Marshal(list)
		if err != nil {
			log.Print("Error sending response_items: ", err)
			return
		}
		// log.Print("Response Inventory : ", string(response_items))

		// =============== สำหรับเช็คว่า item นี้ ลงทะเบียนไปรึยัง ==================================================
		var list_character_collection []map[string]interface{}
		formattedItemNumber := fmt.Sprintf("%%%s%%", itemNumber)
		err2 := services.GameDB.Raw(`EXEC maxion_crud_character_collection @character_key = ?, @collection_id = ?, @item = ?`, character_key, collectionId, formattedItemNumber).Scan(&list_character_collection).Error
		if err2 != nil {
			log.Print("Error sending response: ", err2)
			return
		}
		// ข้อมูลจาก DB โดยเช็คว่ามีของชิ้นนี้ในกระเป๋าจิงๆหรือไม่
		response_character_collection, err2 := json.Marshal(list_character_collection)
		if err2 != nil {
			log.Print("Error sending response: ", err2)
			return
		}

		// สำหรับเช็คว่า มี item ใน colltecion แล้ว
		// if len(response_character_collection) > 0 {
		// 	log.Print("This Item Is a Collected")
		// 	return
		// }
		log.Print("response_character_collection Inventory : ", string(response_character_collection))

		// แปลง JSON string เป็น array ของ Item_Collection_Inventory
		var Item_Collection_Inventory []models.Item_Collection_Inventory
		err = json.Unmarshal(response_items, &Item_Collection_Inventory)
		if err != nil {
			log.Print("Error unmarshaling response: ", err)
			return
		}

		// ================ ได้ข้อมูลมาจาก Redis collection_list ================
		dataCollectionList, err := services.GetRedisKey("collection_list")
		if err != nil {
			log.Println("Error getting dataCollectionList from Redis:", err)
			return
		}
		// แปลง JSON string เป็น array ของ Collection
		var collections []models.Item_Collection_List
		err = json.Unmarshal([]byte(dataCollectionList), &collections)
		if err != nil {
			log.Fatalf("Error unmarshalling JSON: %v", err)
		}

		for _, collection := range collections {
			text_collectionId := strconv.Itoa(collection.CollectionID)
			text_categoryID := strconv.Itoa(collection.CategoryID)
			if collectionId == text_collectionId {
				// แบ่ง string ตาม '|'
				entries := strings.Split(collection.RequiredItem, "|")
				// วนลูปผ่านแต่ละรายการใน entries
				for _, entry := range entries {
					// แบ่งรายการย่อยตาม ','
					parts := strings.Split(entry, ",")
					if len(parts) >= 4 {
						if parts[0] == itemNumber && strconv.Itoa(Item_Collection_Inventory[0].Number) == itemNumber && len(Item_Collection_Inventory) > 0 {
							itemSubString := strconv.Itoa(Item_Collection_Inventory[0].Number) + "," + strconv.Itoa(Item_Collection_Inventory[0].StatATK_GRA) + "," + strconv.Itoa(Item_Collection_Inventory[0].StatDEF_STR)

							//Set Update Collection
							errInsert := services.GameDB.Raw(`EXEC maxion_crud_character_collection @character_key= ?, @collection_id= ?, @category_id= ?, @item= ?, @stat= ?, @level= ?, @class= ?, @character_type= ?, @currency= ?, @status= ?, @active =?, @receive_rewards = ?, @mode = 1`,
								Item_Collection_Inventory[0].CharacterKey, text_collectionId, text_categoryID, itemSubString, "-", Item_Collection_Inventory[0].Level, Item_Collection_Inventory[0].Style, Item_Collection_Inventory[0].Bone, "-", "wait", 1, 0).Scan(&list_character_collection).Error

							categoryID_for_history = strconv.Itoa(collection.CategoryID)
							// ถ้าerror ต้อง returns ทิ้งเลย
							if errInsert != nil {
								log.Print("Error sending response: ", errInsert)
								return
							} else {
								returnValue = fmt.Sprintf(
									"%s,%s,%d",
									itemNumber,     //  item number รหัสของ item
									possesionIndex, // possesion index รหัสของช่องใน กระเป๋า
									1,              // active = 1 (Yes), active = 0 (No)
								)
							}

						}
					}
				}
			}

		}

		err = services.SendTCP(message.USER_MESSAGE_COLLECTION_GET_COLLECTION_ITEM_REGISTER_RETURN, string(returnValue), character.Name)
		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}

		// ตรวจสอบว่า array มีสมาชิกมากกว่าหนึ่งหรือไม่
		// if len(Item_Collection_Inventory) > 0 {
		// 	fmt.Println("Array has more than 1 element")
		// } else {
		// 	fmt.Println("Array has 1 or less element")
		// }

		// ======================= สำหรับ Get ข้อมูลการลงทะเบียแล้วของ Item ==========================================
		var listHistory []map[string]interface{}
		errHistory := services.GameDB.Raw(`EXEC maxion_get_history_item_collection @character_key = ?, @category_id = ?`, character_key, categoryID_for_history).Scan(&listHistory).Error
		if errHistory != nil {
			log.Print("Error sending response: ", err)
			return
		}
		// ข้อมูลจาก DB โดยเช็คว่ามีของชิ้นนี้ในกระเป๋าจิงๆหรือไม่
		response_listHistory, errHistory := json.Marshal(listHistory)
		if errHistory != nil {
			log.Print("Error sending listHistory: ", errHistory)
			return
		}

		// แปลง JSON string เป็น array ของ Item_Collection_Reward
		var Item_Collection_Reward []models.Histort_Item_Collection
		err = json.Unmarshal(response_listHistory, &Item_Collection_Reward)
		if err != nil {
			log.Print("Error unmarshaling response items: ", err)
			return
		}

		for _, collectionFromRedis := range collections {
			// แบ่ง `RequiredItem` ตาม '|'
			entries := strings.Split(collectionFromRedis.RequiredItem, "|")

			// กรองค่าที่ว่าง
			validEntries := []string{}
			for _, entry := range entries {
				if entry != "" { // กรองออกค่าที่ว่าง
					validEntries = append(validEntries, entry)
				}
			}

			// ตัวแปรนับจำนวนที่ตรงกัน
			matchedCount := 0

			// วนลูปเช็คแต่ละรายการใน validEntries
			for _, entry := range validEntries {
				// แบ่งแต่ละรายการย่อยตาม ','
				parts := strings.Split(entry, ",")
				if len(parts) >= 4 {

					// เปรียบเทียบ `Item` จาก `Item_Collection_Reward` กับ `RequiredItem`
					for _, reward := range Item_Collection_Reward {
						// แยก reward.Item โดยใช้ ',' และตรวจสอบให้แน่ใจว่ามีข้อมูลครบ
						Item_parts := strings.Split(reward.Item, ",")
						// ตรวจสอบว่า Item ตรงกันและ CollectionID ตรงกัน
						if len(Item_parts) >= 1 && Item_parts[0] == parts[0] && collectionFromRedis.CollectionID == reward.CollectionID {
							// เมื่อพบ item และ CollectionID ที่ตรงกัน
							matchedCount++
						}
					}
				}
			}

			// ตรวจสอบว่า matchedCount ตรงกับจำนวนที่ต้องการใน required_item
			// fmt.Printf("matchedCount: %d | len(entries): %d\n", matchedCount, len(entries))
			if matchedCount == len(validEntries) {
				var update_receive_rewards []map[string]interface{}
				errReward := services.GameDB.Raw(`EXEC maxion_crud_character_collection @character_key= ?, @collection_id= ?, @category_id= ?, @status= ?, @receive_rewards= ?, @mode = 4`,
					character_key, collectionFromRedis.CategoryID, collectionFromRedis.CollectionID, "success", 1).Scan(&update_receive_rewards).Error

				if errReward != nil {
					log.Print("Error sending response: ", errReward)
					return
				}
			}
		}

		var listHistory_for_update []map[string]interface{}
		errHistoryUpdate := services.GameDB.Raw(`EXEC maxion_get_history_item_collection @character_key = ?, @category_id = ?`, character_key, categoryID_for_history).Scan(&listHistory_for_update).Error
		if errHistoryUpdate != nil {
			log.Print("Error sending response: ", err)
			return
		}
		// ข้อมูลจาก DB โดยเช็คว่ามีของชิ้นนี้ในกระเป๋าจิงๆหรือไม่
		response_listHistory_for_update, errHistoryUpdate := json.Marshal(listHistory_for_update)
		if errHistoryUpdate != nil {
			log.Print("Error sending listHistory: ", errHistoryUpdate)
			return
		}
		log.Print("Response Inventory USER_MESSAGE_COLLECTION_COMPLETE_MY_COLLECTION_RETURN : ", string(response_listHistory_for_update))

		errHistoryUpdate = services.SendTCP(message.USER_MESSAGE_COLLECTION_COMPLETE_MY_COLLECTION_RETURN, string(response_listHistory_for_update), character.Name)
		if errHistoryUpdate != nil {
			log.Print("Error sending response: ", errHistoryUpdate)
			return
		}
	} else {
		log.Print("Error in Function RegisterItemToCollection : Invalid message body")
		return
	}

}

func RewardItemCollection(body string, character *models.CharacterInfo) {
	if body != "" {
		character_key := body
		// ======================= สำหรับ Get ข้อมูลการลงทะเบียแล้วของ Item ==========================================
		var list []map[string]interface{}
		err := services.GameDB.Raw(`EXEC maxion_get_history_item_collection @character_key = ?`, character_key).Scan(&list).Error
		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}
		// ข้อมูลจาก DB โดยเช็คว่ามีของชิ้นนี้ในกระเป๋าจริงๆ หรือไม่
		response_from_db, err := json.Marshal(list)
		if err != nil {
			log.Print("Error marshaling response_items: ", err)
			return
		}

		log.Print("Response Inventory : ", string(response_from_db))

		// ================ ได้ข้อมูลมาจาก Redis collection_list ================
		response_from_redis, err := services.GetRedisKey("collection_list")
		if err != nil {
			log.Println("Error getting dataCollectionList from Redis:", err)
			return
		}
		// แปลง JSON string เป็น array ของ Collection
		var collections_from_redis []models.Item_Collection_List
		err = json.Unmarshal([]byte(response_from_redis), &collections_from_redis)
		if err != nil {
			log.Fatalf("Error unmarshalling collection data from Redis: %v", err)
		}

		// แปลง JSON string เป็น array ของ Item_Collection_Reward
		var Item_Collection_Reward []models.Histort_Item_Collection
		err = json.Unmarshal(response_from_db, &Item_Collection_Reward)
		if err != nil {
			log.Print("Error unmarshaling response items: ", err)
			return
		}

		// ตัวแปรเก็บค่าผลรวมของ stats
		var totalAtkStr, totalAtkGra, totalAtkTeam, totalAtkDouble, totalAtkSpecial int
		var totalDefStr, totalDefTeam, totalDefDouble, totalDefSpecial, totalDefGra int

		// เปรียบเทียบข้อมูลใน `collections` กับ `Item_Collection_Reward`
		for _, collectionFromRedis := range collections_from_redis {
			// แบ่ง `RequiredItem` ตาม '|'
			entries := strings.Split(collectionFromRedis.RequiredItem, "|")

			// กรองค่าที่ว่าง
			validEntries := []string{}
			for _, entry := range entries {
				if entry != "" { // กรองออกค่าที่ว่าง
					validEntries = append(validEntries, entry)
				}
			}

			// ตัวแปรนับจำนวนที่ตรงกัน
			matchedCount := 0

			// วนลูปเช็คแต่ละรายการใน validEntries
			for _, entry := range validEntries {
				// แบ่งแต่ละรายการย่อยตาม ','
				parts := strings.Split(entry, ",")
				if len(parts) >= 4 {

					// เปรียบเทียบ `Item` จาก `Item_Collection_Reward` กับ `RequiredItem`
					for _, reward := range Item_Collection_Reward {
						// แยก reward.Item โดยใช้ ',' และตรวจสอบให้แน่ใจว่ามีข้อมูลครบ
						Item_parts := strings.Split(reward.Item, ",")

						// ตรวจสอบว่า Item ตรงกันและ CollectionID ตรงกัน
						if len(Item_parts) >= 1 && Item_parts[0] == parts[0] && collectionFromRedis.CollectionID == reward.CollectionID {
							// เมื่อพบ item และ CollectionID ที่ตรงกัน
							matchedCount++
						}
					}
				}
			}

			// ตรวจสอบว่า matchedCount ตรงกับจำนวนที่ต้องการใน required_item
			// fmt.Printf("matchedCount: %d | len(entries): %d\n", matchedCount, len(entries))
			if matchedCount == len(validEntries) {
				// ถ้าตรงกันทั้งหมดตามจำนวนที่ระบุใน required_item
				stats := strings.Split(collectionFromRedis.RewardStat, ",")
				if len(stats) >= 10 {
					// บวกค่าที่ได้จาก stats ลงในตัวแปรรวม
					// fmt.Printf("============== Atk =================\n")
					// totalAtkStr += toInt(stats[0])
					// totalAtkGra += toInt(stats[1])
					// totalAtkTeam += toInt(stats[2])
					// totalAtkDouble += toInt(stats[3])
					// totalAtkSpecial += toInt(stats[4])
					// // fmt.Printf("============== Def =================\n")
					// totalDefStr += toInt(stats[5])
					// totalDefTeam += toInt(stats[6])
					// totalDefDouble += toInt(stats[7])
					// totalDefSpecial += toInt(stats[8])
					// totalDefGra += toInt(stats[9])

					// fmt.Printf("============== For Test Stat =================\n")
					totalAtkStr += 0
					totalAtkGra += 0
					totalAtkTeam += 0
					totalAtkDouble += 0
					totalAtkSpecial += 0
					totalDefStr += 0
					totalDefTeam += 0
					totalDefDouble += 0
					totalDefSpecial += 0
					totalDefGra += 0

					// แสดงผลลัพธ์
					// fmt.Printf("===== Single Stat =====\n")
					// fmt.Printf("atk_str %d\n", totalAtkStr)
					// fmt.Printf("atk_gra %d\n", totalAtkGra)
					// fmt.Printf("atk_team %d\n", totalAtkTeam)
					// fmt.Printf("atk_double %d\n", totalAtkDouble)
					// fmt.Printf("atk_special %d\n", totalAtkSpecial)
					// fmt.Printf("def_str %d\n", totalDefStr)
					// fmt.Printf("def_team %d\n", totalDefTeam)
					// fmt.Printf("def_double %d\n", totalDefDouble)
					// fmt.Printf("def_special %d\n", totalDefSpecial)
					// fmt.Printf("def_gra %d\n", totalDefGra)
				}

				// var update_receive_rewards []map[string]interface{}
				// errReward := services.GameDB.Raw(`EXEC maxion_crud_character_collection @character_key= ?, @collection_id= ?, @category_id= ?, @status= ?, @receive_rewards= ?, @mode = 2`,
				// 	character_key, collectionFromRedis.CategoryID, collectionFromRedis.CollectionID, "success", 1).Scan(&update_receive_rewards).Error

				// if errReward != nil {
				// 	log.Print("Error sending response: ", errReward)
				// 	return
				// }
			}
		}

		returnValueString := fmt.Sprintf(
			"%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
			totalAtkStr,
			totalAtkGra,
			totalAtkTeam,
			totalAtkDouble,
			totalAtkSpecial,
			totalDefStr,
			totalDefTeam,
			totalDefDouble,
			totalDefSpecial,
			totalDefGra,
		)

		err = services.SendTCP(message.USER_MESSAGE_COLLECTION_GET_REWARD_HISTORY_RETURN, string(returnValueString), character.Name)
		if err != nil {
			log.Print("Error sending response: ", err)
			return
		}

	} else {
		log.Print("Error in Function RewardItemCollection : Invalid message body")
		return
	}
}

// ฟังก์ชันช่วยแปลงจาก string เป็น int
// func toInt(value string) int {
// 	result, err := strconv.Atoi(value)
// 	if err != nil {
// 		log.Printf("Error converting %s to int", value)
// 		return 0
// 	}
// 	return result
// }
