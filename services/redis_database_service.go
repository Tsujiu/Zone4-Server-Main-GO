package services

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/config"
	"maxion-zone4/models"
	"strings"
	"time"

	"github.com/go-redis/redis/v8"
)

var RedisClient *redis.Client

func InitializeRedisDatabases() {
	// Ensure environment variables or config values exist
	redisAddr := config.AppConfig["REDIS_ADDR"]
	redisUser := config.AppConfig["REDIS_USER"] // If using ACL users (Redis 6+)
	redisPass := config.AppConfig["REDIS_PASS"]

	if redisAddr == "" || redisPass == "" {
		log.Fatal("Redis configuration is missing (check REDIS_ADDR and REDIS_PASS)")
	}

	// Redis connection with authentication
	fmt.Println("Connecting to Redis")
	RedisClient = redis.NewClient(&redis.Options{
		Addr:     redisAddr, // e.g., "localhost:6379"
		Username: redisUser, // Use "" if Redis does not require ACL users
		Password: redisPass, // Password for authentication
		DB:       0,         // Select database 0 (default)
	})

	// Test connection
	_, err := RedisClient.Ping(context.Background()).Result()
	if err != nil {
		log.Fatal("Error connecting to Redis:", err)
	}
	fmt.Println("Connected to Redis")

	InitializeRedisMaster()
}

func GetRedisKey(key string) (string, error) {
	val, err := RedisClient.Get(context.Background(), key).Result()
	if err != nil {
		return "", err
	}
	return val, nil
}

func SetRedisKey(key string, value string) error {
	err := RedisClient.Set(context.Background(), key, value, 0).Err()
	if err != nil {
		return err
	}
	return nil
}

func PushRedis(key string, value string) error {
	err := RedisClient.LPush(context.Background(), key, value).Err()
	if err != nil {
		return err
	}
	return nil
}

func DeleteRedisKey(key string) error {
	err := RedisClient.Del(context.Background(), key).Err()
	if err != nil {
		return err
	}
	return nil
}

func RemoveRedisList(key string, value string) error {
	err := RedisClient.LRem(context.Background(), key, 1, value).Err()
	if err != nil {
		return err
	}
	return nil
}

func GetRedisKeys() ([]string, error) {
	keys, err := RedisClient.Keys(context.Background(), "*").Result()
	if err != nil {
		return nil, err
	}
	return keys, nil
}

func GetRedisKeysWithPattern(pattern string) ([]string, error) {
	keys, err := RedisClient.Keys(context.Background(), pattern).Result()
	if err != nil {
		return nil, err
	}
	return keys, nil
}

func GetRedisKeysCount() (int64, error) {
	count, err := RedisClient.DBSize(context.Background()).Result()
	if err != nil {
		return 0, err
	}
	return count, nil
}

func GetRedisKeysCountWithPattern(pattern string) (int64, error) {
	count, err := RedisClient.DBSize(context.Background()).Result()
	if err != nil {
		return 0, err
	}
	return count, nil
}

func GetRedisKeysTTL(key string) (int64, error) {
	ttl, err := RedisClient.TTL(context.Background(), key).Result()
	if err != nil {
		return 0, err
	}
	return ttl.Milliseconds(), nil
}

func SetRedisKeysTTL(key string, ttl int64) error {
	err := RedisClient.Expire(context.Background(), key, time.Duration(ttl)).Err()
	if err != nil {
		return err
	}
	return nil
}

func GetRedisKeyListValue(key string) ([]string, error) {
	val, err := RedisClient.LRange(context.Background(), key, 0, -1).Result()
	if err != nil {
		return nil, err
	}

	return val, nil
}

func GetRedisListIndex(key string, index int) (string, error) {
	ctx := context.Background()

	// ใช้ LIndex เพื่อดึงค่าที่ index ที่ระบุ
	val, err := RedisClient.LIndex(ctx, key, int64(index)).Result()
	if err != nil {
		return "", err
	}

	return val, nil
}

func UpdateRedisList(key string, values []string) error {
	ctx := context.Background()

	// ใช้ RPush เพื่อเพิ่มค่าใหม่เข้าไปใน Redis List
	err := RedisClient.RPush(ctx, key, values).Err()
	if err != nil {
		return err
	}

	return nil
}

