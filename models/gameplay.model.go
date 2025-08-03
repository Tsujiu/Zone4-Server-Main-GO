package models

type Room struct {
	Key       string   `json:"key"`
	Password  string   `json:"password"`
	Character []string `json:"character"`
	Mode      string   `json:"mode"`
	TeamA     []string `json:"team_a"`
	TeamB     []string `json:"team_b"`
	Host      string   `json:"host"`
	Rank      int      `json:"rank"`
	MaxPlayer int      `json:"max_player"`
	Team      bool     `json:"team"`
	UseItem   bool     `json:"use_item"`
	Status    string   `json:"status"`
}
