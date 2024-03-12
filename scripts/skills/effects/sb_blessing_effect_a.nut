this.sb_blessing_effect_a <- this.inherit("scripts/skills/skill", {
	m = {
		IsUsed = false
	},
	function create()
	{
		this.m.ID = "effects.sb_blessing_effect_a";
		this.m.Name = "Blessing";
		this.m.Description = "The next attack will inflict [color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] damage to a single target. If multiple targets are hit, only the first one will receive increased damage. If the attack misses, the effect is wasted.";
		this.m.Icon = "skills/status_effect_73.png";
		this.m.IconMini = "status_effect_73_mini";
		this.m.Overlay = "status_effect_73";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsUsed)
		{
			_properties.ActionPoints += 2;
		}
		_properties.DamageTotalMult += 0.3;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.removeSelf();
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		if (!this.m.IsUsed)
		{
			this.m.IsUsed = true;
		}
	}

});

