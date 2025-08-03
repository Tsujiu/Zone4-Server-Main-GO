package user_controller

import (
	// sqldb "database/sql"
	"context"
	"fmt"
	"time"

	// "gorm.io/driver/sqlserver"
	"log"
	// "maxion-zone4/config"
	"encoding/json"
	"maxion-zone4/models"
	"maxion-zone4/models/database"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"maxion-zone4/services/databases"
	sql "maxion-zone4/services/databases"
	"strconv"
	"strings"
)

// SplitString is a function that splits a string by a given delimiter.
func SplitString(input string, delimiter string) []string {
	return strings.Split(input, delimiter)
}

// func LoginUser(Body string, character *models.CharacterInfo) {
// 	log.Print("Login User: ", Body)

// 	services.SendTCP(message.USER_MESSAGE_15200, "Login Success TCP From Go naja", character.Name)
// }

func checkMemberInfoInDatabase(account, password string) bool {
	var exists bool
	err := services.GameDB.Raw(`SELECT CASE WHEN EXISTS (SELECT 1 FROM dbo.member_info WHERE memb___id COLLATE Latin1_General_CS_AS = ? AND password COLLATE Latin1_General_CS_AS = ?) THEN 1 ELSE 0 END`, account, password).Scan(&exists).Error
	if err != nil {
		log.Print("Error in GetCharacterStamina: ", err)
	}
	return exists
}

type LoginData struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func LoginUser(Body string, username string) {
	fmt.Print("Login User: ", Body)

	var data LoginData
	err := json.Unmarshal([]byte(Body), &data)
	if err != nil {
		fmt.Println("Error parsing JSON:", err)
		return
	}

	// Check Username & Password Is Empty
	if data.Username == "" || data.Password == "" {
		fmt.Println("Username or Password is missing!")
		return
	}

	if checkMemberInfoInDatabase(data.Username, data.Password) {
		services.SendTCPUser(message.USER_MESSAGE_RESPONSE_LOGIN, "Login Success TCP From Go naja", username)
	} else {
		services.SendTCPUser(message.USER_MESSAGE_SEND_CLIENT_ERROR, "User not found or invalid password", username)
		log.Println("User not found or invalid password")
	}
}

func LoginUserUDP(Body string) {
	fmt.Print("Login User UDP: ", Body)

	var data models.RegisterUserDTO
	err := json.Unmarshal([]byte(Body), &data)
	if err != nil {
		fmt.Println("❌ JSON parsing failed in RegisterUserUDP:", err)
		return
	}

	services.SendUDP(message.USER_MESSAGE_REGISTER_USER_RETURN, Body)
}

func LogoutUserUDP(Body string) {
	fmt.Print("Logout User UDP: ", Body)

	var data models.LogoutUserDTO
	err := json.Unmarshal([]byte(Body), &data)
	if err != nil {
		fmt.Println("❌ JSON parsing failed in LogoutUserUDP:", err)
		return
	}

	// ลบผู้ใช้จาก Redis (Online List)
	RemoveOnlineUser(data.ChannelID, data.ID)

	// ส่ง UDP ยืนยันการ Logout กลับไปยัง Client
	response := fmt.Sprintf(`{"id": "%s", "chanelCode": "%s"}`, data.ID, data.ChannelID)
	services.SendUDP(message.USER_MESSAGE_LOGOUT_USER_RETURN, response)

	fmt.Printf("✅ User %s ได้ถูกลบออกจาก Online List และส่งกลับไปยัง Client เรียบร้อยแล้ว\n", data.ID)
}

