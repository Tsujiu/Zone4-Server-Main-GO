package databases

import (
	"fmt"
	"log"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
	"time"

	"gorm.io/gorm"
)

//crud

func ListMaxMyCollection() (list []database.MaxMyCollection, err error) {

	err = services.GameDB.Find(&list).Error
	if err != nil {
		return nil, err
	}

	return list, nil
}

func GetMaxMyCollectionByID(id int) (collection *database.MaxMyCollection, err error) {

	collection = new(database.MaxMyCollection)
	err = services.GameDB.Where("my_collection_id = ?", id).Find(collection).Error
	if err != nil {
		return nil, err
	}
	return collection, nil
}

func GetMaxMyCollectionByCharacterID(id int) (collection *database.MaxMyCollection, err error) {

	collection = new(database.MaxMyCollection)
	err = services.GameDB.Where("character_id = ?", id).Find(collection).Error
	if err != nil {
		return nil, err
	}
	return collection, nil

}

func GetMaxMyCollectionByCharacterIDFullJoin(id int) (collection *database.MaxMyCollection, err error) {

	collection = new(database.MaxMyCollection)
	err = services.GameDB.Where("character_id = ?", id).Find(collection).Error
	if err != nil {
		return nil, err
	}

	return collection, nil
}

func GetMaxMyCollectionByCollectionID(id int) (collection *database.MaxMyCollection, err error) {

	collection = new(database.MaxMyCollection)
	err = services.GameDB.Where("ms_collection_id = ?", id).Find(collection).Error
	if err != nil {
		return nil, err
	}
	return collection, nil
}
func CreateMaxMyCollection(collection *database.MaxMyCollection) (err error) {

	err = services.GameDB.Create(collection).Error
	if err != nil {
		return err
	}

	return nil
}

func UpdateMaxMyCollection(collection *database.MaxMyCollection) (err error) {

	err = services.GameDB.Save(collection).Error
	if err != nil {
		return err
	}

	return nil
}

type MaxMyCollectionInfo struct {
	database.MaxMsCollection
	IsCompleted bool `json:"is_completed"`
}
type CollectionProgress struct {
	CollectionID       int        `json:"collection_id"`
	CollectionTitle    string     `json:"collection_title"`
	CollectionTypeID   int        `json:"collection_type_id"`
	CollectionPrevious *int       `json:"collection_previous"` // Nullable field
	MyCollectionID     *int       `json:"my_collection_id"`    // Nullable field
	CompletedAt        *time.Time `json:"completed_at"`        // Nullable field
	CreatedBy          string     `json:"created_by"`
	CreatedAt          time.Time  `json:"created_at"`
	UpdatedAt          time.Time  `json:"updated_at"`
	// omitted fields
	CollectionRequirements []database.MaxMsCollectionRequire `json:"collection_requirements,omitempty"`
	CollectionReward       []database.MaxMsCollectionReward  `json:"collection_reward,omitempty"`
	CollectionRedeem       []database.MaxMyCollectionRecord  `json:"collection_redeemed,omitempty"`
	CollectionType         []database.MaxMsCollectionType    `json:"collection_type,omitempty"`
}

type MyCollectionResponse struct {
	Collections []CollectionProgress `json:"collections"`
}

