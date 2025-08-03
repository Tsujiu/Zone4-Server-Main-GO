package packet

type PacketType uint8

const (
	PacketTypeUnknown       PacketType = 0
	PacketTypeMonsterMove   PacketType = 1
	PacketTypeMonsterSpawn  PacketType = 2
	PacketTypeMonsterDie    PacketType = 3
	PacketTypeMonsterAttack PacketType = 4
	PacketTypePlayerMove    PacketType = 5
	PacketTypePlayerEnter   PacketType = 6
	PacketTypeTileMapSync   PacketType = 7
	PacketTypeSystemMessage PacketType = 8
	PacketTypeError         PacketType = 9
	PacketTypePing          PacketType = 10
)