func GetRedisListKeys() ([]string, error) {
	keys, err := RedisClient.Keys(context.Background(), "*").Result()
	if err != nil {
		return nil, err
	}

	return keys, nil
}

func UpdateRedisListIndex(key string, index int, newValue string) error {
	ctx := context.Background()

	// ใช้ LSet เพื่อแทนค่าที่ index ที่ระบุด้วยค่าใหม่
	err := RedisClient.LSet(ctx, key, int64(index), newValue).Err()
	if err != nil {
		return err
	}

	return nil
}

func RemoveRedisListIndex(key string, index int) error {
	ctx := context.Background()

	// ดึงค่าทั้งหมดจาก Redis List
	values, err := RedisClient.LRange(ctx, key, 0, -1).Result()
	if err != nil {
		return err
	}

	if index < 0 || index >= len(values) {
		return fmt.Errorf("index out of range")
	}

	// ใช้ LSet เพื่อแทนค่าที่ต้องการลบด้วยค่า placeholder เช่น "__DELETE_ME__"
	placeholder := "__DELETE_ME__"
	err = RedisClient.LSet(ctx, key, int64(index), placeholder).Err()
	if err != nil {
		return err
	}

	// ใช้ LRem เพื่อลบ placeholder ออกจากรายการ
	err = RedisClient.LRem(ctx, key, 1, placeholder).Err()
	if err != nil {
		return err
	}

	return nil
}

func CheckRedisKeyExists(key string) (bool, error) {
	ctx := context.Background()
	val, err := RedisClient.Exists(ctx, key).Result()

	if err != nil {

		return false, err

	}

	return val > 0, nil

}
func SetRedisKeyListValue(key string, value string) error {
	ctx := context.Background()

	// 1) ลบ key เดิมก่อน เพื่อเคลียร์ List เก่า
	if err := RedisClient.Del(ctx, key).Err(); err != nil {
		return fmt.Errorf("failed to delete old key: %v", err)
	}

	// 2) สร้าง List ใหม่ โดยใส่ value เป็นสมาชิกเดียวใน list
	if err := RedisClient.RPush(ctx, key, value).Err(); err != nil {
		return fmt.Errorf("failed to rpush new value: %v", err)
	}

	return nil
}

func SyncCharacterPositionToCharacterTable(characterName string) error {
	key := fmt.Sprintf("character:move:%s", characterName)

	// ดึงข้อมูล JSON ล่าสุดจาก Redis
	jsonStr, err := GetRedisListIndex(key, 0)
	if err != nil {
		return fmt.Errorf("redis get error: %w", err)
	}

	var move models.CharacterMove
	if err := json.Unmarshal([]byte(jsonStr), &move); err != nil {
		return fmt.Errorf("unmarshal error: %w", err)
	}

	// อัปเดต MapNumber, MapPosX, MapPosY ในตาราง Character
	err = GameDB.Exec(`
		UPDATE Character
		SET MapNumber = ?, MapPosX = ?, MapPosY = ?
		WHERE Name = ?`,
		move.MapNumber, move.PosX, move.PosY, move.CharacterName,
	).Error

	if err != nil {
		return fmt.Errorf("db update error: %w", err)
	}

	DeleteRedisKey(key)

	log.Printf("✅ Updated position of %s -> Map:%d, X:%d, Y:%d", move.CharacterName, move.MapNumber, move.PosX, move.PosY)
	return nil
}

func SyncAllCharacterPositionsToCharacterTable() {
	keys, err := GetRedisKeysWithPattern("character:move:*")
	if err != nil {
		log.Printf("❌ Failed to fetch redis keys: %v", err)
		return
	}

	for _, key := range keys {
		name := strings.TrimPrefix(key, "character:move:")
		if err := SyncCharacterPositionToCharacterTable(name); err != nil {
			log.Printf("❌ Failed to sync %s: %v", name, err)
		}
	}
}

func StartCharacterPositionSyncLoop() {
	ticker := time.NewTicker(30 * time.Second)
	go func() {
		for range ticker.C {
			SyncAllCharacterPositionsToCharacterTable()
		}
	}()
}
