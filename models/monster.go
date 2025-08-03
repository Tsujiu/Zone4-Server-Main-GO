package models

import (
	"container/heap"
	"context"
	"fmt"
	"log"
	"math"
	"math/rand"
	"os"
	"strconv"
	"strings"
	"time"

	"github.com/go-redis/redis/v8"
)

type Vec2 struct {
	X int
	Y int
}

type Monster struct {
	ID             int               // ID ของมอนสเตอร์ (ไม่ซ้ำ)
	Index          int               // อ้างอิง MonsterTemplate
	Pos            Vec2              // ตำแหน่งปัจจุบัน
	Target         Vec2              // ตำแหน่งเป้าหมาย
	Path           []Vec2            // เส้นทางที่ต้องเดิน
	SpawnPos       Vec2              // ตำแหน่งเกิด
	Alive          bool              // ยังมีชีวิตอยู่หรือไม่
	WalkRemain     int               // จำนวนก้าวที่เหลือ (ถ้าใช้)
	SpawnArea      MonsterSpawnEntry // พื้นที่ spawn
	LastMoveTime   time.Time         // เวลาเดินล่าสุด
	MoveDelay      time.Duration     // ดีเลย์ระหว่างการเดิน
	LastAttackTime time.Time         // เวลาโจมตีล่าสุด
	DeathTime      time.Time         // เวลาที่ตาย
}

type MonsterCreatePacket struct {
	MonsterId          int    `json:"monsterId"` // รหัสมอนสเตอร์ runtime
	Type               int    `json:"type"`      // Monster Index จาก Template
	X                  byte   `json:"x"`
	Y                  byte   `json:"y"`
	TargetX            byte   `json:"targetX"`
	TargetY            byte   `json:"targetY"`
	Direction          byte   `json:"direction"` // 0-7
	Level              int    `json:"level"`
	MaxLife            int    `json:"maxLife"`
	CurrentLife        int    `json:"currentLife"`
	PentagramAttribute byte   `json:"pentagramMainAttribute"` // ธาตุ (0-4)
	Name               string `json:"name"`
	Alive              bool   `json:"alive"`
}

func (m *Monster) MoveStep(template *MonsterTemplate) {
	maxSteps := template.MoveRange

	stepsTaken := 0
	for len(m.Path) > 0 && stepsTaken < maxSteps {
		next := m.Path[0]
		m.Pos = next
		m.Path = m.Path[1:]
		stepsTaken++

		// log.Printf("👣 Monster %d moved to (%d,%d)", m.ID, m.Pos.X, m.Pos.Y)
	}

	// ✅ ล้าง path หากเดินหมด
	if len(m.Path) == 0 {
		m.Path = nil
		m.Target = Vec2{}
	}
}

// -------- Tile Map --------
type TileType byte

const (
	NotWalk        TileType = 4
	Walk           TileType = 0
	Safe           TileType = 1
	Wall           TileType = 5
	Hole           TileType = 12
	Hole2          TileType = 8
	Hole3          TileType = 13
	Unknown        TileType = 2
	BCBridgeStart  TileType = 36
	BCBridgeMiddle TileType = 32
	BCBridgeFinish TileType = 40
	Lean           TileType = 41
	Sit            TileType = 42
)

type Tile struct {
	X, Y     int
	Type     TileType
	Walkable bool
}

func (t Tile) Pos() Vec2 {
	return Vec2{t.X, t.Y}
}

func ByteToTileType(b byte) Tile {
	tileType := TileType(b)
	// walkable := tileType == Walk || tileType == Safe
	walkable := tileType == Walk

	return Tile{
		Type:     tileType,
		Walkable: walkable,
	}
}

