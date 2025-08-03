package database

import "time"

type MemberStatus struct {
	MembID       string     `gorm:"primaryKey;column:memb___id;type:varchar(20)"`
	ConnectStat  uint8      `gorm:"column:ConnectStat;type:tinyint;not null"`
	ServerCode   int        `gorm:"column:ServerCode;type:int;not null"`
	ServerName   string     `gorm:"column:ServerName;type:varchar(20);not null"`
	IP           string     `gorm:"column:IP;type:varchar(20);not null"`
	MAC          *string    `gorm:"column:MAC;type:varchar(25);null"`
	DeviceId     *string    `gorm:"column:DeviceId;type:varchar(50);null"`
	ConnectTM    time.Time  `gorm:"column:ConnectTM;type:datetime;not null"`
	DisConnectTM *time.Time `gorm:"column:DisConnectTM;type:datetime;null"`
}

func (MemberStatus) TableName() string {
	return "member_status"
}
