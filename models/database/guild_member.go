package database

type GuildMember struct {
	Name    string `gorm:"column:Name;type:varchar(10);primaryKey"`
	GName   string `gorm:"column:G_Name;type:varchar(8);not null"`
	GLevel  uint8  `gorm:"column:G_Level;type:tinyint"`
	GStatus uint8  `gorm:"column:G_Status;type:tinyint;not null"`
}

// TableName overrides the table name used by GORM.
func (GuildMember) TableName() string {
	return "GuildMember"
}