func LoadEncTerrainToTileMap(filePath string) ([][]Tile, error) {
	data, err := os.ReadFile(filePath)
	if err != nil {
		return nil, err
	}

	if len(data) < 256*256 {
		return nil, fmt.Errorf("file too small, expected at least 65536 bytes")
	}

	tileMap := make([][]Tile, 256)
	for y := 0; y < 256; y++ {
		tileMap[y] = make([]Tile, 256)
		for x := 0; x < 256; x++ {
			idx := y*256 + x
			tile := ByteToTileType(data[idx])
			tile.X = x
			tile.Y = y
			tileMap[y][x] = tile
		}
	}
	return tileMap, nil
}

func SaveTileToRedis(rdb *redis.Client, ctx context.Context, zone int, tile Tile) error {
	key := fmt.Sprintf("map:%d:tile:%d_%d", zone, tile.X, tile.Y)
	fmt.Sprintln(key)
	walk := "0"
	if tile.Walkable {
		walk = "1"
	}
	return rdb.HSet(ctx, key, map[string]interface{}{
		"walkable": walk,
		"type":     int(tile.Type),
	}).Err()
}

func SaveTileMapToRedis(rdb *redis.Client, ctx context.Context, zone int, tileMap [][]Tile) error {
	start := time.Now()
	pipe := rdb.Pipeline()

	for y := 0; y < len(tileMap); y++ {
		for x := 0; x < len(tileMap[y]); x++ {
			tile := tileMap[y][x]
			key := fmt.Sprintf("map:%d:tile:%d_%d", zone, tile.X, tile.Y)
			walk := "0"
			if tile.Walkable {
				walk = "1"
			}
			pipe.HSet(ctx, key, map[string]interface{}{
				"walkable": walk,
				"type":     int(tile.Type),
			})
		}
	}

	_, err := pipe.Exec(ctx)
	log.Printf("📦 Saved zone %d to Redis in %s", zone, time.Since(start))
	return err
}

// -------- Pathfinding --------
type Node struct {
	Pos     Vec2
	G, H, F int
	Parent  *Node
	Index   int // for heap
}

type PriorityQueue []*Node

func (pq PriorityQueue) Len() int           { return len(pq) }
func (pq PriorityQueue) Less(i, j int) bool { return pq[i].F < pq[j].F }
func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].Index = i
	pq[j].Index = j
}
func (pq *PriorityQueue) Push(x interface{}) {
	n := x.(*Node)
	n.Index = len(*pq)
	*pq = append(*pq, n)
}
func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	*pq = old[0 : n-1]
	return item
}

func heuristic(a, b Vec2) int {
	dx := math.Abs(float64(a.X - b.X))
	dy := math.Abs(float64(a.Y - b.Y))
	return int(dx + dy) // Manhattan
}

func FindPath(start, goal Vec2, tileMap [][]Tile) []Vec2 {
	open := make(map[Vec2]*Node)
	closed := make(map[Vec2]bool)
	pq := &PriorityQueue{}
	heap.Init(pq)

	startNode := &Node{Pos: start, G: 0, H: heuristic(start, goal)}
	startNode.F = startNode.G + startNode.H
	heap.Push(pq, startNode)
	open[start] = startNode

	dirs := []Vec2{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}

	for pq.Len() > 0 {
		current := heap.Pop(pq).(*Node)
		delete(open, current.Pos)
		closed[current.Pos] = true

		if current.Pos == goal {
			path := []Vec2{}
			for n := current; n != nil; n = n.Parent {
				path = append([]Vec2{n.Pos}, path...)
			}
			return path
		}

		for _, d := range dirs {
			nx, ny := current.Pos.X+d.X, current.Pos.Y+d.Y
			if ny < 0 || ny >= len(tileMap) || nx < 0 || nx >= len(tileMap[0]) {
				continue
			}
			tile := tileMap[ny][nx]
			if !tile.Walkable || closed[tile.Pos()] {
				continue
			}

			neighbor := &Node{Pos: Vec2{nx, ny}, G: current.G + 1}
			neighbor.H = heuristic(neighbor.Pos, goal)
			neighbor.F = neighbor.G + neighbor.H
			neighbor.Parent = current

			if existing, ok := open[neighbor.Pos]; ok && existing.G <= neighbor.G {
				continue
			}

			open[neighbor.Pos] = neighbor
			heap.Push(pq, neighbor)
		}
	}

	return nil // no path
}

