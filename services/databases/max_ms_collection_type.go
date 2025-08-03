package databases

import (
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// list get collection type

func ListMaxMsCollectionType() (list []database.MaxMsCollectionType, err error) {

	err = services.GameDB.Find(&list).Error
	if err != nil {
		return nil, err
	}

	return list, nil
}

func GetMaxMsCollectionTypeByID(id int) (collectionType *database.MaxMsCollectionType, err error) {

	collectionType = new(database.MaxMsCollectionType)
	err = services.GameDB.Where("ms_collection_type_id = ?", id).Find(collectionType).Error
	if err != nil {
		return nil, err
	}

	return collectionType, nil

}
