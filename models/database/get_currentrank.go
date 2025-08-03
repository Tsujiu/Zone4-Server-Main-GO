package database

//Struct of the data that will using store data in Database

import (
	"fmt"
)

type CurrentRank struct {
	CurrentRankStar int `gorm:"column:current_rank"`
}

func (m CurrentRank) ToString() string {
	//return fmt.Sprintf("MsRanking{RankID: %d, RankName: %s, BadgePath: %s, BadgePosX: %d, BadgePosY: %d}",
	return fmt.Sprintf("%d", m.CurrentRankStar)
}
