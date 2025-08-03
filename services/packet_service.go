package services

import (
	"encoding/json"
	"fmt"
	"log"
	"maxion-zone4/config"
	"maxion-zone4/models"
	"maxion-zone4/utils"
	"net"
	"strconv"
	"strings"
)

// SendTCP sends a TCP packet to the client
// func SendTCP2(header int, body string) error {
// 	const chunkSize = 1000
// 	packet := strconv.Itoa(header) + "|" + body
// 	encryptedMessage, err := models.EncryptMessage(packet)
// 	if err != nil {
// 		log.Fatal("Error encrypting message:", err)
// 		return err
// 	}
// 	totalBytes := len(encryptedMessage)

// 	// ส่ง Header ระบุขนาดข้อมูลทั้งหมด (10 bytes)
// 	headers := fmt.Sprintf("%010d", totalBytes)
// 	_, err = config.Conn.Write([]byte(headers))
// 	if err != nil {
// 		log.Println("Error sending header:", err)
// 		return err
// 	}

// 	bytesSent := 0
// 	for bytesSent < totalBytes {
// 		remainingBytes := totalBytes - bytesSent
// 		if remainingBytes > chunkSize {
// 			remainingBytes = chunkSize
// 		}

// 		// ตรวจสอบขอบเขต slice ก่อนเขียน
// 		if bytesSent+remainingBytes > totalBytes {
// 			log.Fatalf("Slice bounds error: bytesSent=%d, remainingBytes=%d, totalBytes=%d\n", bytesSent, remainingBytes, totalBytes)
// 		}

// 		// ส่ง Chunk
// 		_, err := config.Conn.Write([]byte(encryptedMessage[bytesSent : bytesSent+remainingBytes]))
// 		if err != nil {
// 			log.Println("Error sending chunk:", err)
// 			return err
// 		}
// 		bytesSent += remainingBytes
// 	}
// 	return nil
// }

func SendTCPClient(conn net.Conn, header int, body string) error {
	// const headerSize = 10
	packet := strconv.Itoa(header) + "|" + body

	encryptedMessage, err := models.EncryptMessage(packet)
	if err != nil {
		return fmt.Errorf("error encrypting message: %v", err)
	}

	encryptedMessage += "\n"

	totalBytes := len(encryptedMessage)

	// Prepare the complete message (header + encrypted body)
	completeMessage := make([]byte, totalBytes)
	// copy(completeMessage[:10], fmt.Sprintf("%010d", totalBytes))
	copy(completeMessage[0:], encryptedMessage)

	// Send the complete message in a single Write call
	bytesWritten, err := conn.Write([]byte(completeMessage))
	if err != nil {
		return fmt.Errorf("failed to send message: %v", err)
	}
	if bytesWritten != len(completeMessage) {
		return fmt.Errorf("incomplete write: %d/%d bytes", bytesWritten, len(completeMessage))
	}

	fmt.Printf("Message successfully sent (total bytes: %d) :", len(completeMessage))
	return nil
}

func SendTCP(header int, body string, characterName string) error {
	ClientMutex.Lock()
	defer ClientMutex.Unlock() // This ensures the lock is always released, even if an error occurs

	conn, exists := Clients[strings.TrimSpace(characterName)]
	if !exists {
		log.Printf("Client %s not connected\n", characterName)
		return fmt.Errorf("client %s not connected", characterName)
	}

	fmt.Printf("Sending message to %s: %d|%s|%s\n", characterName, header, body, conn.RemoteAddr())

	// SendTCPClient is called while still holding the lock test
	err := SendTCPClient(conn, header, body)
	if err != nil {
		log.Printf("Error sending message to %s: %v\n", characterName, err)
	}

	return err
}

func SendTCPUser(header int, body string, username string) error {
	ClientMutex.Lock()
	defer ClientMutex.Unlock() // This ensures the lock is always released, even if an error occurs

	conn, exists := utils.Accounts[strings.TrimSpace(username)]
	if !exists {
		log.Printf("Client %s not connected\n", username)
		return fmt.Errorf("client %s not connected", username)
	}

	fmt.Printf("Sending message to %s: %d|%s|%s\n", username, header, body, conn.RemoteAddr())

	// SendTCPClient is called while still holding the lock test
	err := SendTCPClient(conn, header, body)
	if err != nil {
		log.Printf("Error sending message to %s: %v\n", username, err)

		// ⛔ ลบออกจาก ConnectedPlayers ถ้า player ใช้ TCP แบบ PlayerConn
		ConnectedPlayers.Lock()
		delete(ConnectedPlayers.players, username) // ใช้ username เป็น key ถ้า match
		ConnectedPlayers.Unlock()

		log.Printf("🗑️ Removed player %s from ConnectedPlayers due to broken TCP\n", username)

	}

	return err
}

func DisconnectedClient(character_name string) {
	ClientMutex.Lock()
	defer ClientMutex.Unlock()
	if conn, exists := Clients[strings.TrimSpace(character_name)]; exists {
		delete(Clients, character_name)
		conn.Close()
		fmt.Println("Client", character_name, "disconnected")
	} else {
		fmt.Println("Client", character_name, "not connected")
	}
}

func SendUDP(header int, body string) error {
	packet := strconv.Itoa(header) + "|" + body
	response, err := models.EncryptMessage(packet)
	if err != nil {
		log.Fatal("Error encrypting message:", err)
		return err
	}

	_, err = config.ConnUDP.WriteToUDP([]byte(response), config.Addr)
	if err != nil {
		log.Println("Error sending UDP data:", err)
		return err
	}

	// log.Println("config.Addr:", config.Addr)
	return nil
}

func SendUDPToPlayer(header int, body string, player *Player) error {
	if player == nil || player.Send == nil {
		return fmt.Errorf("invalid player or connection")
	}

	packet := map[string]interface{}{
		"code": header,
		"body": body,
	}
	data, err := json.Marshal(packet)
	if err != nil {
		return fmt.Errorf("failed to marshal packet: %v", err)
	}

	player.Send(data) // ใช้ฟังก์ชันส่งของ player แต่ละคน
	return nil
}