func MoveUserUDP(Body string) {
	var moveData models.MoveDataDTO
	err := json.Unmarshal([]byte(Body), &moveData)
	if err != nil {
		fmt.Println("❌ JSON parsing failed:", err)
		return
	}

	player := services.PlayerManager.Players[moveData.OwnerID]
	if player == nil {
		fmt.Println("⚠️ Player not found:", moveData.OwnerID)
		return
	}

	// zoneID := player.ZoneID
	// tileMap, ok := services.TileMapData[zoneID]
	// if !ok {
	// 	fmt.Println("⚠️ No tile map found for zone:", zoneID)
	// 	return
	// }

	// start := player.Pos
	// target := models.Vec2{
	// 	X: int(moveData.Position.X),
	// 	Y: int(moveData.Position.Y),
	// }

	// Pathfinding
	// path := models.FindPath(start, target, tileMap)
	// if len(path) == 0 {
	// 	fmt.Printf("❌ No valid path from %v to %v\n", start, target)
	// 	return
	// }

	// player.Pos = path[len(path)-1] // Update player position to the last step in the path

	// // สร้าง Coords สำหรับตอบกลับ
	// coords := make([]models.CoordDTO, len(path))
	// for i, step := range path {
	// 	coords[i] = models.CoordDTO{X: step.X, Y: step.Y}
	// }

	// ส่งข้อมูลเดิมเพื่อให้การเคลื่อนที่ๆถูกต้อง
	coords := moveData.Coords

	// สร้าง MoveDataDTO สำหรับตอบกลับ
	response := models.MoveDataDTO{
		OwnerID:  player.ID,
		Position: models.Vec2{X: player.Pos.X, Y: player.Pos.Y},
		Coords:   coords,
	}

	responseData, err := json.Marshal(response)
	if err != nil {
		fmt.Println("❌ JSON marshal failed:", err)
		return
	}

	// ส่งกลับ client
	services.SendUDP(message.USER_MESSAGE_SET_USER_MOVE_RETURN, string(responseData))
	fmt.Printf("📤 Sent move response to player %s\n", player.Name)
}

func AttackUserUDP(Body string) {
	fmt.Print("Attack User UDP: ", Body)

	services.SendUDP(message.USER_MESSAGE_SET_USER_ATTACK_RETURN, Body)
}

func RotateUserUDP(Body string) {
	fmt.Print("Rotate User UDP: ", Body)

	services.SendUDP(message.USER_MESSAGE_SET_USER_ROTATE_RETURN, Body)
}

func MoveMonsterUDP(Body string) {
	fmt.Print("Move Monster UDP: ", Body)

	services.SendUDP(message.SERVER_MESSAGE_MONSTER_MOVE, Body)
}

// Sending Data to TCP
func GetMsRankTCP(Body string, character *models.CharacterInfo) {
	//Logic for find new rank is here (Body string --> PlayerRankStar(int))
	RankStar, err := strconv.Atoi(Body)
	if err != nil {
		log.Print("Error converting string to int:", err)
		return
	}
	log.Print("Test RankID value from Client: ", RankStar)
	Data, err := sql.GetMsRank(RankStar)
	if err != nil {
		return
	}
	services.SendTCP(message.USER_MESSAGE_GET_MS_RANKING_RECEIVE, Data.ToString(), character.Name)
	log.Print("Final result that sending to client: ", Data.ToString())
}

// ReduceMsRankStarTCP processes the input and sends data via TCP.
func ModifyRankStarMsRankStarTCP(Body string, character *models.CharacterInfo) {
	// Use SplitString to split the input Body into components
	parts := SplitString(Body, ",")
	if len(parts) != 2 {
		log.Print("Invalid input format. Expected 'character_key,rank_star'")
		return
	}

	// Parse the character_key
	character_key, err := strconv.Atoi(parts[0])
	if err != nil {
		log.Print("Error converting character_key to int:", err)
		return
	}

	// Parse the rank_star
	ModifierStat, err := strconv.Atoi(parts[1])
	if err != nil {
		log.Print("Error converting rank_star to int:", err)
		return
	}

	// Log values from the client
	log.Print("Test RankID value from Client: ", character_key)
	log.Print("Rank Star value from Client: ", ModifierStat)

	// Logic for reducing rank (assuming sql.ReduceRankStar supports rank_star as input)
	Data, err := sql.ModifyRankStar(character_key, ModifierStat)
	if err != nil {
		log.Print("Error in ReduceRankStar:", err)
		return
	}

	// Send the result to the client via TCP
	services.SendTCP(message.USER_MESSAGE_MODIFY_RANK_POINT_RECEIVE, Data.ToString(), character.Name)
	log.Print("Final result that sending to client: ", Data.ToString())
}

