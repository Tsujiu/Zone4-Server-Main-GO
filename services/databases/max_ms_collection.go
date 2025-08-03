package databases

import (
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// get list and get collection
func ListMaxMsCollection() (list []database.MaxMsCollection, err error) {

	err = services.GameDB.Find(&list).Error
	if err != nil {
		return nil, err
	}

	return list, nil
}

func GetMaxMsCollectionByID(id int) (collection *database.MaxMsCollection, err error) {

	collection = new(database.MaxMsCollection)
	err = services.GameDB.Where("ms_collection_id = ?", id).Find(collection).Error
	if err != nil {
		return nil, err
	}

	return collection, nil

}
