package databases

import (
	"log"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// Service that will call data from database into a slice of structs
func GetTsCharacter(Character_ID int) ([]database.Season, error) {
	log.Println("GetMsRank Input:", Character_ID)
	var Seasons []database.Season
	var Season_id = 1
	err := services.GameDB.Raw("EXEC maxion_crud_tr_character_in_team @Character_ID = ?, @season_id = ?, @mode = 0;", Character_ID, Season_id).Scan(&Seasons).Error
	if err != nil {
		log.Println(err)
		return nil, err
	}
	log.Println("GetTsCharacter Output:", Seasons)
	return Seasons, nil
}
