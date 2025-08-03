package inventory_controller

import (
	// "database/sql"
	"encoding/binary"
	"encoding/hex"
	"encoding/xml"
	"errors"
	"fmt"
	"io"
	"log"
	"os"
	"path/filepath"
	"strings"
	"time"
	// _ "github.com/denisenkom/go-mssqldb"
)

const (
	SlotSize   = 32                                                                 // ขนาดของข้อมูลไอเทมในแต่ละช่อง (32 bytes)
	EmptySlot  = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" // ค่าเริ่มต้นของช่องว่าง
	BaseWidth  = 5                                                                  // จำนวนช่องต่อแถว
	BaseHeight = 7                                                                  // จำนวนแถวเริ่มต้น
)

// โครงสร้างข้อมูลไอเทม

type ItemInventory struct {
	SectionIndex int    // หมวดหมู่ของไอเทม
	ItemIndex    int    // หมายเลขไอเทมในหมวดหมู่
	ItemType     int    // ประเภทของไอเทม
	Durability   int    // ค่าความคงทนของไอเทม
	SerialNumber string // หมายเลขไอเทม
	NewOption    int    // ออปชั่นพิเศษของไอเทม
	SkillIndex   int    // สกิลที่มากับไอเทม
	Width        int    // ความกว้างของไอเทมในกระเป๋า
	Height       int    // ความสูงของไอเทมในกระเป๋า
	SlotIndex    int    // ตำแหน่งช่องในกระเป๋าที่เก็บไอเทม
}

// MUItem แทนข้อมูลไอเทม 32 ไบต์ในรูปแบบ MU Online SS9
type MUItem struct {
	// 0x00 – 0x01: ItemID (คำนวณจาก SectionIndex*512 + ItemIndex, เก็บแบบ little-endian)
	ItemID uint16

	// 0x02: Level ของไอเทม (default 0)
	Level uint8

	// 0x03: Skill flag (1 หากมีสกิล, 0 หากไม่มี)
	Skill uint8

	// 0x04: Luck flag (default 0)
	Luck uint8

	// 0x05: Option (เช่น NewOption จาก XML)
	Option uint8

	// 0x06: Excellent flag (default 0)
	Excellent uint8

	// 0x07: Ancient flag (default 0)
	Ancient uint8

	// 0x08: Durability ของไอเทม (จาก XML)
	Durability uint8

	// 0x09: Harmony Option (default 0)
	HarmonyOption uint8

	// 0x0A – 0x0C: Harmony Card Codes (default [3]byte{0,0,0})
	HarmonyCards [3]byte

	// 0x0D – 0x11: Socket Options (default [5]byte{0,0,0,0,0})
	SocketOptions [5]byte

	// 0x12 – 0x15: Serial Number (4 ไบต์, เก็บแบบ little-endian)
	SerialNumber [4]byte

	// 0x16 – 0x1F: Reserved (default [10]byte{0,...,0})
	Reserved [10]byte
}

// โครงสร้าง XML สำหรับโหลดข้อมูลไอเทม

type XMLItem struct {
	Index      int    `xml:"Index,attr"`
	Width      int    `xml:"Width,attr"`
	Height     int    `xml:"Height,attr"`
	Durability int    `xml:"Durability,attr"`
	Name       string `xml:"Name,attr"`
}

type XMLSection struct {
	Index int       `xml:"Index,attr"`
	Items []XMLItem `xml:"Item"`
}

type ItemList struct {
	Sections []XMLSection `xml:"Section"`
}

var itemList map[string]ItemInventory

// โหลดข้อมูลไอเทมจากไฟล์ XML
func loadItemList() error {

	// หา Working Directory ของโปรแกรม
	basePath, err := os.Getwd()
	if err != nil {
		log.Fatal("Error getting working directory:", err)
	}

	// กำหนด Path ของไฟล์ XML
	xmlFilePath := filepath.Join(basePath, "data", "IGC_ItemList.xml")

	file, err := os.Open(xmlFilePath)
	if err != nil {
		return err
	}
	defer file.Close()

	byteValue, err := io.ReadAll(file)
	if err != nil {
		return err
	}

	var xmlData ItemList
	err = xml.Unmarshal(byteValue, &xmlData)
	if err != nil {
		return err
	}

	itemList = make(map[string]ItemInventory)
	for _, section := range xmlData.Sections {
		for _, item := range section.Items {
			key := fmt.Sprintf("%d-%d", section.Index, item.Index)
			itemList[key] = ItemInventory{
				SectionIndex: section.Index,
				ItemIndex:    item.Index,
				Width:        item.Width,
				Height:       item.Height,
				Durability:   item.Durability,
			}
		}
	}
	return nil
}

