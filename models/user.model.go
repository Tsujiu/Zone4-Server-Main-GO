package models

var User string

type RegisterUserDTO struct {
	ID            string   `json:"id"`
	ClassID       int      `json:"classId"`
	Coord         CoordDTO `json:"coord"`
	Username      string   `json:"userName"`      // ชื่อบัญชีผู้เล่น
	CharacterName string   `json:"characterName"` // ชื่อตัวละครในเกม
	MapNumber     int      `json:"mapNumber"`     // หมายเลขของแผนที่
}

type LogoutUserDTO struct {
	ID        string `json:"id"`
	ChannelID string `json:"channelID"`
}

type MoveDataDTO struct {
	OwnerID  string     `json:"ownerId"`
	Position Vec2       `json:"position"`
	Coords   []CoordDTO `json:"coords"`
	//TargetID string     `json:"targetId"`
	MapNumber int `json:"mapNumber"`
}

type CoordDTO struct {
	X int `json:"x"`
	Y int `json:"y"`
}
