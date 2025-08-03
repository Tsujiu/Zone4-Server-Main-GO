package models

import (
	"time"
)

// GameTime สมมุติว่าเป็นโครงสร้างสำหรับจัดการเวลาของเกม
// ในที่นี้ใช้ time.Time ของ Go แทน หากมีโครงสร้างเฉพาะให้เปลี่ยนแปลงตามที่ต้องการ
type GameTime time.Time

// ข้อมูลตัวละคร [tt_get_characters_by_user_key_ex_20100528]
type CharacterInfo struct {
	UserKey           int       `json:"user_key"`
	CharacterKey      int       `json:"character_key"`
	CharacterSlot     int       `json:"character_slot"`
	Name              string    `json:"name"`
	CharType          int       `json:"type"` // เพราะ 'type' เป็น keyword ใน Go
	Promotion         int       `json:"promotion"`
	Style             string    `json:"style"`
	CharacterDeleted  int       `json:"character_deleted"`
	CreationTime      time.Time `json:"creation_time"`
	LastSelectionTime time.Time `json:"last_selection_time"`
	Tutorial          int       `json:"tutorial"`
	FirstFail         int       `json:"first_fail"`
	DungeonCoin       int       `json:"dungeon_coin"`
	Money             int       `json:"money"`
	Level             int       `json:"level"`
	Experience        int       `json:"experience"`
	LastZone          int       `json:"last_zone"`
	LadderGroup       int       `json:"ladder_group"`
	LadderGrade       int       `json:"ladder_grade"`
	LadderExp         int       `json:"ladder_exp"`
	Life              int       `json:"life"`
	Fatigue           int       `json:"fatigue"`
	WeardCostumeFlag  int       `json:"weard_costume_flag"`
	Attribute         int       `json:"attribute"`
	PromotionLevel    int       `json:"promotion_level"`
	CharacterColor    int       `json:"character_color"`
	AtkStr            int       `json:"atk_str"`
	AtkGra            int       `json:"atk_gra"`
	AtkTeam           int       `json:"atk_team"`
	AtkDouble         int       `json:"atk_double"`
	AtkSpecial        int       `json:"atk_special"`
	DefStr            int       `json:"def_str"`
	DefTeam           int       `json:"def_team"`
	DefDouble         int       `json:"def_double"`
	DefSpecial        int       `json:"def_special"`
	DefGra            int       `json:"def_gra"`

	// ช่องที่อาจเป็น NULL ให้เป็น pointer
	StatTotal   *int `json:"stat_total"`
	CurrentRank *int `json:"current_rank"`
}

// ไอเทมที่อยู่ในตัวละคร [item_get_items_by_character_key_20120605]
type CharacterItem struct {
	CharacterKey int        `json:"character_key"`
	Slot         int        `json:"slot"`
	Number       int        `json:"number"`
	Weared       bool       `json:"weared"`
	ExpireType   int        `json:"expire_type"`
	CreationTime time.Time  `json:"creation_time"`
	ExpireTime   *time.Time `json:"expire_time"`

	StatATKStr *int `json:"statATK_STR"`
	StatATKGra *int `json:"statATK_GRA"`
	StatDEFStr *int `json:"statDEF_STR"`
	StatDEFGra *int `json:"statDEF_GRA"`
	StatCRI    *int `json:"statCRI"`
	StatHP     *int `json:"statHP"`
	StatSP     *int `json:"statSP"`
	StatDEX    *int `json:"statDEX"`
	StatDEF    *int `json:"statDEF"`
	StatATK    *int `json:"statATK"`

	GUID *int64 `json:"guid"` // NULL (bigint)

	Hotpicks6  *int `json:"hotpicks6"`
	Hotpicks7  *int `json:"hotpicks7"`
	Hotpicks8  *int `json:"hotpicks8"`
	Hotpicks9  *int `json:"hotpicks9"`
	Hotpicks10 *int `json:"hotpicks10"`
	Hotpicks11 *int `json:"hotpicks11"`
	Hotpicks12 *int `json:"hotpicks12"`
	Hotpicks13 *int `json:"hotpicks13"`
	Hotpicks14 *int `json:"hotpicks14"`
	Hotpicks15 *int `json:"hotpicks15"`
	Hotpicks16 *int `json:"hotpicks16"`
	Hotpicks17 *int `json:"hotpicks17"`
	Hotpicks18 *int `json:"hotpicks18"`

	Kind1 *int `json:"kind1"`
	Kind2 *int `json:"kind2"`
	Kind3 *int `json:"kind3"`
	Kind4 *int `json:"kind4"`
	Kind5 *int `json:"kind5"`

	Ability1  *int `json:"ability1"`
	Ability2  *int `json:"ability2"`
	Ability3  *int `json:"ability3"`
	Ability4  *int `json:"ability4"`
	Ability5  *int `json:"ability5"`
	Ability6  *int `json:"ability6"`
	Ability7  *int `json:"ability7"`
	Ability8  *int `json:"ability8"`
	Ability9  *int `json:"ability9"`
	Ability10 *int `json:"ability10"`
	Ability11 *int `json:"ability11"`
	Ability12 *int `json:"ability12"`
	Ability13 *int `json:"ability13"`
	Ability14 *int `json:"ability14"`
}

