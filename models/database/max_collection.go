package database

import (
	"encoding/json"
	"fmt"
	"time"
)

// MaxMsCollection is a master data table that stores information about collections.
type MaxMsCollection struct {
	MsCollectionID     int       `json:"ms_collection_id" gorm:"primaryKey;autoIncrement;column:ms_collection_id"`
	Title              string    `json:"title" gorm:"size:256;column:collection_title"`
	CollectionTypeID   int       `json:"collection_type_id" gorm:"index;column:collection_type_id"`
	CollectionPrevious *int      `json:"collection_previous" gorm:"default:null;column:collection_previous"`
	CreatedBy          string    `json:"created_by" gorm:"size:100;column:created_by"`
	CreatedAt          time.Time `json:"created_at" gorm:"autoCreateTime;column:created_at"`
	UpdatedAt          time.Time `json:"updated_at" gorm:"autoUpdateTime;column:updated_at"`
}

func (m MaxMsCollection) TableName() string {
	return "max_ms_collection"
}

func (m MaxMsCollection) ToJSON() string {
	jsonData, _ := json.Marshal(m)
	return string(jsonData)
}

func (m MaxMsCollection) ToDataString() string {
	return fmt.Sprintf("%d,%s,%d,%v,%s,%s,%s",
		m.MsCollectionID, m.Title, m.CollectionTypeID, m.CollectionPrevious, m.CreatedBy, m.CreatedAt, m.UpdatedAt)
}

// MaxMsCollectionReward is a master data table that stores rewards associated with collections.
type MaxMsCollectionReward struct {
	MaxCollectionRewardID int       `json:"max_collection_reward_id" gorm:"primaryKey;autoIncrement;column:max_collection_reward_id"`
	MsCollectionID        int       `json:"ms_collection_id" gorm:"index;column:ms_collection_id"`
	MsCollectionBuffID    int       `json:"ms_collection_buff_id" gorm:"index;column:ms_collection_buff_id"`
	CollectionType        int       `json:"collection_type" gorm:"index;column:collection_type"`
	ItemID                int       `json:"item_id" gorm:"index;column:item_id"`
	ItemValue             int       `json:"item_value" gorm:"column:item_value"`
	CreatedAt             time.Time `json:"created_at" gorm:"autoCreateTime;column:created_at"`
	UpdatedAt             time.Time `json:"updated_at" gorm:"autoUpdateTime;column:updated_at"`
}

func (m MaxMsCollectionReward) TableName() string {
	return "max_ms_collection_reward"
}

func (m MaxMsCollectionReward) ToJSON() string {
	jsonData, _ := json.Marshal(m)
	return string(jsonData)
}

func (m MaxMsCollectionReward) ToDataString() string {
	return fmt.Sprintf("%d,%d,%d,%d,%d,%d,%s,%s",
		m.MaxCollectionRewardID, m.MsCollectionID, m.MsCollectionBuffID, m.CollectionType, m.ItemID, m.ItemValue, m.CreatedAt, m.UpdatedAt)
}

// MaxMsCollectionRequire is a master data table that stores the requirements needed for collections.
type MaxMsCollectionRequire struct {
	MyCollectionRequireID int `json:"collection_require_id" gorm:"primaryKey;autoIncrement;column:collection_require_id"`
	MsCollectionID        int `json:"collection_id" gorm:"index;column:collection_id"`
	ItemID                int `json:"item_id" gorm:"index;column:item_id"`
	ItemValue             int `json:"item_value" gorm:"column:item_value"`
}

func (m MaxMsCollectionRequire) TableName() string {
	return "max_ms_collection_require"
}

func (m MaxMsCollectionRequire) ToJSON() string {
	jsonData, _ := json.Marshal(m)
	return string(jsonData)
}

func (m MaxMsCollectionRequire) ToDataString() string {
	return fmt.Sprintf("%d,%d,%d,%d", m.MyCollectionRequireID, m.MsCollectionID, m.ItemID, m.ItemValue)
}

// MaxMyCollection is a transaction table that stores user-specific collection data.
type MaxMyCollection struct {
	MyCollectionID int        `json:"my_collection_id" gorm:"primaryKey;autoIncrement;column:my_collection_id"`
	CharactionKey  int        `json:"charaction_key" gorm:"index;column:charaction_key"`
	MsCollectionID int        `json:"ms_collection_id" gorm:"index;column:ms_collection_id"`
	CompletedAt    *time.Time `json:"is_completed" gorm:"default:null;column:is_completed"`
	CreatedAt      time.Time  `json:"created_at" gorm:"autoCreateTime;column:created_at"`
	UpdatedAt      time.Time  `json:"updated_at" gorm:"autoUpdateTime;column:updated_at"`
}

func (m MaxMyCollection) TableName() string {
	return "max_my_collection"
}

func (m MaxMyCollection) ToJSON() string {
	jsonData, _ := json.Marshal(m)
	return string(jsonData)
}

func (m MaxMyCollection) ToDataString() string {
	return fmt.Sprintf("%d,%d,%d,%s,%s,%s",
		m.MyCollectionID, m.CharactionKey, m.MsCollectionID, m.CompletedAt, m.CreatedAt, m.UpdatedAt)
}

