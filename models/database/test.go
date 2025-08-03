package database

type Test struct {
	Id       uint   `gorm:"column:id;primaryKey"`
	Username string `gorm:"column:username"`
	Password string `gorm:"column:password"`
}

func (Test) TableName() string {
	return "test"
}
