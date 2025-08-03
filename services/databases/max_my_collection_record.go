package databases

import (
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

func ListMaxMyCollectionRecord() (list []database.MaxMyCollectionRecord, err error) {

	err = services.GameDB.Find(&list).Error
	if err != nil {
		return nil, err
	}

	return list, nil
}

func GetMaxMyCollectionRecordByID(id int) (collectionRecord *database.MaxMyCollectionRecord, err error) {

	collectionRecord = new(database.MaxMyCollectionRecord)
	err = services.GameDB.Where("my_collection_record_id = ?", id).Find(collectionRecord).Error
	if err != nil {
		return nil, err
	}

	return collectionRecord, nil

}

func GetMaxMyCollectionRecordByCollectionID(id int) (collectionRecord *database.MaxMyCollectionRecord, err error) {

	collectionRecord = new(database.MaxMyCollectionRecord)
	err = services.GameDB.Where("ms_collection_id = ?", id).Find(collectionRecord).Error
	if err != nil {
		return nil, err
	}

	return collectionRecord, nil

}

// create only
func CreateMaxMyCollectionRecord(collectionRecord *database.MaxMyCollectionRecord) (err error) {

	err = services.GameDB.Create(collectionRecord).Error
	if err != nil {
		return err
	}

	return nil
}
