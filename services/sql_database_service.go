package services

import (
	"fmt"
	"log"
	"maxion-zone4/config"

	// "maxion-zone4/models"

	"time"

	"gorm.io/driver/sqlserver"
	"gorm.io/gorm"
)

// ตัวแปรสำหรับเก็บการเชื่อมต่อฐานข้อมูล
var GameDB *gorm.DB
var GameInventoryDB *gorm.DB
var GameRecordDB *gorm.DB

func connectDB(dsnConfig string) *gorm.DB {

	// กำหนดข้อมูลการเชื่อมต่อ (DSN)
	dsn := config.AppConfig[dsnConfig]

	// เปิดการเชื่อมต่อฐานข้อมูลด้วย GORM
	database, err := gorm.Open(sqlserver.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database game:", err)
	}

	// ทดสอบการเชื่อมต่อ
	sqlDB, err := database.DB()
	if err != nil {
		log.Fatal("Failed to initialize database connection pool game:", err)
	}
	fmt.Println("Database game connected successfully")

	// ตั้งค่า Connection Pool
	sqlDB.SetMaxIdleConns(20)                  // จำนวนการเชื่อมต่อที่รอใช้งาน
	sqlDB.SetMaxOpenConns(200)                 // จำนวนการเชื่อมต่อสูงสุด
	sqlDB.SetConnMaxLifetime(30 * time.Minute) // อายุการใช้งานของการเชื่อมต่อ

	return database
}

// ConnectDatabase เป็นฟังก์ชันสำหรับเชื่อมต่อฐานข้อมูล SQL Server
func DBGameConnect() {
	// กำหนดข้อมูลการเชื่อมต่อ (DSN)
	dsn := config.AppConfig["SQLSERVER_GAME"]

	// เปิดการเชื่อมต่อฐานข้อมูลด้วย GORM
	database, err := gorm.Open(sqlserver.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database game:", err)
	}

	// ตั้งค่าให้ตัวแปร DB สามารถใช้เชื่อมต่อได้ทั่วโปรเจ็ค
	GameDB = database

	// ทดสอบการเชื่อมต่อ
	sqlDB, err := GameDB.DB()
	if err != nil {
		log.Fatal("Failed to initialize database connection pool game:", err)
	}
	fmt.Println("Database game connected successfully")

	// ตั้งค่า Connection Pool
	sqlDB.SetMaxIdleConns(20)                  // จำนวนการเชื่อมต่อที่รอใช้งาน
	sqlDB.SetMaxOpenConns(200)                 // จำนวนการเชื่อมต่อสูงสุด
	sqlDB.SetConnMaxLifetime(30 * time.Minute) // อายุการใช้งานของการเชื่อมต่อ
}

func DBGameInventoryConnect() {
	// กำหนดข้อมูลการเชื่อมต่อ (DSN)
	dsn := config.AppConfig["SQLSERVER_GAME_INVENTORY"]

	// เปิดการเชื่อมต่อฐานข้อมูลด้วย GORM
	database, err := gorm.Open(sqlserver.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database game_inventory:", err)
	}

	// ตั้งค่าให้ตัวแปร DB สามารถใช้เชื่อมต่อได้ทั่วโปรเจ็ค
	GameInventoryDB = database

	// ทดสอบการเชื่อมต่อ
	sqlDB, err := GameInventoryDB.DB()
	if err != nil {
		log.Fatal("Failed to initialize database game_inventory connection pool:", err)
	}
	fmt.Println("Database game_inventory connected successfully")

	// ตั้งค่า Connection Pool
	sqlDB.SetMaxIdleConns(20)                  // จำนวนการเชื่อมต่อที่รอใช้งาน
	sqlDB.SetMaxOpenConns(200)                 // จำนวนการเชื่อมต่อสูงสุด
	sqlDB.SetConnMaxLifetime(30 * time.Minute) // อายุการใช้งานของการเชื่อมต่อ
}

func DBGameRecordConnect() {
	GameRecordDB = connectDB("SQLSERVER_GAME_RECORD")
}

func SqlGameClose() {
	sqlDB, err := GameDB.DB()
	if err != nil {
		log.Fatal("Failed to close database connection pool:", err)
	}
	sqlDB.Close()
	log.Println("Database connection pool closed")
}

func SqlGameInventortClose() {
	sqlDB, err := GameInventoryDB.DB()
	if err != nil {
		log.Fatal("Failed to close database connection pool:", err)
	}
	sqlDB.Close()
	log.Println("Database connection pool closed")
}