// ไอเทม Wear ในตัวละคร [character_weared_costume_flag__get_20100226]
type CharacterWeardCostumeOption struct {
	Option [32]byte `json:"weard_costume_option"`
}

// ไอเทมใน Inventory [inventory__get_by_character_key_20090327]
type CharacterInventoryItem struct {
	CharacterKey int        `json:"character_key"`
	Slot         int        `json:"slot"`
	Number       int        `json:"number"`
	Weared       bool       `json:"weared"`
	ExpireType   int        `json:"expire_type"`
	CreationTime time.Time  `json:"creation_time"`
	ExpireTime   *time.Time `json:"expire_time,omitempty"`

	StatATKSTR *int `json:"statATK_STR,omitempty"`
	StatATKGRA *int `json:"statATK_GRA,omitempty"`
	StatDEFSTR *int `json:"statDEF_STR,omitempty"`
	StatDEFGRA *int `json:"statDEF_GRA,omitempty"`
	StatCRI    *int `json:"statCRI,omitempty"`
	StatHP     *int `json:"statHP,omitempty"`
	StatSP     *int `json:"statSP,omitempty"`
	StatDEX    *int `json:"statDEX,omitempty"`
	StatDEF    *int `json:"statDEF,omitempty"`
	StatATK    *int `json:"statATK,omitempty"`

	GUID *int64 `json:"guid,omitempty"`
}

// ข้อมูล Stat ตัวละคร [maxion_get_character_infomation]
type CharacterStats struct {
	AtkStr      int `json:"atk_str"`
	AtkGra      int `json:"atk_gra"`
	AtkTeam     int `json:"atk_team"`
	AtkDouble   int `json:"atk_double"`
	AtkSpecial  int `json:"atk_special"`
	DefStr      int `json:"def_str"`
	DefTeam     int `json:"def_team"`
	DefDouble   int `json:"def_double"`
	DefSpecial  int `json:"def_special"`
	DefGra      int `json:"def_gra"`
	StatTotal   int `json:"stat_total"`
	Level       int `json:"level"`
	Type        int `json:"type"`
	CurrentRank int `json:"current_rank"`
}

// ข้อมูลแก๊งตัวละคร [group__get_group_name_2010_0211]
type CharacterGroupInfo struct {
	GroupKey   int64  `json:"group_key"`
	GroupName  string `json:"group_name"`
	EmblemKey  int64  `json:"emblem_key"`
	GroupTitle string `json:"group_title"`
}