func ListMaxMyCollectionByCharacterID(characterKey int) ([]CollectionProgress, error) {
	// Note Task in client
	// [x] get msg convert to struct
	// [] lua function call for render and clear data in interface (implement to lua file for relation)
	// [] Note add pagination + join item_type get patch img (implement to relation go and update struct for path name)

	rows, err := services.GameDB.Raw("EXEC maxion_manage_collection_process @character_key = ?", characterKey).Rows()
	if err != nil {
		log.Fatal("Failed to execute stored procedure:", err)
	}
	defer rows.Close()

	// Slice to hold the results
	var results []CollectionProgress

	// Iterate through the result set
	for rows.Next() {
		var progress CollectionProgress
		err := rows.Scan(
			&progress.CollectionID,
			&progress.CollectionTitle,
			&progress.CollectionTypeID,
			&progress.CollectionPrevious,
			&progress.MyCollectionID,
			&progress.CompletedAt,
			&progress.CreatedBy,
			&progress.CreatedAt,
			&progress.UpdatedAt,
		)
		if err != nil {
			log.Fatal("Failed to scan row:", err)
		}
		var requirements []database.MaxMsCollectionRequire
		err = services.GameDB.Where("collection_id = ?", progress.CollectionID).Find(&requirements).Error
		if err != nil {
			return nil, err
		}
		progress.CollectionRequirements = requirements

		var rewards []database.MaxMsCollectionReward
		err = services.GameDB.Where("collection_id = ?", progress.CollectionID).Find(&rewards).Error
		if err != nil {
			return nil, err
		}
		progress.CollectionReward = rewards

		var redeemed []database.MaxMyCollectionRecord
		err = services.GameDB.Where("my_collection_id = ?", progress.MyCollectionID).Find(&redeemed).Error
		if err != nil {
			return nil, err
		}
		progress.CollectionRedeem = redeemed

		var collectionType []database.MaxMsCollectionType
		err = services.GameDB.Where("my_collection_type_id = ?", progress.CollectionTypeID).Find(&collectionType).Error
		if err != nil {
			return nil, err
		}
		progress.CollectionType = collectionType

		results = append(results, progress)
	}

	return results, nil
}

func UpdateMaxMyCollectionByCharacterID(characterID, collectionID int) (*MaxMyCollectionInfo, error) {
	var collection MaxMyCollectionInfo
	err := services.GameDB.Raw(`EXEC ManageCollectionProgress @character_key = ?, @ms_collection_id = ?`, characterID, collectionID).Scan(&collection).Error
	if err != nil {
		return nil, err
	}

	return &collection, nil
}

func UpdateCompletdMaxMyCollectionByCharacterID(characterID, collectionID int) (*MaxMyCollectionInfo, error) {
	var collection MaxMyCollectionInfo
	err := services.GameDB.Raw(`EXEC ManageCollectionProgress @character_key = ?, @ms_collection_id = ?, @is_completed = 1`, characterID, collectionID).Scan(&collection).Error
	if err != nil {
		return nil, err
	}

	return &collection, nil
}

type CollectionData struct {
	MsCollectionID     int
	CollectionTitle    string
	CollectionTypeID   int
	CollectionPrevious int
	MyCollectionID     int
	CompletedAt        *time.Time
	CreatedBy          string
	CreatedAt          time.Time
	UpdatedAt          time.Time
}

