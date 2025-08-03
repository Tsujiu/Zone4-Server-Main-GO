package services

import (
	"encoding/json"
	"log"
	"maxion-zone4/models"
)

func InitializeRedisMaster() {

	// Initital Load
	// go LoadCollection() // Nut Close
	// go LoadSeason() // Nut Close
	// go LoadRankRewardSeason() // Nut Close
	// go LoadRankRewardSeasonByRank() // Nut Close
	// go RegisterRankingBoardToRedis() // Nut Close
}

func LoadCollection() {
	var list []map[string]interface{}
	err := GameDB.Raw(`EXEC maxion_crud_collection_list`).Scan(&list).Error
	if err != nil {
		return
	}

	response, err := json.Marshal(list)
	if err != nil {
		return
	}
	err = SetRedisKey("collection_list", string(response))
	if err != nil {
		return
	}
}

func LoadSeason() {
	var list models.Season
	err := GameDB.Raw(`SELECT TOP 1 * FROM tr_rank_season WHERE active = ? ORDER BY season_id DESC`, "Y").Scan(&list).Error
	if err != nil {
		return
	}

	// Delete Rank_Season
	err = DeleteRedisKey("Rank_Season")
	if err != nil {
		return
	}

	response, err := json.Marshal(list)
	if err != nil {
		return
	}
	err = SetRedisKey("Rank_Season", string(response))
	if err != nil {
		return
	}
}

func LoadRankRewardSeason() {
	var list []models.RankingReward
	err := GameDB.Raw(`EXEC maxion_crud_tr_rank_season_reward @mode = ?`, 4).Scan(&list).Error
	if err != nil {
		return
	}

	// Delete Rank_Season_Reward
	err = DeleteRedisKey("Rank_Season_Reward")
	if err != nil {
		return
	}

	response, err := json.Marshal(list)
	if err != nil {
		return
	}
	err = SetRedisKey("Rank_Season_Reward", string(response))
	if err != nil {
		return
	}
}

func LoadRankRewardSeasonByRank() {
	var list []models.RankingRewardSeasonRank
	err := GameDB.Raw(`EXEC maxion_crud_tr_rank_season_reward @mode = ?`, 5).Scan(&list).Error
	if err != nil {
		return
	}

	response, err := json.Marshal(list)
	if err != nil {
		return
	}

	// Delete Rank_Season_Reward_Rank
	err = DeleteRedisKey("Rank_Season_Reward_Rank")
	if err != nil {
		return
	}

	err = SetRedisKey("Rank_Season_Reward_Rank", string(response))
	if err != nil {
		return
	}
}

func RegisterRankingBoardToRedis() {

	var rankingBoard []models.RankingBoard
	err := GameDB.Raw(`EXEC maxion_get_ranking_board`).Scan(&rankingBoard).Error
	if err != nil {
		log.Printf("Error in RegisterRankingBoardToRedis: %v", err)
		return
	}

	response, err := json.Marshal(rankingBoard)
	if err != nil {
		log.Printf("Error in RegisterRankingBoardToRedis: %v", err)
		return
	}

	err = SetRedisKey("RankingBoard", string(response))
	if err != nil {
		log.Printf("Error in RegisterRankingBoardToRedis: %v", err)
		return
	}
}
