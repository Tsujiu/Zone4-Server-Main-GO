package database

//Struct of the data that will using store data in Database

import (
	"fmt"
)

type Season struct {
	ID           int    `gorm:"column:id"`
	Character_id int    `gorm:"column:character_id;"`
	Season_id    int    `gorm:"column:season_id"`
	Match_id     int    `gorm:"column:match_id;"`
	Team_id      int    `gorm:"column:team_id"`
	Total_damage int    `gorm:"column:total_damage"`
	Kill         int    `gorm:"column:kill"`
	Death        int    `gorm:"column:death"`
	Assist       int    `gorm:"column:assist"`
	Point        int    `gorm:"column:point"`
	Mvp          int    `gorm:"column:mvp"`
	Match_result string `gorm:"column:match_result"`
	Updated_date string `gorm:"column:updated_date"`
	MapID        int    `gorm:"column:map_id"`
	Mode         int    `gorm:"column:mode"`
}

// ToString returns a string representation of the MsRanking struct
func (m Season) ToString() string {
	//return fmt.Sprintf("MsRanking{RankID: %d, RankName: %s, BadgePath: %s, BadgePosX: %d, BadgePosY: %d}",
	return fmt.Sprintf("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%s,%s,%d,%d",
		m.ID,
		m.Character_id,
		m.Season_id,
		m.Match_id,
		m.Team_id,
		m.Total_damage,
		m.Kill,
		m.Death,
		m.Assist,
		m.Point,
		m.Mvp,
		m.Match_result,
		m.Updated_date,
		m.MapID,
		m.Mode)
}
