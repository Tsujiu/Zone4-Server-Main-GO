package databases

import (
	"log"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

func ModifyRankStar(character_key int, ModifierStat int) (database.ProcederReduceRank, error) {
	log.Println("Start ModifyRankStar ", character_key, ModifierStat)
	var procederReduceRank database.ProcederReduceRank
	err := services.GameDB.Raw("EXEC maxion_reduce_rank_set @character_key = ?, @modifier_stat = ?", character_key, ModifierStat).Scan(&procederReduceRank).Error
	if err != nil {
		log.Println(err)
		return database.ProcederReduceRank{}, err
	}
	log.Println("End ModifyRankStar: ", procederReduceRank)
	return procederReduceRank, nil
}
