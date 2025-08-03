package database

import "fmt"

//Struct of the data that will using store data in Database

type ProcederReduceRank struct {
	Character_Key    int    `gorm:"column:character_key"`
	RankStar         int    `gorm:"column:current_rank"`
	Username         string `gorm:"column:name"`
	Protection_point int    `gorm:"column:rank_protection_points"`
}

// func (MsStarChecking) TableName() string {
// 	return "ms_ranking"
// }

// // ToString returns a string representation of the MsRanking struct
func (m ProcederReduceRank) ToString() string {
	//return fmt.Sprintf("MsRanking{RankID: %d, RankName: %s, BadgePath: %s, BadgePosX: %d, BadgePosY: %d}",
	return fmt.Sprintf("%d,%d,%s,%d",
		m.Character_Key, m.RankStar, m.Username, m.Protection_point)
}