func ManageCollectionProgress(characterKey, collectionID int, isCompleted bool) ([]CollectionData, error) {
	var results []CollectionData
	gameDB := services.GameDB
	// 1. Select data with GORM
	err := gameDB.Table("max_ms_collection AS ms_c").
		Select("ms_c.ms_collection_id, ms_c.title AS collection_title, ms_c.collection_type_id, ms_c.collection_previous, "+
			"my_c.my_collection_id, my_c.completed_at, ms_c.created_by, ms_c.created_at, ms_c.updated_at").
		Joins("LEFT JOIN max_my_collection AS my_c ON ms_c.ms_collection_id = my_c.ms_collection_id AND my_c.charaction_key = ?", characterKey).
		Joins("LEFT JOIN max_my_collection AS prev_mc ON ms_c.collection_previous = prev_mc.ms_collection_id AND prev_mc.charaction_key = ?", characterKey).
		Where("(my_c.completed_at IS NULL OR my_c.my_collection_id IS NULL OR my_c.my_collection_id IS NOT NULL)").
		Where("(ms_c.collection_previous IS NULL OR prev_mc.completed_at IS NOT NULL)").
		Order("ms_c.ms_collection_id").
		Scan(&results).Error

	if err != nil {
		return nil, fmt.Errorf("error executing select query: %v", err)
	}

	// 2. Upsert into max_my_collection
	var myCollection database.MaxMyCollection
	if err := gameDB.Where("charaction_key = ? AND ms_collection_id = ?", characterKey, collectionID).First(&myCollection).Error; err != nil {
		if err == gorm.ErrRecordNotFound {
			// Insert if no record exists
			now := time.Now()
			myCollection = database.MaxMyCollection{
				CharactionKey:  characterKey,
				MsCollectionID: collectionID,
				CreatedAt:      now,
				UpdatedAt:      now,
			}
			if isCompleted {

				myCollection.CompletedAt = &now
			}
			if err := gameDB.Create(&myCollection).Error; err != nil {
				return nil, fmt.Errorf("error inserting into max_my_collection: %v", err)
			}
		} else {
			return nil, fmt.Errorf("error checking existence in max_my_collection: %v", err)
		}
	} else {
		// Update if record exists
		if isCompleted {
			now := time.Now()
			myCollection.CompletedAt = &now
		} else {
			myCollection.CompletedAt = nil
		}
		myCollection.UpdatedAt = time.Now()
		if err := gameDB.Save(&myCollection).Error; err != nil {
			return nil, fmt.Errorf("error updating max_my_collection: %v", err)
		}
	}

	// 3. Insert into max_my_collection_record for each requirement if not exists
	var requirements []database.MaxMsCollectionRequire
	if err := gameDB.Where("ms_collection_id = ?", collectionID).Find(&requirements).Error; err != nil {
		return nil, fmt.Errorf("error fetching requirements: %v", err)
	}

	for _, req := range requirements {
		var recordExists bool
		if err := gameDB.Model(&database.MaxMsCollectionRequire{}).
			Select("COUNT(1) > 0").
			Where("my_collection_id = ? AND item_id = ?", myCollection.MyCollectionID, req.ItemID).
			Find(&recordExists).Error; err != nil {
			return nil, fmt.Errorf("error checking record existence: %v", err)
		}

		if !recordExists {
			record := database.MaxMyCollectionRecord{
				MyCollectionID: myCollection.MyCollectionID,
				ItemID:         req.ItemID,
				RegisteredAt:   nil,
				CreatedAt:      time.Now(),
				UpdatedAt:      time.Now(),
			}
			if err := gameDB.Create(&record).Error; err != nil {
				return nil, fmt.Errorf("error inserting into max_my_collection_record: %v", err)
			}
		}

	}

	return results, nil
}

type CharacterCollectionData struct {
	CollectionID            int                               `json:"collection_id"`
	Title                   string                            `json:"title"`
	CollectionTypeID        int                               `json:"collection_type_id"`
	CollectionPrevious      *int                              `json:"collection_previous,omitempty"` // Nullable
	CreatedBy               string                            `json:"created_by"`
	CharacterKey            *int                              `json:"character_key"`
	CompletedAt             *time.Time                        `json:"completed_at,omitempty"` // Nullable
	CollectionRequirements  []database.MaxMsCollectionRequire `json:"collection_requirements,omitempty"`
	MaxTrMyCollectionReward []database.MaxMsCollectionReward  `json:"collection_reward,omitempty"`
	Fav                     *bool                             `json:"fav"`
	CreatedAt               *time.Time                        `json:"created_at"`
	UpdatedAt               *time.Time                        `json:"updated_at"`
}

