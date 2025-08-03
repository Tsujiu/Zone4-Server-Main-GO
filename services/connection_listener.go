package services

import (
	"bufio"
	"encoding/json"
	"fmt"
	"maxion-zone4/models"
	"maxion-zone4/utils"
	"net"
	"strings"
	"sync"
	"time"
)

var Clients = make(map[string]net.Conn)
var Characters = make(map[string]models.CharacterInfo)
var charsMu = &sync.RWMutex{}
var ClientMutex = sync.Mutex{}

// handleConnectionListener รับข้อมูลจาก client และตอบกลับไป
func handleConnectionListener(conn net.Conn) {
	defer func() {
		ClientMutex.Lock()
		for key, clientConn := range Clients {
			if clientConn == conn {
				ClearRoom(key)
				delete(Clients, key)
				break
			}
		}
		ClientMutex.Unlock()
		fmt.Println("Client disconnected:", conn.RemoteAddr())
		conn.Close()
	}()

	reader := bufio.NewReader(conn)
	for {
		fmt.Println("Waiting for data from client:", conn.RemoteAddr())
		receivePacket, err := reader.ReadString('\n')
		if err != nil {
			if err.Error() == "EOF" {
				fmt.Println("Client disconnected (EOF):", conn.RemoteAddr())
			} else {
				fmt.Printf("Error reading from client %s: %v\n", conn.RemoteAddr(), err)
			}
			return
		}

		receivePacket = strings.TrimSpace(receivePacket)
		if receivePacket == "" {
			fmt.Println("Empty packet received from client:", conn.RemoteAddr())
			continue
		}

		fmt.Println("Raw packet received:", receivePacket)

		// Handle PING Message
		if strings.HasPrefix(receivePacket, "PING") {
			if conn != nil {
				_, err := conn.Write([]byte("PONG"))
				if err != nil {
					fmt.Printf("Error sending PONG to client: %v\n", err)
					return
				}
				fmt.Println("Sent PONG to client")
			} else {
				fmt.Println("Connection is nil, cannot send PONG")
			}
			continue
		}

		message, err := models.DecryptMessage(receivePacket)
		if err != nil {
			fmt.Printf("Error decrypting message from %s: %v\n", conn.RemoteAddr(), err)
			return
		}

		message = strings.TrimSpace(message)
		fmt.Println("Decrypted message received:", message)

		if strings.HasPrefix(message, "REGISTER") {
			parts := strings.Split(message, " ")
			if len(parts) == 2 {
				clientID := parts[1]
				ClientMutex.Lock()
				Clients[clientID] = conn
				ClientMutex.Unlock()
				fmt.Println("Client registered:", clientID)
				// _, _ = fmt.Fprintln(conn, "REGISTER_SUCCESS")

				// ส่ง Header ระบุขนาดข้อมูลทั้งหมด (10 bytes)
				const headerSize int = 10
				var body string = "REGISTER_SUCCESS"
				encryptedMessage, err := models.EncryptMessage(body)
				if err != nil {
					fmt.Println("Error encrypting message:", err)
					return
				}

				totalBytes := len(encryptedMessage)

				repliedMessage := make([]byte, headerSize+totalBytes)
				copy(repliedMessage[:headerSize], fmt.Sprintf("%010d", totalBytes))
				copy(repliedMessage[headerSize:], encryptedMessage)

				fmt.Printf("Header: %s\n", repliedMessage[:headerSize])
				fmt.Printf("Full message: %s\n", repliedMessage)

				_, err = conn.Write(repliedMessage)
				if err != nil {
					fmt.Println("Error sending REGISTER_SUCCESS to client:", err)
					return
				}

			} else {
				fmt.Println("Invalid REGISTER message:", message)
			}
		} else {
			fmt.Println("Unknown message received:", message)
		}
	}
}

// SendToClient ส่งข้อความไปยัง client ที่ระบุ
func CheckConnection(clientID string, conn net.Conn) bool {
	if conn == nil {
		return false
	}

	// Send a simple heartbeat message
	// _, err := fmt.Fprintln(conn, "HEARTBEAT")
	const headerSize int = 10
	var message string = "HEARTBEAT"
	encryptedMessage, err := models.EncryptMessage(message)

	totalBytes := len(encryptedMessage)

	repliedMessage := make([]byte, headerSize+totalBytes)
	copy(repliedMessage[:headerSize], fmt.Sprintf("%010d", totalBytes))
	copy(repliedMessage[headerSize:], encryptedMessage)

	if err != nil {
		fmt.Printf("Client %s is disconnected (heartbeat failed): %v\n", clientID, err)
		return false
	}

	_, err = conn.Write(repliedMessage)

	if err != nil {
		fmt.Printf("Client %s is disconnected (heartbeat failed): %v\n", clientID, err)
		return false
	}
	return true
}