// ReduceMsRankStarTCP processes the input and sends data via TCP.
func AddProtectionPointMsTCP(Body string, character *models.CharacterInfo) {
	// Use SplitString to split the input Body into components
	parts := SplitString(Body, ",")
	if len(parts) != 2 {
		log.Print("Invalid input format. Expected 'character_key,IsMVP'")
		return
	}

	// Parse the character_key
	character_key, err := strconv.Atoi(parts[0])
	if err != nil {
		log.Print("Error converting character_key to int:", err)
		return
	}

	// Parse the rank_star
	IsMVP, err := strconv.Atoi(parts[1])
	if err != nil {
		log.Print("Error converting rank_star to int:", err)
		return
	}

	// Log values from the client
	log.Print("Test CharacterID value from Client in Protection Point system: ", character_key)
	log.Print("IsMVP value from Client: ", IsMVP)

	// Logic for reducing rank (assuming sql.ReduceRankStar supports rank_star as input)
	Data, err := sql.AddProtectionPoint(character_key, IsMVP)
	if err != nil {
		log.Print("Error in ReduceRankStar:", err)
		return
	}

	// Send the result to the client via TCP
	services.SendTCP(message.USER_MESSAGE_UPDATE_PROTECTION_POINT_RECEIVE, Data.ToString(), character.Name)
	log.Print("Final result that sending to client: ", Data.ToString())
}

// ModifyBehaviorTCP processes the input and sends data via TCP.
func ModifyBehaviorTCP(Body string, character *models.CharacterInfo) {
	// Use SplitString to split the input Body into components
	parts := SplitString(Body, ",")
	if len(parts) != 2 {
		log.Print("Invalid input format. Expected 'character_key, ModifierStat'")
		return
	}

	// Parse the character_key
	character_key, err := strconv.Atoi(parts[0])
	if err != nil {
		log.Print("Error converting character_key to int:", err)
		return
	}

	// Parse the rank_star
	ModifierStat, err := strconv.Atoi(parts[1])
	if err != nil {
		log.Print("Error converting rank_star to int:", err)
		return
	}

	// Log values from the client
	log.Print("Test character_key value from Client: ", character_key)
	log.Print("ModifierStat value from Client: ", ModifierStat)

	Data, err := databases.ModifyBehaviorScore(character_key, ModifierStat)
	if err != nil {
		log.Print("Error in ModifyBehaviorTCP:", err)
		return
	}

	// Send the result to the client via TCP
	services.SendTCP(message.USER_MESSAGE_UPDATE_BEHAVIOR_POINT_RECEIVE, Data.ToString(), character.Name)
	log.Print("Final result that sending to client: ", Data.ToString())
}

// Sending Data to TCP
// func GET_TS_CHARACTER(Body string) {
// 	// Logic for finding new rank is here (Body string --> PlayerRankStar(int))
// 	Character_ID, err := strconv.Atoi(Body)
// 	if err != nil {
// 		log.Print("Error converting string to int:", err)
// 		return
// 	}
// 	log.Print("Test Character_ID value from Client: ", Character_ID)

// 	// Retrieve data as a slice of database.Season
// 	Data, err := sql.GetTsCharacter(Character_ID)
// 	if err != nil {
// 		log.Print("Error retrieving data from database:", err)
// 		return
// 	}

// 	// Convert the slice to a JSON-like string representation
// 	var result []string
// 	for _, season := range Data {
// 		result = append(result, "{"+season.ToString()+"}") // Add curly braces around each entry
// 	}
// 	finalResult := "[" + strings.Join(result, ",") + "]" // Join with commas and wrap in square brackets

// 	//Calculated Section
// 	//1. Match Count

// 	// Send the result via TCP
// 	services.SendTCP(message.USER_MESSAGE_GET_TS_CHARACTER_RECEIVE, finalResult)
// 	log.Print("Final result sent to client: ", finalResult)
// }