func ListMyCollectionByCollectionTypeIdAndCharacter(characterKey int) (map[int]interface{}, error) {
	mapData := make(map[int]interface{})
	mapDataType := make(map[int]interface{})
	sql := `SELECT [collection_id]
				,[title]
				,[collection_type_id]
				,[collection_previous]
				,[created_by]
				,[character_key]
				,[completed_at]
				,ISNULL([fav],0) as fav
				,tc.[created_at]
				,tc.[updated_at]
			FROM [game].[dbo].[max_ms_collection]  as mc
			left join [dbo].[max_tr_my_collection] tc on tc.[ms_collection_id] = mc.[collection_id]  and character_key = ? order by fav desc,collection_id ASC;`
	rows, err := services.GameDB.Raw(sql, characterKey).Rows()
	if err != nil {
		log.Println(err)
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var collection CharacterCollectionData
		err := rows.Scan(
			&collection.CollectionID,
			&collection.Title,
			&collection.CollectionTypeID,
			&collection.CollectionPrevious,
			&collection.CreatedBy,
			&collection.CharacterKey,
			&collection.CompletedAt,
			&collection.Fav,
			&collection.CreatedAt,
			&collection.UpdatedAt)
		if err != nil {
			log.Println(err)
			return nil, err
		}
		// select collection requirements
		var requirements []database.MaxMsCollectionRequire
		err = services.GameDB.Where("collection_id = ?", collection.CollectionID).Find(&requirements).Error
		if err != nil {
			return nil, err
		}
		var rewards []database.MaxMsCollectionReward
		err = services.GameDB.Where("collection_id = ?", collection.CollectionID).Find(&rewards).Error
		if err != nil {
			return nil, err
		}
		collection.CollectionRequirements = requirements
		mapData[collection.CollectionID] = collection
		mapDataType[collection.CollectionTypeID] = mapData[collection.CollectionID]
	}
	return mapData, nil

}

type DataCollection struct {
	CollectionID       int       `json:"collection_id"`
	Title              string    `json:"title"`
	CollectionTypeID   int       `json:"collection_type_id"`
	CollectionPrevious *int      `json:"collection_previous"`
	CreatedBy          string    `json:"created_by"`
	CreatedAt          time.Time `json:"created_at"`
	UpdatedAt          time.Time `json:"updated_at"`
}

func ListALLCollection() (map[int]interface{}, error) {
	// mapCollectionData := make(map[int]interface{})
	mapCollectionType := make(map[int]interface{})

	sql := `SELECT [collection_id]
				,[title]
				,[collection_type_id]
				,[collection_previous]
				,[created_by]
				,[created_at]
				,[updated_at]
			FROM [game].[dbo].[max_ms_collection]  as mc`

	rows, err := services.GameDB.Raw(sql).Rows()
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		dataCollection := DataCollection{}
		err := rows.Scan(
			&dataCollection.CollectionID,
			&dataCollection.Title,
			&dataCollection.CollectionTypeID,
			&dataCollection.CollectionPrevious,
			&dataCollection.CreatedBy,
			&dataCollection.CreatedAt,
			&dataCollection.UpdatedAt)
		if err != nil {
			log.Println("ListALLCollection:", err)
			return nil, err
		}

		mapCollectionType[dataCollection.CollectionTypeID] = dataCollection

	}
	return mapCollectionType, nil
}

type InventoryData struct {
	CharacterKey int `json:"character_key"`
	Slot         int `json:"slot"`
	Number       int `json:"number"`
	Weared       int `json:"weared"`
	ExpireType   int `json:"expire_type"`
	CreationTime time.Time
	ExpireTime   time.Time
	StatATK_STR  int    `json:"statATK_STR"`
	StatATK_GRA  int    `json:"statATK_GRA"` // is value of item this is wtf record in db on statATK_GRA
	StatDEF_STR  int    `json:"statDEF_STR"`
	StatDEF_GRA  int    `json:"statDEF_GRA"`
	StatCRI      int    `json:"statCRI"`
	StatHP       int    `json:"statHP"`
	StatSP       int    `json:"statSP"`
	StatDEX      int    `json:"statDEX"`
	StatDEF      int    `json:"statDEF"`
	StatATK      int    `json:"statATK"`
	GUID         string `json:"guid"`
}

