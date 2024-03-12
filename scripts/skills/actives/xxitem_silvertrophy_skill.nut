this.xxitem_silvertrophy_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "passive.xxitem_silvertrophy_skill";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsHidden = true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() == this.getContainer().getActor().getFaction())
		{
			_properties.MeleeSkillMult *= 0;
			_properties.RangedSkillMult *= 0;
			_properties.DamageTotalMult *= 0;
		}
	}

});

