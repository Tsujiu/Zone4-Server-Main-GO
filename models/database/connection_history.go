package database

import (
	"time"
)

type ConnectionHistory struct {
	ID          int       `gorm:"primaryKey;autoIncrement;column:ID"`
	AccountID   string    `gorm:"type:varchar(10);column:AccountID"`
	ServerCode  int       `gorm:"column:ServerCode"`
	ServerName  string    `gorm:"type:varchar(40);column:ServerName"`
	ChannelCode int       `gorm:"column:ChannelCode"`
	ChannelName string    `gorm:"type:varchar(40);column:ChannelName"`
	IP          string    `gorm:"type:varchar(16);column:IP"`
	Date        time.Time `gorm:"type:datetime;column:Date"`
	State       int       `gorm:"column:State"`
	HWID        string    `gorm:"type:varchar(100);column:HWID"`
}

func (ConnectionHistory) TableName() string {
	return "ConnectionHistory"
}
