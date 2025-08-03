package database

type Channel struct {
	ChannelCode int    `gorm:"column:ChannelCode;primaryKey"`
	ServerCode  int    `gorm:"column:ServerCode;not null"`
	Visible     int    `gorm:"column:Visible;not null"`
	Name        string `gorm:"column:Name;type:varchar(255);not null"`
	Port        int    `gorm:"column:Visible;not null"`
}

func (Channel) TableName() string {
	return "Channel"
}
