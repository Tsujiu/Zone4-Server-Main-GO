package models

type Skill struct {
	ID        int
	Name      string
	ManaCost  int
	Cooldown  int64 // milliseconds
	LastUsed  int64 // timestamp
	Damage    int
	CastRange int
}

type Player struct {
	ID       int
	Name     string
	Mana     int
	Position Position
	Skills   map[int]*Skill
}

type Position struct {
	X int
	Y int
}