func GET_TS_CHARACTER(Body string, character *models.CharacterInfo) {
	// Convert Body string to Character_ID
	Character_ID, err := strconv.Atoi(Body)
	if err != nil {
		log.Print("Error converting string to int:", err)
		return
	}
	log.Print("Test Character_ID value from Client: ", Character_ID)

	// Retrieve data as a slice of database.Season
	Data, err := sql.GetTsCharacter(Character_ID)
	if err != nil {
		log.Print("Error retrieving data from database:", err)
		return
	}

	// Initialize variables for stats analysis
	totalMatches := len(Data)
	totalWins := 0
	totalLosses := 0
	totalDraws := 0
	totalKills := 0
	totalDeaths := 0
	totalKO := 0
	totalMVPs := 0
	totalDamage := 0

	// Analyze the data
	for _, match := range Data {
		// Count match results
		switch match.Match_result {
		case "W":
			totalWins++
		case "L":
			totalLosses++
		case "D":
			totalDraws++
		}

		// Sum kills, deaths, and KO
		totalKills += match.Kill
		totalDeaths += match.Death
		totalKO += match.Kill

		// Count MVPs
		if match.Mvp == 1 {
			totalMVPs++
		}

		// Sum total damage
		totalDamage += match.Total_damage
	}

	// Calculate win rate and K/D ratio
	winRate := 0.0
	if totalMatches > 0 {
		winRate = float64(totalWins) / float64(totalMatches) * 100
	}
	kdRatio := 0.0
	if totalDeaths > 0 {
		kdRatio = float64(totalKills) / float64(totalDeaths)
	}

	// Prepare results
	analytics := fmt.Sprintf(
		`{"Total Matches": %d, "Win Rate": %.2f, "K/D Ratio": %.2f, "KO": %d, "MVP Count": %d, "Total Damage": %d, "Total Wins": %d, "Total Losses": %d, "Total Draws": %d}`,
		totalMatches, winRate, kdRatio, totalKO, totalMVPs, totalDamage, totalWins, totalLosses, totalDraws,
	)

	// Convert the slice to a JSON-like string representation
	var result []string
	for _, season := range Data {
		result = append(result, "{"+season.ToString()+"}") // Add curly braces around each entry
	}
	finalResult := "[" + strings.Join(result, ",") + "]" // Join with commas and wrap in square brackets

	// Combine final result and analytics into one JSON-like response
	response := fmt.Sprintf(`{"Data": %s, "Stats": %s}`, finalResult, analytics)

	// Send the combined result via TCP
	services.SendTCP(message.USER_MESSAGE_GET_TS_CHARACTER_RECEIVE, response, character.Name)
	log.Print("Final result sent to client: ", response)
}

func GetCurrentRankStarByName(Body string, character *models.CharacterInfo) {
	// Name is now a string and does not need conversion
	Name := Body
	log.Print("Test GetCurrentRankStarByName value from Client: ", Name)

	// Assuming sql.GetCurrentRank can handle a string argument
	Data, err := sql.GetCurrentRank(Name)
	if err != nil {
		log.Print("Error fetching current rank:", err)
		return
	}

	services.SendTCP(message.USER_MESSAGE_GET_MS_RANKING_RECEIVE, Data.ToString(), character.Name)
	log.Print("Final result that sending to client: ", Data.ToString())
}

func DisconnectUser(characterName string) {
	log.Print("Disconnecting user:", characterName)
	services.DisconnectedClient(characterName)
}

// ฟังก์ชัน Insert ข้อมูลลงตาราง ConnectionHistory
func InsertDataMuLog(Body string) {

	fmt.Println("InsertDataMuLog : ", Body)

	var data accountData
	errJsonData := json.Unmarshal([]byte(Body), &data)
	if errJsonData != nil {
		fmt.Println("Error parsing JSON:", errJsonData)
	}

	svCode, _ := strconv.Atoi(data.ServerCode)
	chCode, _ := strconv.Atoi(data.ChannelCode)

	// สร้างข้อมูลใหม่
	newChar := database.ConnectionHistory{
		AccountID:   data.Username,
		ServerCode:  svCode,
		ServerName:  data.ServerName,
		ChannelCode: chCode,
		ChannelName: data.ChannelName,
		IP:          data.IP,
		Date:        time.Now(),
		State:       1,
		HWID:        data.DeviceId,
	}

	// INSERT ข้อมูลเข้า Database
	err := services.GameDB.Create(&newChar).Error
	if err != nil {
		log.Println("Insert Error:", err)
	} else {
		fmt.Println("Insert ConnectionHistory Successful!", newChar)

		// ===== Update Online User to Redis =====
		UpdateOnlineUserToRedis(chCode, data.Username)
	}
}

