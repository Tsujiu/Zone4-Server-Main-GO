package config

import (
	"crypto/aes"
	"encoding/hex"
	"log"
	"net"
	"os"
	"strconv"
	"strings"

	"github.com/joho/godotenv"
)

var AppConfig map[string]string
var AESKey []byte
var AESIV []byte
var Conn net.Conn
var Addr *net.UDPAddr
var ConnUDP *net.UDPConn

func LoadConfig() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	AppConfig = make(map[string]string)
	AppConfig["REDIS_ADDR"] = os.Getenv("REDIS_ADDR")
	AppConfig["REDIS_USER"] = os.Getenv("REDIS_USER")
	AppConfig["REDIS_PASS"] = os.Getenv("REDIS_PASS")
	AppConfig["SQLSERVER_GAME"] = os.Getenv("SQLSERVER_GAME")
	AppConfig["SQLSERVER_GAME_TEST"] = os.Getenv("SQLSERVER_GAME_TEST")
	AppConfig["SQLSERVER_GAME_INVENTORY"] = os.Getenv("SQLSERVER_GAME_INVENTORY")
	AppConfig["SQLSERVER_GAME_INVENTORT_TEST"] = os.Getenv("SQLSERVER_GAME_INVENTORT_TEST")
	AppConfig["SQLSERVER_GAME_RECORD"] = os.Getenv("SQLSERVER_GAME_RECORD")
	AppConfig["TCP_PORT"] = os.Getenv("TCP_PORT")
	AppConfig["UDP_PORT"] = os.Getenv("UDP_PORT")
	AppConfig["MAX_MATCHING_WORKER"] = os.Getenv("MAX_MATCHING_WORKER")
	AppConfig["DB_USER"] = os.Getenv("DB_USER")
	AppConfig["DB_PASSWORD"] = os.Getenv("DB_PASSWORD")
	AppConfig["DB_NAME"] = os.Getenv("DB_NAME")
	AppConfig["DB_SERVER"] = os.Getenv("DB_SERVER")
	AppConfig["DB_PORT"] = os.Getenv("DB_PORT")

	// Load AES Key
	keyString := os.Getenv("AES_KEY")
	AESKey = []byte(keyString)
	// // Load AES IV from hex string and convert to []byte
	// ivString := os.Getenv("AES_IV")
	// ivParts := strings.Split(ivString, ",")
	// var iv []byte
	// for _, part := range ivParts {
	// 	val, err := strconv.Atoi(strings.TrimSpace(part))
	// 	if err != nil {
	// 		log.Fatal("Invalid AES_IV format:", err)
	// 	}
	// 	iv = append(iv, byte(val))
	// }
	// AESIV = iv

	// อ่านค่า AES_IV จาก .env
	aesIVHex := os.Getenv("AES_IV")
	if aesIVHex == "" {
		log.Fatal("AES_IV not set in .env")
	}

	// ตรวจสอบว่า AES_IV มีความยาวถูกต้อง (ต้องเป็น 32 ตัวอักษร Hex = 16 bytes)
	if len(strings.TrimSpace(aesIVHex)) != 32 {
		log.Fatalf("Invalid AES_IV length: must be 32 hex characters (16 bytes), but got %d", len(aesIVHex))
	}

	// แปลงจาก Hex เป็น []byte
	aesIV, err := hex.DecodeString(aesIVHex)
	if err != nil {
		log.Fatalf("Invalid AES_IV format: %v", err)
	}

	// ตรวจสอบว่าความยาวของ IV ถูกต้อง (AES ใช้ 16 ไบต์)
	if len(aesIV) != aes.BlockSize {
		log.Fatalf("AES_IV must be %d bytes, got %d", aes.BlockSize, len(aesIV))
	}

	// เซ็ตค่า IV ให้กับตัวแปร global
	AESIV = aesIV
}
func LoadConfigTestLocal() {
	AppConfig = make(map[string]string)
	AppConfig["REDIS_ADDR"] = "localhost:6379"
	AppConfig["SQLSERVER_DSN"] = "sqlserver://server01:Server01@localhost:1433?database=game"
	AppConfig["SQLSERVER_GAME"] = "sqlserver://server01:Server01@localhost:1433?database=game"
	AppConfig["TCP_PORT"] = "9000"
	AppConfig["UDP_PORT"] = "9000"

	// Load AES Key
	AESKey = []byte("p*{Ilqw<8AT_@poI2Kq3D1uVcp`*@bRh")
	// Load AES IV from hex string and convert to []byte
	ivParts := strings.Split("235,72,71,0,201,74,178,207,129,184,192,91,50,78,209,100", ",")
	var iv []byte
	for _, part := range ivParts {
		val, err := strconv.Atoi(strings.TrimSpace(part))
		if err != nil {
			log.Fatal("Invalid AES_IV format:", err)
		}
		iv = append(iv, byte(val))
	}
	AESIV = iv
}