// MaxMyCollectionRecord is a transaction table that records the progress of user collections.
type MaxMyCollectionRecord struct {
	MyCollectionRecordID int        `json:"my_collection_record_id" gorm:"primaryKey;autoIncrement;column:my_collection_record_id"`
	MyCollectionID       int        `json:"my_collection_id" gorm:"index;column:my_collection_id"`
	ItemID               int        `json:"item_id" gorm:"index;column:item_id"`
	RegisteredAt         *time.Time `json:"registered_at" gorm:"column:registered_at"`
	CreatedAt            time.Time  `json:"created_at" gorm:"autoCreateTime;column:created_at"`
	UpdatedAt            time.Time  `json:"updated_at" gorm:"autoUpdateTime;column:updated_at"`
}

func (m MaxMyCollectionRecord) TableName() string {
	return "max_tr_my_collection_record"
}

func (m MaxMyCollectionRecord) ToJSON() string {
	jsonData, _ := json.Marshal(m)
	return string(jsonData)
}

func (m MaxMyCollectionRecord) ToDataString() string {
	return fmt.Sprintf("%d,%d,%d,%s,%s,%s",
		m.MyCollectionRecordID, m.MyCollectionID, m.ItemID, m.RegisteredAt, m.CreatedAt, m.UpdatedAt)
}

// MaxMsCollectionType is a master data table that stores different types of collections.
type MaxMsCollectionType struct {
	MyCollectionTypeID   int    `json:"my_collection_type_id" gorm:"primaryKey;autoIncrement;column:my_collection_type_id"`
	MyCollectionTypeName string `json:"my_collection_type_name" gorm:"size:255;column:my_collection_type_name"`
}

func (m MaxMsCollectionType) TableName() string {
	return "max_ms_collection_type"
}

func (m MaxMsCollectionType) ToJSON() string {
	jsonData, _ := json.Marshal(m)
	return string(jsonData)
}

func (m MaxMsCollectionType) ToDataString() string {
	return fmt.Sprintf("%d,%s", m.MyCollectionTypeID, m.MyCollectionTypeName)
}

// MaxMsCollectionBuff is a master data table that stores the buffs and character statistics for collections.
type MaxMsCollectionBuff struct {
	MsCollectionBuffID          int       `json:"ms_collection_buff_id" gorm:"primaryKey;autoIncrement;column:ms_collection_buff_id"`
	BuffTitleEnum               string    `json:"buff_title_enum" gorm:"size:255;column:buff_title_enum"`
	CharacterStatATKSTR         int       `json:"character_stat_atk_str" gorm:"default:0;column:character_stat_atk_str"`
	CharacterStatATKGRA         int       `json:"character_stat_atk_gra" gorm:"default:0;column:character_stat_atk_gra"`
	CharacterStatDEFSTR         int       `json:"character_stat_def_str" gorm:"default:0;column:character_stat_def_str"`
	CharacterStatDEFGRA         int       `json:"character_stat_def_gra" gorm:"default:0;column:character_stat_def_gra"`
	CharacterStatCRI            int       `json:"character_stat_cri" gorm:"default:0;column:character_stat_cri"`
	CharacterStatHP             int       `json:"character_stat_hp" gorm:"default:0;column:character_stat_hp"`
	CharacterStatSP             int       `json:"character_stat_sp" gorm:"default:0;column:character_stat_sp"`
	CharacterStatTEAMATTACK     int       `json:"character_stat_team_attack" gorm:"default:0;column:character_stat_team_attack"`
	CharacterStatTEAMDEFENCE    int       `json:"character_stat_team_defence" gorm:"default:0;column:character_stat_team_defence"`
	CharacterStatDOUBLEATTACK   int       `json:"character_stat_double_attack" gorm:"default:0;column:character_stat_double_attack"`
	CharacterStatDOUBLEDEFENCE  int       `json:"character_stat_double_defence" gorm:"default:0;column:character_stat_double_defence"`
	CharacterStatSPECIALATTACK  int       `json:"character_stat_special_attack" gorm:"default:0;column:character_stat_special_attack"`
	CharacterStatSPECIALDEFENCE int       `json:"character_stat_special_defence" gorm:"default:0;column:character_stat_special_defence"`
	CharacterStatCRITICALDAMAGE int       `json:"character_stat_critical_damage" gorm:"default:0;column:character_stat_critical_damage"`
	CreatedAt                   time.Time `json:"created_at" gorm:"autoCreateTime;column:created_at"`
	UpdatedAt                   time.Time `json:"updated_at" gorm:"autoUpdateTime;column:updated_at"`
}

func (m MaxMsCollectionBuff) TableName() string {
	return "max_ms_collection_buff"
}

func (m MaxMsCollectionBuff) ToJSON() string {
	jsonData, _ := json.Marshal(m)
	return string(jsonData)
}

func (m MaxMsCollectionBuff) ToDataString() string {
	return fmt.Sprintf("%d,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%s",
		m.MsCollectionBuffID, m.BuffTitleEnum, m.CharacterStatATKSTR, m.CharacterStatATKGRA, m.CharacterStatDEFSTR,
		m.CharacterStatDEFGRA, m.CharacterStatCRI, m.CharacterStatHP, m.CharacterStatSP, m.CharacterStatTEAMATTACK,
		m.CharacterStatTEAMDEFENCE, m.CharacterStatDOUBLEATTACK, m.CharacterStatDOUBLEDEFENCE,
		m.CharacterStatSPECIALATTACK, m.CharacterStatSPECIALDEFENCE, m.CharacterStatCRITICALDAMAGE,
		m.CreatedAt, m.UpdatedAt)
}
