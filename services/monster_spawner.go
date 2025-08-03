package services

import (
	"fmt"
	"math/rand"
	"maxion-zone4/models"
)

// SpawnMonstersFromSpawnData สร้าง Monster จากข้อมูล spawn maps และใส่ลงใน zone
func SpawnMonstersFromSpawnData(spawnMaps []models.MonsterSpawnMapXML) {

	for _, zone := range spawnMaps {
		tileMap := TileMapData[zone.Number]
		if tileMap == nil {
			fmt.Println("❌ No TileMap for zone", zone.Number)
			continue
		}

		for _, spot := range zone.Spots {
			for _, entry := range spot.Spawns {
				template := MonsterTemplates[entry.Index]
				for i := 0; i < entry.Count; i++ {
					pos := getRandomWalkableInArea(tileMap, entry.StartX, entry.StartY, entry.EndX, entry.EndY)
					// target := getRandomWalkableInArea(tileMap, entry.StartX, entry.StartY, entry.EndX, entry.EndY)

					m := models.NewMonster(entry.Index, pos, models.Vec2{})
					AddMonster(zone.Number, m)
					BroadcastMonsterToZone(zone.Number, m, template)
				}
			}
		}
		fmt.Println("✅ Spawned monsters for zone", zone.Number)
	}
}

func getRandomWalkableInArea(tileMap [][]models.Tile, sx, sy, ex, ey int) models.Vec2 {
	// ✨ ปรับให้ start < end เสมอ
	if sx > ex {
		sx, ex = ex, sx
	}
	if sy > ey {
		sy, ey = ey, sy
	}

	width := ex - sx + 1
	height := ey - sy + 1

	if width <= 0 || height <= 0 {
		fmt.Printf("❌ Invalid spawn area: (%d,%d)-(%d,%d)\n", sx, sy, ex, ey)
		return models.Vec2{X: sx, Y: sy}
	}

	for i := 0; i < 100; i++ {
		x := rand.Intn(width) + sx
		y := rand.Intn(height) + sy
		if y >= 0 && y < 256 && x >= 0 && x < 256 && tileMap[y][x].Walkable {
			return models.Vec2{X: x, Y: y}
		}
	}

	return models.Vec2{X: sx, Y: sy}
}
