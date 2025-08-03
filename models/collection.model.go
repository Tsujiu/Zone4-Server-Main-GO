package models

type Item_Collection_Inventory struct {
	CharacterKey int    `json:"character_key"`
	CreationTime string `json:"creation_time"`
	ExpireTime   string `json:"expire_time"`
	ExpireType   int    `json:"expire_type"`
	Guid         int64  `json:"guid"`
	Number       int    `json:"number"`
	Slot         int    `json:"slot"`
	Weared       bool   `json:"weared"`
	StatATK_GRA  int    `json:"statATK_GRA"`
	StatDEF_STR  int    `json:"statDEF_STR"`
	Kind1        int    `json:"kind1"`
	Kind2        int    `json:"kind2"`
	Level        int    `json:"level"`
	Bone         int    `json:"bone"`
	Style        int    `json:"style"`
	BuyPoint     int    `json:"buy_point"`
	Kind         int    `json:"kind"`
}

type Item_Collection_List struct {
	Active                int    `json:"active"`
	CategoryID            int    `json:"category_id"`
	CollectionID          int    `json:"collection_id"`
	CollectionName        string `json:"collection_name"`
	CreatedBy             string `json:"createdBy"`
	CreatedDate           string `json:"createdDate"`
	ListPath              string `json:"list_path"`
	RequiredCharacterType int    `json:"required_character_type"`
	RequiredClass         string `json:"required_class"`
	RequiredCurrency      string `json:"required_currency"`
	RequiredItem          string `json:"required_item"`
	RequiredLevel         int    `json:"required_level"`
	RequiredStat          string `json:"required_stat"`
	RewardCurrency        string `json:"reward_currency"`
	RewardItem            string `json:"reward_item"`
	RewardStat            string `json:"reward_stat"`
	Union                 int    `json:"union"`
	UpdatedBy             string `json:"updatedBy"`
	UpdatedDate           string `json:"updatedDate"`
	Matched               bool   `json:"matched"` // Remove default from here
}

type Histort_Item_Collection struct {
	CharacterCollectionID int    `json:"character_collection_id"`
	CharacterKey          int    `json:"character_key"`
	CollectionID          int    `json:"collection_id"`
	Item                  string `json:"item"`
	Stat                  string `json:"stat"`
	Level                 int    `json:"level"`
	Class                 string `json:"class"`
	CharacterType         int    `json:"character_type"`
	Currency              string `json:"currency"`
	Status                string `json:"status"`
	Active                int    `json:"active"`
	UpdatedDate           string `json:"updatedDate"`
	CategoryID            int    `json:"category_id"`
	ReceiveRewards        int    `json:"receive_rewards"`
}

type Reward_Stats struct {
	AtkStr     int `json:"atk_str"`
	AtkGra     int `json:"atk_gra"`
	AtkTeam    int `json:"atk_team"`
	AtkDouble  int `json:"atk_double"`
	AtkSpecial int `json:"atk_special"`
	DefStr     int `json:"def_str"`
	DefTeam    int `json:"def_team"`
	DefDouble  int `json:"def_double"`
	DefSpecial int `json:"def_special"`
	DefGra     int `json:"def_gra"`
}
