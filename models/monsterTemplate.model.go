package models

import (
	"encoding/xml"
	"fmt"
	"os"
)

// MonsterTemplate ครอบคลุมทุกข้อมูลที่โหลดจาก IGC_MonsterList.xml
type MonsterTemplate struct {
	Index                  int    `xml:"Index,attr"`                  // รหัสมอนสเตอร์
	IsTrap                 int    `xml:"IsTrap,attr"`                 // เป็นกับดักหรือไม่ (1 = ใช่)
	Name                   string `xml:"Name,attr"`                   // ชื่อมอนสเตอร์
	Level                  int    `xml:"Level,attr"`                  // เลเวล
	HP                     int    `xml:"HP,attr"`                     // พลังชีวิตสูงสุด
	MP                     int    `xml:"MP,attr"`                     // มานาสูงสุด
	DamageMin              int    `xml:"DamageMin,attr"`              // ดาเมจต่ำสุด
	DamageMax              int    `xml:"DamageMax,attr"`              // ดาเมจสูงสุด
	ExtraDamageMin         int    `xml:"ExtraDamageMin,attr"`         // ดาเมจเสริมต่ำสุด
	ExtraDamageMax         int    `xml:"ExtraDamageMax,attr"`         // ดาเมจเสริมสูงสุด
	Defense                int    `xml:"Defense,attr"`                // ป้องกันกายภาพ
	MagicDefense           int    `xml:"MagicDefense,attr"`           // ป้องกันเวทย์
	ExtraDefense           int    `xml:"ExtraDefense,attr"`           // ป้องกันเสริม
	AttackRate             int    `xml:"AttackRate,attr"`             // ค่าความแม่นยำ
	BlockRate              int    `xml:"BlockRate,attr"`              // อัตราบล็อก
	MoveRange              int    `xml:"MoveRange,attr"`              // ระยะการเดินจากจุดเกิด
	AttackType             int    `xml:"AttackType,attr"`             // ประเภทการโจมตี (0=กายภาพ, 1=เวทย์ ฯลฯ)
	AttackRange            int    `xml:"AttackRange,attr"`            // ระยะโจมตี
	ViewRange              int    `xml:"ViewRange,attr"`              // ระยะเห็นเป้าหมาย
	MoveSpeed              int    `xml:"MoveSpeed,attr"`              // ความเร็วในการเดิน (ms)
	AttackSpeed            int    `xml:"AttackSpeed,attr"`            // ความเร็วในการโจมตี (ms)
	RegenTime              int    `xml:"RegenTime,attr"`              // เวลาฟื้นคืนชีพ (วินาที)
	Attribute              int    `xml:"Attribute,attr"`              // ธาตุ (0-4)
	IceRes                 int    `xml:"IceRes,attr"`                 // ต้านน้ำแข็ง
	PoisonRes              int    `xml:"PoisonRes,attr"`              // ต้านพิษ
	LightRes               int    `xml:"LightRes,attr"`               // ต้านแสง
	FireRes                int    `xml:"FireRes,attr"`                // ต้านไฟ
	PentagramMainAttrib    int    `xml:"PentagramMainAttrib,attr"`    // ธาตุหลักของ Pentagram
	PentagramAttribPattern int    `xml:"PentagramAttribPattern,attr"` // รูปแบบธาตุ Pentagram
	PentagramDamageMin     int    `xml:"PentagramDamageMin,attr"`     // ดาเมจธาตุต่ำสุด
	PentagramDamageMax     int    `xml:"PentagramDamageMax,attr"`     // ดาเมจธาตุสูงสุด
	PentagramAttackRate    int    `xml:"PentagramAttackRate,attr"`    // ความแม่นยำธาตุ
	PentagramDefenseRate   int    `xml:"PentagramDefenseRate,attr"`   // ความสามารถหลบธาตุ
	PentagramDefense       int    `xml:"PentagramDefense,attr"`       // ค่าป้องกันธาตุ
	EliteMonster           int    `xml:"EliteMonster,attr"`           // เป็น Elite หรือไม่
	PunishImmune           int    `xml:"PunishImmune,attr"`           // ต้านทานการลงโทษ
	DamageAbsorption       int    `xml:"DamageAbsorption,attr"`       // ดูดซับดาเมจ (%)
	CriticalDamageRes      int    `xml:"CriticalDamageRes,attr"`      // ต้านดาเมจคริติคอล
	ExcellentDamageRes     int    `xml:"ExcellentDamageRes,attr"`     // ต้านดาเมจ Excellent
	DebuffApplyRes         int    `xml:"DebuffApplyRes,attr"`         // ต้านดีบัฟ
	DamageCorrection       int    `xml:"DamageCorrection,attr"`       // ค่าปรับแต่งดาเมจ
	ExpLevel               int    `xml:"ExpLevel,attr"`               // ระดับการดรอป EXP
}

type monsterListXML struct {
	Monsters []MonsterTemplate `xml:"Monster"`
}

func LoadMonsterTemplates(path string) map[int]*MonsterTemplate {
	file, err := os.Open(path)
	if err != nil {
		fmt.Println("❌ Failed to open MonsterList XML:", err)
		return nil
	}
	defer file.Close()

	var parsed monsterListXML
	if err := xml.NewDecoder(file).Decode(&parsed); err != nil {
		fmt.Println("❌ Failed to parse MonsterList XML:", err)
		return nil
	}

	templates := make(map[int]*MonsterTemplate)
	for i := range parsed.Monsters {
		t := &parsed.Monsters[i]
		templates[t.Index] = t
	}
	fmt.Println("✅ Loaded", len(templates), "monster templates from", path)
	return templates
}