// MonitorClients checks active Clients periodically
func MonitorClients() {
	for {
		ClientMutex.Lock()
		for clientID, conn := range Clients {
			if !CheckConnection(clientID, conn) {
				// Remove disconnected client
				fmt.Printf("Removing client: %s\n", clientID)
				delete(Clients, clientID)
				conn.Close()
			}
		}
		ClientMutex.Unlock()

		// Wait before checking again
		time.Sleep(5 * time.Second)
	}
}

// ListConnectedClients แสดงรายชื่อ client ที่เชื่อมต่อในปัจจุบัน
func ListConnectedClients() {
	ClientMutex.Lock()
	defer ClientMutex.Unlock()

	fmt.Println("Currently connected Clients:")
	if len(Clients) == 0 {
		fmt.Println("No Clients connected.")
		return
	}

	for clientID, conn := range Clients {
		fmt.Printf("Client ID: %s, Address: %s\n", clientID, conn.RemoteAddr())
	}
}

// StartTCPListener สร้าง TCP server และรอรับการเชื่อมต่อจาก client
func StartTCPListener() {
	listener, err := net.Listen("tcp", ":44405")
	if err != nil {
		fmt.Println("Error starting server:", err)
		return
	}
	defer listener.Close()

	fmt.Println("Server is listening on port 44405")

	// Start the client monitoring goroutine
	go MonitorClients()

	// เริ่ม loop เพื่อตรวจสอบ client ที่เชื่อมต่อทุก 10 วินาที
	go func() {
		for {
			ListConnectedClients()
			// รอ 10 วินาทีก่อนแสดงผลใหม่
			time.Sleep(10 * time.Second)
		}
	}()

	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Error accepting connection:", err)
			continue
		}
		fmt.Println("New client connected:", conn.RemoteAddr())
		go handleConnectionListener(conn)
	}
}

// ตรวจสอบว่า Client ออกจาก server หรือไม่ และทำอะไรต่อหลังจากนั้น
func ClearRoom(client string) {
	// Check and remove room from redis.
	roomKey, err := GetRedisKey("Character_Room_" + client)
	if err != nil {
		fmt.Println("Error: failed to get room key from Redis", err)
		return
	}

	if roomKey != "" {
		// Get room data
		roomJSONList, err := GetRedisKeyListValue("Room_" + roomKey)
		if err != nil {
			fmt.Println("Error: failed to get room data from Redis", err)
			return
		}

		var room models.Room
		err = json.Unmarshal([]byte(strings.Join(roomJSONList, "")), &room)
		if err != nil {
			fmt.Println("Error: failed to parse room JSON", err)
			return
		}

		// Remove character from room
		if utils.Contains(room.Character, client) {
			room.Character = utils.RemoveStringFromSlice(room.Character, client)
		}

		// if no more character in room, remove room from redis
		if len(room.Character) == 0 {
			err = DeleteRedisKey("Room_" + roomKey)
			if err != nil {
				fmt.Println("Error: failed to delete room from Redis", err)
				return
			}
		} else {
			// Save room back to redis
			roomJSON, err := json.Marshal(room)
			if err != nil {
				fmt.Println("Error: failed to marshal room JSON", err)
				return
			}

			err = SetRedisKey("Room_"+roomKey, string(roomJSON))
			if err != nil {
				fmt.Println("Error: failed to save room back to Redis", err)
				return
			}
		}

		// Remove room key from character
		err = DeleteRedisKey("Character_Room_" + client)
		if err != nil {
			fmt.Println("Error: failed to delete room key from character", err)
			return
		}
	}
}

func GetCharacter(name string) (models.CharacterInfo, bool) {
	charsMu.RLock()
	defer charsMu.RUnlock()

	char, ok := Characters[name]
	return char, ok
}

func SetCharacter(name string, info models.CharacterInfo) {
	charsMu.Lock()
	defer charsMu.Unlock()

	Characters[name] = info
}

func HasCharacter(name string) bool {
	charsMu.RLock()
	defer charsMu.RUnlock()

	_, ok := Characters[name]
	return ok
}
