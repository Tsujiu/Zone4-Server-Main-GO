package database

import (
	"time"
)

type Character struct {
	AccountID          string    `gorm:"type:varchar(10);column:AccountID;not null;"`
	Name               string    `gorm:"type:varchar(10);not null;unique"`
	CLevel             int       `gorm:"type:int"`
	LevelUpPoint       int       `gorm:"type:int"`
	Class              uint8     `gorm:"type:tinyint"`
	Experience         int64     `gorm:"type:bigint"`
	Strength           int       `gorm:"type:int"`
	Dexterity          int       `gorm:"type:int"`
	Vitality           int       `gorm:"type:int"`
	Energy             int       `gorm:"type:int"`
	MagicList          []byte    `gorm:"type:varbinary(2250)"`
	Money              int       `gorm:"type:int"`
	Life               float32   `gorm:"type:real"`
	MaxLife            float32   `gorm:"type:real"`
	Mana               float32   `gorm:"type:real"`
	MaxMana            float32   `gorm:"type:real"`
	MapNumber          int16     `gorm:"type:smallint"`
	MapPosX            int16     `gorm:"type:smallint"`
	MapPosY            int16     `gorm:"type:smallint"`
	MapDir             uint8     `gorm:"type:tinyint"`
	PkCount            int       `gorm:"type:int"`
	PkLevel            int       `gorm:"type:int"`
	PkTime             int       `gorm:"type:int"`
	MDate              time.Time `gorm:"type:smalldatetime"`
	LDate              time.Time `gorm:"type:smalldatetime"`
	CtlCode            uint8     `gorm:"type:tinyint"`
	Quest              []byte    `gorm:"type:varbinary(100)"`
	Leadership         int       `gorm:"type:int"`
	ChatLimitTime      int16     `gorm:"type:smallint"`
	Resets             int       `gorm:"column:RESETS;type:int"`
	Inventory          []byte    `gorm:"type:varbinary(7648)"`
	Married            int       `gorm:"type:int"`
	MarryName          string    `gorm:"type:varchar(10)"`
	MLevel             int       `gorm:"type:int"`
	MlPoint            int       `gorm:"type:int"`
	MlExperience       int64     `gorm:"type:bigint"`
	MlNextExp          int64     `gorm:"type:bigint"`
	InventoryExpansion uint8     `gorm:"type:tinyint"`
	WinDuels           int       `gorm:"type:int"`
	LoseDuels          int       `gorm:"type:int"`
	PenaltyMask        int       `gorm:"type:int"`
	BlockChatTime      int64     `gorm:"type:bigint"`
	Ruud               int       `gorm:"type:int"`
	OpenHuntingLog     uint8     `gorm:"type:tinyint"`
	MuHelperData       []byte    `gorm:"type:varbinary(512)"`
	MuHelperPlusData   []byte    `gorm:"type:varbinary(512)"`
	StatCoin           int       `gorm:"type:int"`
	StatGP             int       `gorm:"type:int"`
	I4thSkillPoint     int       `gorm:"type:int"`
	AddStrength        int       `gorm:"type:int"`
	AddDexterity       int       `gorm:"type:int"`
	AddVitality        int       `gorm:"type:int"`
	AddEnergy          int       `gorm:"type:int"`
	GrandResets        uint8     `gorm:"type:tinyint"`
	MonStat            int       `gorm:"type:int"`
	PCR                int       `gorm:"type:int"`
	LVLB               int       `gorm:"type:int"`
	Age                int       `gorm:"type:int"`
	CJL                int       `gorm:"type:int"`
	FruitAddPoint      int       `gorm:"type:int"`
	FruitDecPoint      int       `gorm:"type:int"`
	SIC                uint8     `gorm:"type:tinyint"`
	WingCoreType       uint8     `gorm:"type:tinyint"`
	WingCoreLevel      uint8     `gorm:"type:tinyint"`
	GiantMountType     uint8     `gorm:"type:tinyint"`
	GiantMountWear     uint8     `gorm:"type:tinyint"`
}

func (Character) TableName() string {
	return "Character"
}
