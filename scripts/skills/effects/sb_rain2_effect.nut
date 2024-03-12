this.sb_rain2_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.sb_rain2_effect";
		this.m.Icon = "skills/status_effect_109.png";
		this.m.IconMini = "status_effect_109_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsAttack = false,
		this.m.IsWeaponSkill = false,
		this.m.IsStacking = false;
		this.m.IsSerialized = false;
		this.m.IsHidden = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function onCombatStarted()
	{
		this.removeSelf();
	}

});

