package database

import "fmt"

//Struct of the data that will using store data in Database

type ProcederGetBehaviorScore struct {
	Character_Key   int    `gorm:"column:character_key"`
	Username        string `gorm:"column:name"`
	Behaviour_score int    `gorm:"column:behaviour_score"`
}

// func (MsStarChecking) TableName() string {
// 	return "ms_ranking"
// }

// // ToString returns a string representation of the MsRanking struct
func (m ProcederGetBehaviorScore) ToString() string {
	//return fmt.Sprintf("MsRanking{RankID: %d, RankName: %s, BadgePath: %s, BadgePosX: %d, BadgePosY: %d}",
	return fmt.Sprintf("%d,%s,%d",
		m.Character_Key, m.Username, m.Behaviour_score)
}
