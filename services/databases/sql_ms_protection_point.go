package databases

import (
	"log"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

func AddProtectionPoint(character_key int, IsMVP int) (database.ProcederProtectionPoint, error) {
	var procederProtectionPoint database.ProcederProtectionPoint
	err := services.GameDB.Raw("EXEC maxion_update_protection_point @character_key = ?, @MVP= ?", character_key, IsMVP).Scan(&procederProtectionPoint).Error
	if err != nil {
		log.Println(err)
		return database.ProcederProtectionPoint{}, err
	}
	log.Println(procederProtectionPoint)
	return procederProtectionPoint, nil
}