func UpdateOnlineUserToRedis(channelCode int, username string) {
	ctx := context.Background()

	onlineSetKey := fmt.Sprintf("mu:channel:%d:online_users", channelCode)

	// เพิ่ม Username เข้า Set
	result, err := services.RedisClient.SAdd(ctx, onlineSetKey, username).Result()
	if err != nil {
		log.Println("❌ Redis SAdd Error:", err)
	} else {
		if result == 1 {
			log.Printf("✅ Added %s to online users (Channel %d)", username, channelCode)
		} else {
			log.Printf("⚠️ %s is already in the online users set (Channel %d)", username, channelCode)
		}
	}

	// นับจำนวน CurrentUser จริงจาก Set
	count, err := services.RedisClient.SCard(ctx, onlineSetKey).Result()
	if err != nil {
		log.Println("❌ Redis SCard Error:", err)
	} else {
		fmt.Printf("📥 CurrentUser (Realtime) Channel: %d → %d Users", channelCode, count)
	}

	// ตั้ง Expire (Optional)
	services.RedisClient.Expire(ctx, onlineSetKey, 10*time.Minute)
}

func RemoveOnlineUser(body string, username string) {

	channelCode, _ := strconv.Atoi(body)
	ctx := context.Background()
	key := fmt.Sprintf("mu:channel:%d:online_users", channelCode)

	services.RemovePlayer(username)

	result, err := services.RedisClient.SRem(ctx, key, username).Result()
	if err != nil {
		log.Printf("❌ Redis SRem Error (Channel %d, User %s): %v", channelCode, username, err)
		return
	}

	if result == 1 {
		log.Printf("✅ Removed user %s from channel %d online list", username, channelCode)
	} else {
		log.Printf("⚠️ User %s was not found in channel %d online list", username, channelCode)
	}
}

func GetAccountRequest(Body string, username string) {

	result := GetAccountRequestResult(Body)
	InsertDataMuLog(Body)
	fmt.Println("GetAccountRequest: ", result)

	if result {
		services.SendTCPUser(message.USER_MESSAGE_RESPONSE_ACCOUNT_REQUEST, "Get Account Complete", username)
	} else {
		services.SendTCPUser(message.USER_MESSAGE_RESPONSE_ACCOUNT_ERROR, "Database error", username)
	}
}

type accountData struct {
	Username    string `json:"username"`
	ServerCode  string `json:"serverCode"`
	ServerName  string `json:"serverName"`
	ChannelCode string `json:"ChannelCode"`
	ChannelName string `json:"ChannelName"`
	IP          string `json:"ip"`
	MAC         string `json:"mac"`
	DeviceId    string `json:"deviceId"`
}

func GetAccountRequestResult(Body string) bool {
	var exists bool
	fmt.Println("GetAccountRequestResult: ", Body)

	var data accountData
	err := json.Unmarshal([]byte(Body), &data)
	if err != nil {
		fmt.Println("Error parsing JSON:", err)
		exists = false
	}

	// แปลง ServerCode จาก string เป็น int
	serverCode, err := strconv.Atoi(data.ServerCode)
	if err != nil {
		fmt.Println("Error converting ServerCode to int:", err)
		exists = false
	}

	// สร้างข้อมูลใหม่
	newChar := database.MemberStatus{
		MembID:       data.Username,
		ConnectStat:  1,
		ServerCode:   serverCode,
		ServerName:   data.ServerName,
		IP:           data.IP,
		MAC:          &data.MAC,
		DeviceId:     &data.DeviceId,
		ConnectTM:    time.Now(),
		DisConnectTM: nil,
	}

	fmt.Println("saveMemberStatus: ", newChar)

	// Create Order Update Table member_status
	errSave := services.GameDB.Save(&newChar).Error
	if errSave != nil {
		exists = false
		fmt.Println("Error:", errSave)
	} else {
		exists = true
		fmt.Println("Insert or Update Successful!")
	}

	return exists
}
