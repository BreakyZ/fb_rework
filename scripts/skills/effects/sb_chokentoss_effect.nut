this.sb_chokentoss_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.sb_chokentoss_effect";
		this.m.Name = "Choked";
		this.m.Description = "It becomes the priority target for the Toss skill";
		this.m.Icon = "skills/status_effect_82.png";
		this.m.IconMini = "status_effect_82_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

