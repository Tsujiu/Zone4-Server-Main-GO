package utils

import (
	"encoding/json"
	"log"
	"net"
)

var Accounts = make(map[string]net.Conn)

func LogMessage(message string) {
	log.Println(message)
}

func Contains(slice []string, item string) bool {
	for _, v := range slice {
		if v == item {
			return true
		}
	}
	return false
}

func RemoveStringFromSlice(slice []string, item string) []string {
	for i, v := range slice {
		if v == item {
			return append(slice[:i], slice[i+1:]...)
		}
	}
	return slice
}

func Parse(data []byte, v interface{}) error {
	return json.Unmarshal(data, v)
}
