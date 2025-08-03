package databases

import (
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// listMaxMsCollectionBuff lists all max_ms_collection_buff
func ListMaxMsCollectionBuff() ([]database.MaxMsCollectionBuff, error) {
	var maxMsCollectionBuff []database.MaxMsCollectionBuff
	err := services.GameDB.Find(&maxMsCollectionBuff).Error
	if err != nil {
		return nil, err
	}

	return maxMsCollectionBuff, nil
}

// getbuff by id
func GetMaxMsCollectionBuffByID(id int) (*database.MaxMsCollectionBuff, error) {
	var maxMsCollectionBuff database.MaxMsCollectionBuff
	// gorm find
	err := services.GameDB.Where("ms_collection_buff_id = ?", id).Find(&maxMsCollectionBuff).Error
	if err != nil {
		return nil, err
	}

	return &maxMsCollectionBuff, nil
}

func GetMaxMsCollectionBuffByBuffTitleEnum(buffTitleEnum string) (*database.MaxMsCollectionBuff, error) {
	var maxMsCollectionBuff database.MaxMsCollectionBuff
	// gorm find
	err := services.GameDB.Where("buff_title_enum = ?", buffTitleEnum).Find(&maxMsCollectionBuff).Error
	if err != nil {
		return nil, err
	}

	return &maxMsCollectionBuff, nil
}