// ฟังก์ชันสำหรับสร้างระบบกระเป๋า Inventory
type Inventory struct {
	Slots []string        // รายการช่องเก็บของทั้งหมด
	Rows  int             // จำนวนแถวในกระเป๋า
	Width int             // จำนวนช่องต่อแถว
	Items []ItemInventory // รายการไอเทมที่ถูกเก็บ สามารถมีหลายชิ้นในแต่ละช่อง
}

func NewInventory() *Inventory {
	inv := &Inventory{
		Slots: make([]string, BaseWidth*BaseHeight),
		Rows:  BaseHeight,
		Width: BaseWidth,
	}
	for i := range inv.Slots {
		inv.Slots[i] = EmptySlot
	}
	return inv
}

// เพิ่มไอเทมลงในช่องเก็บของ
func (inv *Inventory) AddItem(hexItem string, slotIndex int) error {
	// เช็ค slotIndex
	if slotIndex < 0 || slotIndex >= len(inv.Slots) {
		return errors.New("invalid slot index")
	}

	// เช็ค 32 Bytes = 64 hex
	if len(hexItem) != SlotSize*2 {
		return errors.New("invalid item size, must be 32 bytes hex")
	}

	if inv.Slots[slotIndex] == EmptySlot {
		inv.Slots[slotIndex] = hexItem
	} else {
		return errors.New("Slot Not Empty")
	}

	return nil
}

// แปลงข้อมูลกระเป๋าเป็น varbinary เพื่อบันทึกลงฐานข้อมูล
func (inv *Inventory) ToVarBinary() ([]byte, error) {
	invHex := ""
	for _, slot := range inv.Slots {
		invHex += slot
	}
	return hex.DecodeString(invHex)
}

// ฟังก์ชันสำหรับบันทึก Inventory ลงฐานข้อมูล MSSQL
// func (inv *Inventory) SaveToDatabase(db *sql.DB, userID int) error {
// 	binaryData, err := inv.ToVarBinary()
// 	if err != nil {
// 		return err
// 	}

// 	query := "UPDATE UserInventory SET InventoryData = ? WHERE UserID = ?"
// 	_, err = db.Exec(query, binaryData, userID)
// 	return err
// }

// ขยายกระเป๋าโดยเพิ่มจำนวนแถว
func (inv *Inventory) ExpandRows(newRows int) {
	inv.Rows += newRows
	newSlots := make([]string, inv.Width*newRows)
	for i := range newSlots {
		newSlots[i] = EmptySlot
	}
	inv.Slots = append(inv.Slots, newSlots...)
}

// ฟังก์ชันสร้าง SerialNumber แบบ 4 Bytes HEX
func GenerateSerialTimestampHex() string {
	time.Sleep(1 * time.Millisecond)
	timestamp := uint32(time.Now().UnixNano() / int64(time.Millisecond))
	serialBytes := make([]byte, 4)
	binary.LittleEndian.PutUint32(serialBytes, timestamp)
	return strings.ToUpper(hex.EncodeToString(serialBytes))
}

// ฟังก์ชันแปลงไอเทมเป็น HEX 32 Bytes ตามโครงสร้าง MU Online SS9
// func GenerateInventoryHex(item ItemInventory) string {
// 	data := make([]byte, SlotSize)

// 	// 0-2 : Section & ItemIndex
// 	itemCode := uint16(item.SectionIndex*512 + item.ItemIndex)
// 	binary.LittleEndian.PutUint16(data[0:2], itemCode)

// 	// 3 : Skill, Luck, Level
// 	data[3] = byte(item.NewOption<<3) | boolToByte(item.SkillIndex > 0)<<1 | boolToByte(item.NewOption > 0)

// 	// 4 : Option & Durability
// 	data[4] = byte(item.NewOption<<4 | item.Durability)

// 	// 8-11 : Serial Number (HEX)
// 	serialBytes, _ := hex.DecodeString(item.SerialNumber)
// 	copy(data[8:12], serialBytes)

// 	// แปลงเป็น HEX String และทำให้เป็นตัวพิมพ์ใหญ่ทั้งหมด
// 	return strings.ToUpper(hex.EncodeToString(data))
// }