func GetItemInventoryByItemNumber(itemNumber int, characterKey int) ([]InventoryData, error) {
	itenInventory := make([]InventoryData, 0)
	sql := `SELECT [character_key]
					,[slot]
					,[number]
					,[weared]
					,[expire_type]
					,[creation_time]
					,[expire_time]
					,[statATK_STR]
					,[statATK_GRA]
					,[statDEF_STR]
					,[statDEF_GRA]
					,[statCRI]
					,[statHP]
					,[statSP]
					,[statDEX]
					,[statDEF]
					,[statATK]
					,[guid]
 	FROM [game_inventory].[dbo].[inventory]`
	rows, err := services.GameInventoryDB.Raw(sql).Rows()
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var inventory InventoryData
		err := rows.Scan(&inventory.CharacterKey, &inventory.Slot, &inventory.Number, &inventory.Weared, &inventory.ExpireType, &inventory.CreationTime, &inventory.ExpireTime, &inventory.StatATK_STR, &inventory.StatATK_GRA, &inventory.StatDEF_STR, &inventory.StatDEF_GRA, &inventory.StatCRI, &inventory.StatHP, &inventory.StatSP, &inventory.StatDEX, &inventory.StatDEF, &inventory.StatATK, &inventory.GUID)
		if err != nil {
			return nil, err
		}

		itenInventory = append(itenInventory, inventory)
	}
	return itenInventory, nil
}

func RegisterItemToCollection(characterKey, collectionID, number, slot, value int) error {
	txDBGame := services.GameDB.Begin()
	txDBGameInventory := services.GameInventoryDB.Begin()
	defer func() {
		if r := recover(); r != nil {
			txDBGame.Rollback()
			txDBGameInventory.Rollback()
		}
	}()
	sqlSelect := `SELECT TOP (1s) [my_collection_record_id]
					,[my_collection_id]
					,[item_id]
					,[registered_at]
					,[created_at]
					,[updated_at]
				FROM [game].[dbo].[max_tr_my_collection_record]
				`
	rows, err := services.GameDB.Raw(sqlSelect).Rows()
	if err != nil {
		return err
	}
	defer rows.Close()
	var collectionRecord database.MaxMyCollectionRecord
	for rows.Next() {
		err := rows.Scan(&collectionRecord.MyCollectionRecordID, &collectionRecord.MyCollectionID, &collectionRecord.ItemID, &collectionRecord.RegisteredAt, &collectionRecord.CreatedAt, &collectionRecord.UpdatedAt)
		if err != nil {
			return err
		}
	}
	// validate collection is not empty
	if collectionRecord.MyCollectionRecordID == 0 {
		return fmt.Errorf("collection is empty")
	}
	// update collection record  ref  PROCEDURE [dbo].[item__destroyitem_2012_0613]
	// check value for register item on value or register item on slot
	sqlSelectInventory := `SELECT [character_key]
					,[slot]
					,[number]
					,[weared]
					,[expire_type]
					,[creation_time]
					,[expire_time]
					,[statATK_STR]
					,[statATK_GRA] 
					,[statDEF_STR]
					,[statDEF_GRA]
					,[statCRI]
					,[statHP]
					,[statSP]
					,[statDEX]
					,[statDEF]
					,[statATK]
					,[guid]
				FROM [game_inventory].[dbo].[inventory]
				WHERE character_key = ? AND slot = ? AND number = ?;
	`
	rows, err = txDBGameInventory.Raw(sqlSelectInventory, characterKey, slot, number).Rows()
	if err != nil {
		return err
	}
	defer rows.Close()
	var inventory InventoryData
	for rows.Next() {
		err := rows.Scan(&inventory.CharacterKey, &inventory.Slot, &inventory.Number, &inventory.Weared, &inventory.ExpireType, &inventory.CreationTime, &inventory.ExpireTime, &inventory.StatATK_STR, &inventory.StatATK_GRA, &inventory.StatDEF_STR, &inventory.StatDEF_GRA, &inventory.StatCRI, &inventory.StatHP, &inventory.StatSP, &inventory.StatDEX, &inventory.StatDEF, &inventory.StatATK, &inventory.GUID)
		if err != nil {
			return err
		}
	}

	if inventory.CharacterKey == 0 {
		return fmt.Errorf("inventory is empty")
	}
	// validate value item
	itemValue := inventory.StatATK_GRA
	if itemValue == 0 {
		return fmt.Errorf("value item is empty")
	}

	if value > itemValue {
		return fmt.Errorf("value item is not enough")
	}
	// update value item
	itemValue = itemValue - value
	if itemValue == 0 {
		// delete item
		sqlDeleteInventory := `UPDATE [game_inventory].[dbo].[inventory] SET number = 0, guid = 0, statATK_STR = 0, statATK_GRA = 0 
		WHERE character_key = @character_key AND slot = @slot`
		query := txDBGameInventory.Exec(sqlDeleteInventory, characterKey, slot)
		if query.Error != nil {
			return query.Error
		}
		if query.RowsAffected == 0 {
			return fmt.Errorf("delete item failed")
		}
	} else {
		sqlUpdateInventory := `UPDATE [game_inventory].[dbo].[inventory]
							SET [statATK_GRA] = ?
							WHERE character_key = ? AND slot = ? AND number = ?;
		`
		query := txDBGameInventory.Exec(sqlUpdateInventory, itemValue, characterKey, slot, number)
		if query.Error != nil {
			return query.Error
		}
		if query.RowsAffected == 0 {
			return fmt.Errorf("update item failed")
		}

	}
	// update collection record
	dateNow := time.Now()
	collectionRecord.RegisteredAt = &dateNow
	collectionRecord.UpdatedAt = dateNow
	query := txDBGame.Save(&collectionRecord)
	if query.Error != nil {
		return query.Error
	}
	// commit
	txDBGame.Commit()
	txDBGameInventory.Commit()
	log.Println(dateNow, "RegisterItemToCollection success | characterKey: ", characterKey, " collectionID: ", collectionID, " number: ", number, " slot: ", slot, " value: ", value)
	return nil

}

