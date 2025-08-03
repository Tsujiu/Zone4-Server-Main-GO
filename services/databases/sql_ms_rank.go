package databases

import (
	"log"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// Service that will call data from data base into struct
func GetMsRank(Character_ID int) (database.MsRanking, error) {
	log.Println("GetMsRank Input:", Character_ID)
	var Ms_Ranking database.MsRanking
	err := services.GameDB.Raw("EXEC maxion_getcharacter_ranking @Character_ID = ?;", Character_ID).Scan(&Ms_Ranking).Error
	if err != nil {
		log.Println(err)
		return database.MsRanking{}, err
	}
	log.Println("GetMsRank Output:", Ms_Ranking)
	return Ms_Ranking, nil
}
