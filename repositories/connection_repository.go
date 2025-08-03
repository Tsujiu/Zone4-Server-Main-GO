package repositories

import (
	"context"
	"log"
	"maxion-zone4/services"
)

func StoreData(data string) {
	// Store data in Redis
	err := services.RedisClient.Set(context.Background(), "lastMessage", data, 0).Err()
	if err != nil {
		log.Println("Error storing data in Redis:", err)
	} else {
		log.Println("Data stored in Redis")
	}

	// (Optional) Store data in SQL Server
	// Implement storing in SQL Server as needed
}
