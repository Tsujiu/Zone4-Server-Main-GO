package databases

import (
	"maxion-zone4/models/database"
	"maxion-zone4/services"
)

// list and get reward

func ListMaxMsCollectionReward() (list []database.MaxMsCollectionReward, err error) {

	err = services.GameDB.Find(&list).Error
	if err != nil {
		return nil, err
	}

	return list, nil
}

func GetMaxMsCollectionRewardByID(id int) (reward *database.MaxMsCollectionReward, err error) {

	reward = new(database.MaxMsCollectionReward)
	err = services.GameDB.Where("ms_collection_reward_id = ?", id).Find(reward).Error
	if err != nil {
		return nil, err
	}

	return reward, nil

}
