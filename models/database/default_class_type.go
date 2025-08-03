package database

type DefaultClassType struct {
	Class          uint8   `gorm:"column:Class;primaryKey"`
	Strength       int16   `gorm:"column:Strength;type:smallint"`
	Dexterity      int16   `gorm:"column:Dexterity;type:smallint"`
	Vitality       int16   `gorm:"column:Vitality;type:smallint"`
	Energy         int16   `gorm:"column:Energy;type:smallint"`
	MagicList      []byte  `gorm:"column:MagicList;type:varbinary(2250)"`
	Life           float32 `gorm:"column:Life;type:real"`
	MaxLife        float32 `gorm:"column:MaxLife;type:real"`
	Mana           float32 `gorm:"column:Mana;type:real"`
	MaxMana        float32 `gorm:"column:MaxMana;type:real"`
	MapNumber      int16   `gorm:"column:MapNumber;type:smallint"`
	MapPosX        int16   `gorm:"column:MapPosX;type:smallint"`
	MapPosY        int16   `gorm:"column:MapPosY;type:smallint"`
	Quest          []byte  `gorm:"column:Quest;type:varbinary(100)"`
	DbVersion      uint8   `gorm:"column:DbVersion;type:tinyint"`
	Leadership     int16   `gorm:"column:Leadership;type:smallint"`
	Level          int16   `gorm:"column:Level;type:smallint"`
	LevelUpPoint   int16   `gorm:"column:LevelUpPoint;type:smallint"`
	Inventory      []byte  `gorm:"column:Inventory;type:varbinary(7648)"`
	LevelLife      float32 `gorm:"column:LevelLife;type:real"`
	LevelMana      float32 `gorm:"column:LevelMana;type:real"`
	VitalityToLife float32 `gorm:"column:VitalityToLife;type:real"`
	EnergyToMana   float32 `gorm:"column:EnergyToMana;type:real"`
	GateNumber     int16   `gorm:"column:GateNumber;type:smallint"`
}

func (DefaultClassType) TableName() string {
	return "DefaultClassType"
}
