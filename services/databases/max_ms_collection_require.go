package databases

import (
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// list and get

func ListMaxMsCollectionRequires() ([]*database.MaxMsCollectionRequire, error) {

	var maxMsCollectionRequires []*database.MaxMsCollectionRequire
	err := services.GameDB.Find(&maxMsCollectionRequires).Error
	if err != nil {
		return nil, err
	}

	return maxMsCollectionRequires, nil

}

func GetMaxMsCollectionRequireByID(id int) (*database.MaxMsCollectionRequire, error) {

	var maxMsCollectionRequire database.MaxMsCollectionRequire
	// gorm find
	err := services.GameDB.Where("ms_collection_require_id = ?", id).Find(&maxMsCollectionRequire).Error
	if err != nil {
		return nil, err
	}

	return &maxMsCollectionRequire, nil

}
