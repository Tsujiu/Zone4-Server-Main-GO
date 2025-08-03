package skill

import (
	"fmt"
	"maxion-zone4/models"
	"maxion-zone4/models/message"
	"maxion-zone4/services"
	"time"
)

type GamePlayer struct {
	*models.Player // Embedded player จาก models
}

func CharacterUseSkill(skillID string) {

	//UseSkill(p, characterName, target *GamePlayer);

	fmt.Printf("%s used skill\n", skillID)

	services.SendUDP(message.USER_MESSAGE_SET_USE_SKILL_RETURN, skillID)
}

func UseSkill(p *GamePlayer, skillID int, target *GamePlayer) error {
	skill, ok := p.Skills[skillID]
	if !ok {
		return fmt.Errorf("Skill ID %d not found", skillID)
	}

	now := time.Now().UnixMilli()

	if now-skill.LastUsed < skill.Cooldown {
		return fmt.Errorf("Skill on cooldown")
	}

	if p.Mana < skill.ManaCost {
		return fmt.Errorf("Not enough mana")
	}

	// ตรวจสอบระยะ
	if !isInRange(p.Position, target.Position, skill.CastRange) {
		return fmt.Errorf("Target out of range")
	}

	// ใช้สกิล
	p.Mana -= skill.ManaCost
	skill.LastUsed = now

	// สร้างความเสียหาย
	target.TakeDamage(skill.Damage)

	fmt.Printf("%s used skill %s on %s\n", p.Name, skill.Name, target.Name)
	return nil
}

func isInRange(pos1, pos2 models.Position, maxRange int) bool {
	dx := pos1.X - pos2.X
	dy := pos1.Y - pos2.Y
	distanceSquared := dx*dx + dy*dy
	return distanceSquared <= maxRange*maxRange
}

func (p *GamePlayer) TakeDamage(amount int) {
	fmt.Printf("%s took %d damage\n", p.Name, amount)
	// ตัด HP เป็นต้น
}