func LoadTileMap(rdb *redis.Client) error {
	dirPath := "data/maps"

	files, err := os.ReadDir(dirPath)
	if err != nil {
		return err
	}

	ctx := context.Background()
	for _, file := range files {
		if file.IsDir() || !strings.HasSuffix(file.Name(), ".att") {
			continue
		}

		zoneID, err := extractZoneIDFromFilename(file.Name())
		if err != nil {
			log.Println("❗ Skip file (invalid name):", file.Name())
			continue
		}

		fullPath := fmt.Sprintf("%s/%s", dirPath, file.Name())
		tileMap, err := LoadEncTerrainToTileMap(fullPath)
		if err != nil {
			log.Println("❌ Failed to load map:", fullPath, "->", err)
			continue
		}

		err = SaveTileMapToRedis(rdb, ctx, zoneID, tileMap)
		if err != nil {
			log.Println("❌ Failed to save map:", file.Name(), "to Redis:", err)
		} else {
			log.Println("✅ Loaded map zone", zoneID, "from", file.Name())
		}
	}
	return nil
}

func extractZoneIDFromFilename(filename string) (int, error) {
	parts := strings.SplitN(filename, "_", 2)
	if len(parts) == 0 {
		return -1, fmt.Errorf("invalid filename format")
	}
	return strconv.Atoi(parts[0])
}

func LoadTileMapFromRedis(rdb *redis.Client, ctx context.Context, zone int) ([][]Tile, error) {
	tileMap := make([][]Tile, 256)
	for y := 0; y < 256; y++ {
		tileMap[y] = make([]Tile, 256)
	}

	// 1. เตรียม pipeline
	pipe := rdb.Pipeline()
	cmds := make([]*redis.StringStringMapCmd, 0, 256*256)

	// 2. สร้างคำสั่งทั้งหมดใส่ pipeline
	for y := 0; y < 256; y++ {
		for x := 0; x < 256; x++ {
			key := fmt.Sprintf("map:%d:tile:%d_%d", zone, x, y)
			cmd := pipe.HGetAll(ctx, key)
			cmds = append(cmds, cmd)
		}
	}

	// 3. รันทั้งหมดในชุดเดียว
	_, err := pipe.Exec(ctx)
	if err != nil {
		return nil, fmt.Errorf("redis pipeline exec failed: %w", err)
	}

	// 4. สร้าง tileMap จากผลลัพธ์
	for i := 0; i < len(cmds); i++ {
		x := i % 256
		y := i / 256

		values := cmds[i].Val()

		tileType := Unknown
		if t, ok := values["type"]; ok {
			if typeInt, err := strconv.Atoi(t); err == nil {
				tileType = TileType(typeInt)
			}
		}

		walkable := false
		if w, ok := values["walkable"]; ok && w == "1" {
			walkable = true
		}

		tileMap[y][x] = Tile{
			X:        x,
			Y:        y,
			Type:     tileType,
			Walkable: walkable,
		}
	}

	return tileMap, nil
}

var nextMonsterID int = 10000

// generateUniqueMonsterID ใช้สร้าง ID ใหม่ให้มอนสเตอร์ทุกตัวแบบไม่ซ้ำ
func generateUniqueMonsterID() int {
	nextMonsterID++
	return nextMonsterID
}

func NewMonster(index int, pos Vec2, target Vec2) *Monster {
	return &Monster{
		ID:           generateUniqueMonsterID(),
		Index:        index,
		Pos:          pos,
		Target:       target,
		SpawnPos:     pos, // ✅ สำคัญมาก
		Alive:        true,
		Path:         []Vec2{},
		MoveDelay:    time.Duration(rand.Intn(400)+400) * time.Millisecond, // ✅ 400–800ms
		LastMoveTime: time.Now(),                                           // ✅ ให้เดินรอบแรกได้ทันที
	}
}
