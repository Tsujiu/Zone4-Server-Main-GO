package database

//Struct of the data that will using store data in Database

import (
	"encoding/json"
	"fmt"
)

type MsRanking struct {
	RankID            int    `gorm:"column:RankID;primaryKey"`
	RankName          string `gorm:"column:rank_name"`
	BadgePath         string `gorm:"column:badge_path"`
	BadgePosX         int    `gorm:"column:badge_pos_x"`
	BadgePosY         int    `gorm:"column:badge_pos_y"`
	Character_ID      int    `gorm:"column:character_key"`
	Rank_Stars        int    `gorm:"column:current_rank"`
	CharacterName     string `gorm:"column:name"`
	Level             int    `gorm:"column:level"`
	Protection_points int    `gorm:"column:rank_protection_points"`
	Behaviour_score   int    `gorm:"column:behaviour_score"`
	// Min_star  int    `gorm:"column:min_star"`
	// Max_star  int    `gorm:"column:max_star"`

}

func (MsRanking) TableName() string {
	return "ms_ranking"
}

// ToString returns a string representation of the MsRanking struct
func (m MsRanking) ToString() string {
	//return fmt.Sprintf("MsRanking{RankID: %d, RankName: %s, BadgePath: %s, BadgePosX: %d, BadgePosY: %d}",
	return fmt.Sprintf("%d,%s,%s,%d,%d,%d,%d,%s,%d,%d",
		m.RankID, m.RankName, m.BadgePath, m.BadgePosX, m.BadgePosY, m.Character_ID, m.Rank_Stars, m.CharacterName, m.Protection_points, m.Level)
}

func (m MsRanking) ToJson() string {

	res, err := json.Marshal(m)
	if err != nil {
		return ""
	}

	return string(res)
}