// ข้อมูลสถิติตัวละคร [get_character_rankinfo]
type CharacterRankingData struct {
	CharacterKey                   int  `json:"character_key"`
	TotalExpLevel                  int  `json:"total_exp_level"`
	TotalExp                       int  `json:"total_exp"`
	TotalExpRank                   int  `json:"total_exp_rank"`
	TotalExpRankYesterday          int  `json:"total_exp_rank_yesterday"`
	BattleExpLevel                 int  `json:"battle_exp_level"`
	BattleExp                      int  `json:"battle_exp"`
	BattleExpRank                  int  `json:"battle_exp_rank"`
	BattleExpRankYesterday         int  `json:"battle_exp_rank_yesterday"`
	DungeonExpLevel                *int `json:"dungeon_exp_level"` // ใช้ pointer *int เพราะอาจเป็น NULL
	DungeonExp                     int  `json:"dungeon_exp"`
	DungeonExpRank                 int  `json:"dungeon_exp_rank"`
	DungeonExpRankYesterday        int  `json:"dungeon_exp_rank_yesterday"`
	MvpCountLevel                  int  `json:"mvp_count_level"`
	MvpCount                       int  `json:"mvp_count"`
	MvpRank                        int  `json:"mvp_rank"`
	MvpRankYesterday               int  `json:"mvp_rank_yesterday"`
	LadderExpLevel                 int  `json:"ladder_exp_level"`
	LadderExp                      int  `json:"ladder_exp"`
	LadderRank                     int  `json:"ladder_rank"`
	LadderRankYesterday            int  `json:"ladder_rank_yesterday"`
	KoCountLevel                   int  `json:"ko_count_level"`
	KoCount                        int  `json:"ko_count"`
	KoRank                         int  `json:"ko_rank"`
	KoRankYesterday                int  `json:"ko_rank_yesterday"`
	TeamattackCountLevel           int  `json:"teamattack_count_level"`
	TeamattackCount                int  `json:"teamattack_count"`
	TeamattackRank                 int  `json:"teamattack_rank"`
	TeamattackRankYesterday        int  `json:"teamattack_rank_yesterday"`
	DoubleattackCountLevel         int  `json:"doubleattack_count_level"`
	DoubleattackCount              int  `json:"doubleattack_count"`
	DoubleattackRank               int  `json:"doubleattack_rank"`
	DoubleattackRankYesterday      int  `json:"doubleattack_rank_yesterday"`
	WinningrateLevel               int  `json:"winningrate_level"`
	Winningrate                    int  `json:"winningrate"`
	WinningrateRank                int  `json:"winningrate_rank"`
	WinningrateRankYesterday       int  `json:"winningrate_rank_yesterday"`
	PerfectGameCount               int  `json:"perfect_game_count"`
	PerfectGameRank                int  `json:"perfect_game_rank"`
	PerfectGameRankYesterday       int  `json:"perfect_game_rank_yesterday"`
	StraightDestroiesCount         int  `json:"straight_destroies_count"`
	StraightDestroiesRank          int  `json:"straight_destroies_rank"`
	StraightDestroiesRankYesterday int  `json:"straight_destroies_rank_yesterday"`
	StraightVictoriesCount         int  `json:"straight_victories_count"`
	StraightVictoriesRank          int  `json:"straight_victories_rank"`
	StraightVictoriesRankYesterday int  `json:"straight_victories_rank_yesterday"`
	TotalZpLevel                   int  `json:"total_zp_level"`
	TotalZp                        int  `json:"total_zp"`
	TotalZpRank                    int  `json:"total_zp_rank"`
	TotalZpRankYesterday           int  `json:"total_zp_rank_yesterday"`
}

// Position ตัวละคร
type CharacterMove struct {
	Username      string    `json:"username"`       // ชื่อบัญชีผู้เล่น (เช่น "natt123") ใช้แยกผู้เล่นในระบบ
	CharacterName string    `json:"character_name"` // ชื่อตัวละครในเกม (เช่น "DarkLord01") ใช้ในการติดตามตำแหน่ง
	MapNumber     int       `json:"map_number"`     // รหัสแผนที่ที่ตัวละครอยู่ เช่น 0 = Lorencia, 1 = Dungeon ฯลฯ
	PosX          int       `json:"pos_x"`          // พิกัดแนวนอน (X) บนแผนที่
	PosY          int       `json:"pos_y"`          // พิกัดแนวตั้ง (Y) บนแผนที่
	Timestamp     time.Time `json:"timestamp"`      // เวลาที่มีการเคลื่อนไหวนี้เกิดขึ้น ใช้เพื่อเรียงลำดับหรือวิเคราะห์
}
