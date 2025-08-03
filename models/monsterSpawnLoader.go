package models

import (
	"encoding/xml"
	"fmt"
	"os"
)

type MonsterSpawnEntry struct {
	Index    int `xml:"Index,attr"`
	Count    int `xml:"Count,attr"`
	StartX   int `xml:"StartX,attr"`
	StartY   int `xml:"StartY,attr"`
	EndX     int `xml:"EndX,attr"`
	EndY     int `xml:"EndY,attr"`
	Distance int `xml:"Distance,attr"`
	Dir      int `xml:"Dir,attr"`
}

type MonsterSpawnSpot struct {
	Type        int                 `xml:"Type,attr"`
	Description string              `xml:"Description,attr"`
	Spawns      []MonsterSpawnEntry `xml:"Spawn"`
}

type MonsterSpawnMapXML struct {
	Number int                `xml:"Number,attr"`
	Spots  []MonsterSpawnSpot `xml:"Spot"`
}

type MonsterSpawnConfig struct {
	XMLName xml.Name             `xml:"MonsterSpawn"`
	Maps    []MonsterSpawnMapXML `xml:"Map"`
}

func LoadMonsterSpawnFromXML(path string) ([]MonsterSpawnMapXML, error) {
	file, err := os.Open(path)
	if err != nil {
		fmt.Printf("❌ Failed to open spawn XML file: %s → %v\n", path, err)
		return nil, err
	}
	defer file.Close()

	var config MonsterSpawnConfig
	err = xml.NewDecoder(file).Decode(&config)
	if err != nil {
		fmt.Printf("❌ Failed to decode XML (%s): %v\n", path, err)
		return nil, err
	}

	fmt.Printf("✅ Loaded %d monster spawn zones from %s\n", len(config.Maps), path)
	return config.Maps, nil
}
