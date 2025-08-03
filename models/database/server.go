package database

type Server struct {
	ServerCode int    `gorm:"column:ServerCode;primaryKey"`
	IP         string `gorm:"column:IP;type:varchar(255);not null"`
	Port       int    `gorm:"column:Port;not null"`
	Visible    int    `gorm:"column:Visible;not null"`
	Name       string `gorm:"column:Name;type:varchar(255);not null"`
	ButtonPos  int    `gorm:"column:ButtonPos;not null"`
	InfoText   string `gorm:"column:InfoText;type:text"`
}

func (Server) TableName() string {
	return "Servers"
}
