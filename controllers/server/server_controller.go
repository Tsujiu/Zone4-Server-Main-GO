package server_controller

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	databaseModel "maxion-zone4/models/database"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"os"
	"reflect"
	"strconv"
)

func GetServerList(Body string, username string) {
	var data []databaseModel.Server
	result := services.GameDB.Table("Servers").Where("Visible = 1").Find(&data)
	if result.Error != nil {
		log.Println("Database error:", result.Error)
		services.SendTCPUser(message.SERVER_MESSAGE_GET_SERVER_LIST_ERROR, "Get Server List Error", username)
	} else {
		log.Printf("Query Result: %+v\n", reflect.ValueOf(data))
		jsonData, err := json.Marshal(data)
		if err != nil {
			log.Println("Error converting to JSON:", err)
		}

		services.SendTCPUser(message.SERVER_MESSAGE_SET_SERVER_LIST, string(jsonData), username)
	}
}

func GetMaxUserChannel() int {
	maxUserStr := os.Getenv("MAX_USER_CHANNEL")
	maxUser, err := strconv.Atoi(maxUserStr)
	if err != nil {
		log.Println("⚠️ MAX_USER_CHANNEL not set or invalid. Default to 0")
		return 0
	}
	return maxUser
}

func GetOnlineUserCount(channelCode int) int {
	ctx := context.Background()
	key := fmt.Sprintf("mu:channel:%d:online_users", channelCode)
	count, err := services.RedisClient.SCard(ctx, key).Result()
	if err != nil {
		log.Println("❌ Redis SCard Error:", err)
		return 0
	}
	return int(count)
}

func GetChannelList(Body string, username string) {
	var data []databaseModel.Channel
	var ServerCode = Body
	result := services.GameDB.Table("Channel").Where("Visible = 1 AND ServerCode = ?", ServerCode).Find(&data)

	if result.Error != nil {
		log.Println("Database error:", result.Error)
		services.SendTCPUser(message.SERVER_MESSAGE_GET_CHANNEL_LIST_ERROR, "Get Channel List Error", username)
		return
	}

	max := GetMaxUserChannel()
	var response []map[string]any

	for _, ch := range data {
		item := map[string]any{
			"channel_code": ch.ChannelCode,
			"server_code":  ch.ServerCode,
			"visible":      ch.Visible,
			"name":         ch.Name,
			"port":         ch.Port,
			"current_user": GetOnlineUserCount(ch.ChannelCode),
			"max_user":     max,
		}
		response = append(response, item)
	}

	jsonData, err := json.Marshal(response)
	if err != nil {
		log.Println("Error converting to JSON:", err)
		services.SendTCPUser(message.SERVER_MESSAGE_GET_CHANNEL_LIST_ERROR, "JSON Error", username)
		return
	}

	log.Printf("Channel List Response: %s", string(jsonData))
	services.SendTCPUser(message.SERVER_MESSAGE_SET_CHANNEL_LIST, string(jsonData), username)
}

func SelectChannel(Body string, username string) {

	log.Println("Select Channel : ", Body)

	// var data []databaseModel.Channel
	// result := services.GameDB.Table("Servers").Select("ChannelCode, ServerCode, Name").Where("Visible = 1").Find(&data)
	// if result.Error != nil {
	// 	log.Println("Database error:", result.Error)
	// 	services.SendTCPUser(message.SERVER_MESSAGE_GET_CHANNEL_LIST_ERROR, "Get Channel List Error", username)
	// } else {
	// 	log.Printf("Query Result: %+v\n", reflect.ValueOf(data))
	// 	jsonData, err := json.Marshal(data)
	// 	if err != nil {
	// 		log.Println("Error converting to JSON:", err)
	// 	}

	// 	services.SendTCPUser(message.SERVER_MESSAGE_SET_CHANNEL_LIST, string(jsonData), username)
	// }
}