// GenerateInventoryHex แปลงข้อมูลไอเทมให้เป็น HEX 32 Bytes ตามโครงสร้าง MU Online SS9
func GenerateInventoryHex(item ItemInventory) string {
	// สร้าง slice ขนาด 32 ไบต์ (ค่า default เป็น 0)
	data := make([]byte, SlotSize)

	// 0x00-0x01 : ItemID (คำนวณจาก SectionIndex*512 + ItemIndex) แบบ little-endian
	itemCode := uint16(item.SectionIndex*512 + item.ItemIndex)
	binary.LittleEndian.PutUint16(data[0:2], itemCode)

	// 0x02 : Level (default 0)
	data[2] = 0

	// 0x03 : Skill flag (1 หาก SkillIndex > 0, 0 หากไม่)
	if item.SkillIndex > 0 {
		data[3] = 1
	} else {
		data[3] = 0
	}

	// 0x04 : Luck (default 0)
	data[4] = 0

	// 0x05 : Option (ใช้ค่า NewOption จาก XML)
	data[5] = byte(item.NewOption)

	// 0x06 : Excellent (default 0)
	data[6] = 0

	// 0x07 : Ancient (default 0)
	data[7] = 0

	// 0x08 : Durability (จาก XML)
	data[8] = byte(item.Durability)

	// 0x09 : Harmony Option (default 0)
	data[9] = 0

	// 0x0A-0x0C : Harmony Card Codes (default 0)
	// 0x0D-0x11 : Socket Options (default 0)
	// (ข้อมูลส่วนนี้ยังไม่ได้ถูกใช้งาน จึงเป็น 0)

	// 0x12-0x15 : Serial Number (4 ไบต์, little-endian)
	// คาดว่า item.SerialNumber เป็น HEX string ที่มีความยาว 8 ตัวอักษร (4 ไบต์)
	serialBytes, err := hex.DecodeString(item.SerialNumber)
	if err != nil || len(serialBytes) != 4 {
		// กรณีแปลงล้มเหลว ให้ตั้งเป็น 0 ทั้ง 4 ไบต์
		serialBytes = []byte{0, 0, 0, 0}
	}
	copy(data[0x12:0x16], serialBytes)

	// 0x16-0x1F : Reserved (default 0)
	// ไม่มีการดำเนินการเพิ่มเติมเพราะ slice ถูกสร้างมาเต็มไปด้วย 0 อยู่แล้ว

	// แปลง slice เป็น HEX string และทำให้เป็นตัวพิมพ์ใหญ่
	return strings.ToUpper(hex.EncodeToString(data))
}

// แปลง boolean เป็น byte
// func boolToByte(b bool) byte {
// 	if b {
// 		return 1
// 	}
// 	return 0
// }

// ฟังก์ชันตรวจสอบว่าไอเทมอยู่ใน XML หรือไม่
func isValidItem(sectionIndex, itemIndex int) bool {
	key := fmt.Sprintf("%d-%d", sectionIndex, itemIndex)
	_, exists := itemList[key]
	return exists
}

// ParseInventoryHexToItemInventory แปลง Hex String (ความยาว 64 ตัว สำหรับ 32 bytes)
// ให้กลับมาเป็น object ของ ItemInventory
func ParseInventoryHexToItemInventory(hexStr string) (ItemInventory, error) {
	// ตรวจสอบความยาวของ hex string ต้องเป็น 64 ตัว (32 bytes)
	if len(hexStr) != 64 {
		return ItemInventory{}, errors.New("invalid hex string length, must be 64 characters for 32 bytes")
	}

	data, err := hex.DecodeString(hexStr)
	if err != nil {
		return ItemInventory{}, err
	}

	// Bytes 0-1: ItemCode (little-endian)
	itemCode := binary.LittleEndian.Uint16(data[0:2])
	sectionIndex := int(itemCode) / 512
	itemIndex := int(itemCode) % 512

	// Byte 3: เข้ารหัส NewOption และ flag ของ Skill
	// สูตร: data[3] = (NewOption << 3) | (bool(SkillIndex>0)<<1) | (bool(NewOption>0))
	newOptionFromByte3 := int(data[3]) >> 3
	var skillIndex int
	if ((data[3] >> 1) & 0x01) == 1 {
		// ในที่นี้เรารับรู้แค่ว่า SkillIndex > 0 จึงกำหนดเป็น 1
		skillIndex = 1
	} else {
		skillIndex = 0
	}

	// Byte 4: High nibble ควรเป็น NewOption (อีกครั้ง) ส่วน low nibble คือ Durability
	// ในการถอดรหัส Durability จะได้ค่า data[4] & 0x0F
	durability := int(data[4] & 0x0F)

	// SerialNumber: Bytes 8-11 (แปลงเป็น Hex String ตัวพิมพ์ใหญ่)
	serialNumber := strings.ToUpper(hex.EncodeToString(data[8:12]))

	// ฟิลด์ ItemType, Width, Height, SlotIndex ไม่ได้ถูกเข้ารหัสลงใน hex string
	// ดังนั้นจึงกำหนดเป็นค่า default (เช่น 0) หากต้องการกำหนดให้ภายหลัง

	return ItemInventory{
		SectionIndex: sectionIndex,
		ItemIndex:    itemIndex,
		ItemType:     0, // ไม่ได้ถูกเข้ารหัส
		Durability:   durability,
		SerialNumber: serialNumber,
		NewOption:    newOptionFromByte3,
		SkillIndex:   skillIndex,
		Width:        0, // ไม่ได้ถูกเข้ารหัส
		Height:       0, // ไม่ได้ถูกเข้ารหัส
		SlotIndex:    0, // ไม่ได้ถูกเข้ารหัส
	}, nil
}

