package database

import "time"

type Friend struct {
	CharacterKey int64     `json:"character_key" db:"character_key"`
	FriendKey    int64     `json:"friend_key" db:"friend_key"`
	RegisterTime time.Time `json:"register_time" db:"register_time"`
}

// TableName overrides the table name used by GORM.
func (Friend) TableName() string {
	return "friend"
}
