package controllers

import (
	"bytes"
	"compress/gzip"
	"encoding/base64"
	"fmt"
	"io"
	"log"
	"maxion-zone4/config"
	"maxion-zone4/controllers/packet"
	"maxion-zone4/models"
	"maxion-zone4/utils"
	"net"
	"strings"
	"sync"
)

var mutex = &sync.Mutex{}

// IsBase64 ตรวจสอบว่าข้อความที่รับเข้ามาเป็น Base64 หรือไม่
func IsBase64(s string) bool {
	// ลอง decode
	_, err := base64.StdEncoding.DecodeString(s)
	// ถ้า err != nil → decode ไม่สำเร็จ → ไม่ใช่ Base64
	return err == nil
}

// DecompressData ใช้สำหรับถอดรหัสข้อมูล
func DecompressData(data []byte) (string, error) {
	buf := bytes.NewReader(data)
	gz, err := gzip.NewReader(buf)
	if err != nil {
		return "", err
	}
	defer gz.Close()

	var result bytes.Buffer
	_, err = io.Copy(&result, gz)
	if err != nil {
		return "", err
	}

	return result.String(), nil
}

// StartTCPServer เริ่มต้น TCP server
func StartTCPServer() {
	addr := ":" + strings.TrimPrefix(config.AppConfig["TCP_PORT"], ":")
	listener, err := net.Listen("tcp", addr)
	if err != nil {
		log.Fatal("Error starting TCP server:", err)
	}
	defer listener.Close()
	fmt.Println("TCP server listening on", addr)

	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Println("Error accepting TCP connection:", err)
			continue
		}

		clientAddr := conn.RemoteAddr().String()
		fmt.Println("New TCP connection from:", clientAddr)

		tcpConn := conn.(*net.TCPConn)
		tcpConn.SetReadBuffer(65536) // เพิ่ม Buffer 64 KB
		tcpConn.SetWriteBuffer(65536)

		go handleTCPConnection(conn)
	}
}

// handleTCPConnection รับข้อมูลจาก TCP connection
func handleTCPConnection(conn net.Conn) {
	defer func() {
		conn.Close()
	}()

	config.Conn = conn

	clientAddr := conn.RemoteAddr().String()

	buffer := make([]byte, 1024)

	// อ่านข้อมูลจาก TCP connection
	n, err := conn.Read(buffer)
	if err != nil {
		log.Println("Error reading TCP data from", clientAddr, ":", err)
		return
	}
	encryptedMessage := string(buffer[:n])

	fmt.Println("Received TCP data from", clientAddr, ":", encryptedMessage)

	// ตรวจสอบข้อความที่ได้รับว่าเป็น Base64 หรือไม่
	if !IsBase64(encryptedMessage) {
		log.Println("Invalid Base64 message")
		return
	}

	// ถอดรหัสข้อความที่ได้รับ
	receivePacket, err := models.DecryptMessage(encryptedMessage)
	if err != nil {
		log.Println("Error decrypting message:", err)
		return
	}

	fmt.Println("Decrypted message:", receivePacket)

	message := strings.Split(receivePacket, "|")[1]
	username := strings.Split(message, ",")[0]
	mutex.Lock()
	utils.Accounts[username] = conn
	mutex.Unlock()

	// แปลงข้อความที่ได้รับเป็น packet และทำการประมวลผล
	packet.ProcessTCPSingle(receivePacket, username)

	// Close the connection
	mutex.Lock()
	delete(utils.Accounts, clientAddr)
	mutex.Unlock()
}

// StartUDPServer เริ่มต้น UDP server
func StartUDPServer() {
	addr := ":" + strings.TrimPrefix(config.AppConfig["UDP_PORT"], ":")
	udpAddr, err := net.ResolveUDPAddr("udp", addr)
	if err != nil {
		log.Fatal("Error resolving UDP address:", err)
	}

	conn, err := net.ListenUDP("udp", udpAddr)
	if err != nil {
		log.Fatal("Error starting UDP server:", err)
	}
	config.ConnUDP = conn
	defer conn.Close()
	fmt.Println("UDP server listening on", addr)

	buffer := make([]byte, 1024)
	for {
		n, clientAddr, err := conn.ReadFromUDP(buffer)
		if err != nil {
			log.Println("Error reading UDP data:", err)
			continue
		}

		config.Addr = clientAddr

		// Decrypt the received message
		encryptedMessage := string(buffer[:n])

		// Check if the message is Base64 encoded
		if !IsBase64(encryptedMessage) {
			log.Println("Invalid Base64 message")
			return
		}

		decryptedMessage, err := models.DecryptMessage(encryptedMessage)
		if err != nil {
			log.Println("Error decrypting message:", err)
			return
		}

		// Process the packet
		packet.ProcessUDP(decryptedMessage, clientAddr)
	}
}
