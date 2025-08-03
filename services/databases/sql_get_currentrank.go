package databases

import (
	"log"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// Service that will call data from data base into struct
func GetCurrentRank(Name string) (database.CurrentRank, error) {
	log.Println("GetCurrentRank Input:", Name)
	var CurrentRank database.CurrentRank
	err := services.GameDB.Raw("EXEC maxion_get_currentrank_by_name @Character_Name = ?;", Name).Scan(&CurrentRank).Error
	if err != nil {
		log.Println(err)
		return database.CurrentRank{}, err
	}
	log.Println("GetCurrentRank Output:", CurrentRank)
	return CurrentRank, nil
}
