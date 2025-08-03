package shared

import (
	"net"
	"sync"
)

type UDPClient struct {
	Addr          *net.UDPAddr
	NetworkID     string
	Position      Coordinates
	ClassID       int    // เพิ่ม ClassID เข้าไป
	Username      string // ชื่อบัญชีผู้เล่น
	CharacterName string // ชื่อตัวละครในเกม
	MapNumber     int    // หมายเลขของแผนที่
}

type Coordinates struct {
	X int `json:"x"`
	Y int `json:"y"`
}

var (
	UDPClients      = make(map[string]*UDPClient)
	UDPClientsMutex = sync.RWMutex{}
)

func GetUDPAddrByUsername(username string) *net.UDPAddr {
	UDPClientsMutex.Lock()
	defer UDPClientsMutex.Unlock()

	for _, client := range UDPClients {
		if client.Username == username {
			return client.Addr
		}
	}
	return nil
}