// FillEmptySlotsWithItem วนลูปเติมค่า hexItem ลงในช่องของ Inventory ที่มีค่า EmptySlot
func (inv *Inventory) FillEmptySlotsWithItem(hexItem string) error {
	// ตรวจสอบว่า hexItem มีความยาวถูกต้องหรือไม่ (32 bytes = 64 hex characters)
	if len(hexItem) != SlotSize*2 {
		return errors.New("invalid item hex, must be 32 bytes hex (64 characters)")
	}

	// วนลูปตรวจสอบ slot ทุกช่อง ถ้าเจอช่องที่มีค่า EmptySlot ให้ใส่ hexItem
	for i, slot := range inv.Slots {
		if slot == EmptySlot {
			inv.Slots[i] = hexItem
		}
	}
	return nil
}

// ฟังก์ชันหลักในการเพิ่มไอเทมลงใน Inventory และบันทึกลงฐานข้อมูล
func StartInventory() {
	// โหลดข้อมูลไอเทมจากไฟล์ XML
	if err := loadItemList(); err != nil {
		fmt.Println("Failed to load item list:", err)
		return
	}

	// สร้างและขยายกระเป๋า
	inv := NewInventory()
	// inv.ExpandRows(2) // เพิ่มแถวใหม่

	// กำหนดข้อมูลสำหรับไอเทมทั้ง 6 ชิ้น
	items := []ItemInventory{
		{SectionIndex: 1, ItemIndex: 0, NewOption: 1, Durability: 18, SkillIndex: 0, SerialNumber: GenerateSerialTimestampHex(), SlotIndex: 0},
		{SectionIndex: 5, ItemIndex: 0, NewOption: 1, Durability: 0, SkillIndex: 0, SerialNumber: GenerateSerialTimestampHex(), SlotIndex: 2},
		{SectionIndex: 4, ItemIndex: 0, NewOption: 1, Durability: 20, SkillIndex: 24, SerialNumber: GenerateSerialTimestampHex(), SlotIndex: 4},
		{SectionIndex: 4, ItemIndex: 15, NewOption: 0, Durability: 255, SkillIndex: 0, SerialNumber: GenerateSerialTimestampHex(), SlotIndex: 6},
		{SectionIndex: 0, ItemIndex: 1, NewOption: 1, Durability: 22, SkillIndex: 0, SerialNumber: GenerateSerialTimestampHex(), SlotIndex: 8},
		{SectionIndex: 6, ItemIndex: 0, NewOption: 1, Durability: 30, SkillIndex: 0, SerialNumber: GenerateSerialTimestampHex(), SlotIndex: 10},
	}

	// hexData := []string{}
	// ตรวจสอบไอเทมก่อนเพิ่มเข้า Inventory
	for i, item := range items {
		if !isValidItem(item.SectionIndex, item.ItemIndex) {
			fmt.Println("Invalid item: SectionIndex", item.SectionIndex, "ItemIndex", item.ItemIndex)
			continue
		}

		hexStr := GenerateInventoryHex(items[i])
		fmt.Println("Hex string length ", len(hexStr))
		// ตรวจสอบความยาวของแต่ละ hex string
		if len(hexStr) != 64 {
			fmt.Printf("Item %d: Hex string length is %d, expected 64\n", i, len(hexStr))
		} else {
			fmt.Printf("Item %d: Hex string is valid: %s\n", i, hexStr)
			// hexData = append(hexData, hexStr)

			if err := inv.AddItem(hexStr, item.SlotIndex); err != nil {
				fmt.Println("Failed to add item:", err)
			} else {
				fmt.Println("Item added successfully at slot", item.SlotIndex)
				fmt.Println("Item Object:", item)
				fmt.Println("Hex Data:", hexStr)
			}

		}
	}

	// ใช้ strings.Join เพื่อเชื่อมต่อทุก slot
	concatenated := strings.Join(inv.Slots, "")
	// นำ "0x" มาเป็น prefix
	fullHex := "0x" + concatenated

	fmt.Println("Full Slot:", fullHex)

}
