package databases

import (
	"encoding/json"
	"maxion-zone4/config"
	"maxion-zone4/models/database"
	"maxion-zone4/services"
	"testing"
)

// test ListMaxMyCollectionByCharacterID

func TestListMaxMyCollectionByCharacterID(t *testing.T) {

	data, err := ListMaxMyCollectionByCharacterID(1)
	if err != nil {
		t.Error(err)
	}
	dataJson, _ := json.Marshal(data)
	t.Log(string(dataJson))
	if len(data) == 0 {
		t.Error("data not found")
	}

}

func TestInsertMaxMyCollectionRecord(t *testing.T) {

	data := database.MaxMyCollectionRecord{

		MyCollectionRecordID: 1,
		ItemID:               1,
		// RegisteredAt:         time.Now(),
	}

	err := CreateMaxMyCollectionRecord(&data)
	if err != nil {
		t.Error(err)
	}
}

func TestMain(m *testing.M) {
	config.LoadConfigTestLocal()
	services.DBGameConnect()
	// services.DBGameInventoryConnect()
	m.Run()
}
