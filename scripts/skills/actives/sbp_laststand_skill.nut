this.sbp_laststand_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_laststand_skill";
		this.m.Name = "Last Stand (passive)";
		this.m.Icon = "ui/xxp6.png";
		this.m.Description = "+100% damage increase when current morale status is \'Wavering\' or \'Breaking\'";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsSerialized = true;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getMoraleState() == this.Const.MoraleState.Wavering || actor.getMoraleState() == this.Const.MoraleState.Breaking)
		{
			_properties.DamageTotalMult += 1.0;
			_properties.TargetAttractionMult *= 1.5;
		}
	}

});

