package database

type AccountCharacter struct {
	Number                   int    `gorm:"column:Number;primaryKey;autoIncrement"`
	Id                       string `gorm:"column:Id;type:varchar(10);not null"`
	GameID1                  string `gorm:"column:GameID1;type:varchar(10)"`
	GameID2                  string `gorm:"column:GameID2;type:varchar(10)"`
	GameID3                  string `gorm:"column:GameID3;type:varchar(10)"`
	GameID4                  string `gorm:"column:GameID4;type:varchar(10)"`
	GameID5                  string `gorm:"column:GameID5;type:varchar(10)"`
	GameID6                  string `gorm:"column:GameID6;type:varchar(10)"`
	GameID7                  string `gorm:"column:GameID7;type:varchar(10)"`
	GameID8                  string `gorm:"column:GameID8;type:varchar(10)"`
	GameID9                  string `gorm:"column:GameID9;type:varchar(10)"`
	GameID10                 string `gorm:"column:GameID10;type:varchar(10)"`
	GameIDC                  string `gorm:"column:GameIDC;type:varchar(10)"`
	MoveCnt                  uint8  `gorm:"column:MoveCnt;type:tinyint"`
	Summoner                 uint8  `gorm:"column:Summoner;type:tinyint;not null"`
	WarehouseExpansion       uint8  `gorm:"column:WarehouseExpansion;type:tinyint;not null"`
	RageFighter              uint8  `gorm:"column:RageFighter;type:tinyint;not null"`
	SecCode                  int    `gorm:"column:SecCode;type:int;not null"`
	ILC                      int    `gorm:"column:ILC;type:int;not null"`
	GrowLancer               uint8  `gorm:"column:GrowLancer;type:tinyint;not null"`
	MagicGladiator           uint8  `gorm:"column:MagicGladiator;type:tinyint;not null"`
	DarkLord                 uint8  `gorm:"column:DarkLord;type:tinyint;not null"`
	RuneWizard               uint8  `gorm:"column:RuneWizard;type:tinyint;not null"`
	Slayer                   uint8  `gorm:"column:Slayer;type:tinyint;not null"`
	GunCrusher               *uint8 `gorm:"column:GunCrusher;type:tinyint"`
	LightWizard              *uint8 `gorm:"column:LightWizard;type:tinyint"`
	LemuriaMage              *uint8 `gorm:"column:LemuriaMage;type:tinyint"`
	IllusionKnight           *uint8 `gorm:"column:IllusionKnight;type:tinyint"`
	LastCreateDate           *int64 `gorm:"column:LastCreateDate;type:bigint"`
	CharacterCreateCountUsed int    `gorm:"column:CharacterCreateCountUsed;type:int;not null"`
}

func (AccountCharacter) TableName() string {
	return "AccountCharacter"
}