type MaxTrMyCollectionRecord struct {
	MyCollectionRecordID int       `json:"my_collection_record_id"`
	MyCollectionID       int       `json:"my_collection_id"`
	ItemID               int       `json:"item_id"`
	RegisteredAt         time.Time `json:"registered_at"`
	CreatedAt            time.Time `json:"created_at"`
	UpdatedAt            time.Time `json:"updated_at"`
}

func GetCollectionDataByCharacterKey(characterKey, collectionID int) ([]MaxTrMyCollectionRecord, error) {
	var myCollection []MaxTrMyCollectionRecord
	sql := `SELECT [my_collection_record_id]
      ,[my_collection_id]
      ,[item_id]
      ,[registered_at]
      ,[created_at]
      ,[updated_at]
  FROM [game].[dbo].[max_tr_my_collection_record`

	rows, err := services.GameDB.Raw(sql).Rows()
	if err != nil {
		log.Println("error GetCollectionDataByCharacterKey query row:", err)
		return nil, err
	}
	defer rows.Close()
	for rows.Next() {
		var collection MaxTrMyCollectionRecord
		err := rows.Scan(&collection.MyCollectionID, &collection.ItemID, &collection.RegisteredAt, &collection.CreatedAt, &collection.UpdatedAt)
		if err != nil {
			log.Panicln("error GetCollectionDataByCharacterKey scan rows : ", err)
			return nil, err
		}
		myCollection = append(myCollection, collection)
	}
	return myCollection, nil
}

func GetCollectionDataByRecordID(MyCollectionRecordID int) (MaxTrMyCollectionRecord, error) {
	var recordData MaxTrMyCollectionRecord

	err := services.GameDB.Model(&recordData).Where("my_collection_record_id = ?", MyCollectionRecordID)

	if err != nil {
		log.Println("error GetCollectionDataByRecordID : ", err)
	}

	return recordData, nil
}
