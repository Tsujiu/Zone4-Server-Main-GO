package databases

import (
	"log"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

func ModifyBehaviorScore(character_key int, ModifierStat int) (database.ProcederGetBehaviorScore, error) {
	log.Println("Start ModifyRankStar ", character_key, ModifierStat)
	var ProcederGetBehaviorScore database.ProcederGetBehaviorScore
	err := services.GameDB.Raw("EXEC maxion_update_behaviour_score @character_key = ?, @modifier_stat = ?",
		character_key, ModifierStat).
		Scan(&ProcederGetBehaviorScore).Error
	if err != nil {
		log.Println(err)
		return database.ProcederGetBehaviorScore{}, err
	}
	log.Println("End ModifyRankStar: ", ProcederGetBehaviorScore)
	return ProcederGetBehaviorScore, nil
}
