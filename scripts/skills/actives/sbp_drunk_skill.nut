this.sbp_drunk_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_drunk_skill";
		this.m.Name = "Drunken Master (passive)";
		this.m.Icon = "ui/xxp5.png";
		this.m.Description = "When \'Drunk\' or \'Hangover\' : +70% Damage, -10% Reduced damage taken";
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
		if (actor.getSkills().hasSkill("effects.drunk") || actor.getSkills().hasSkill("effects.hangover"))
		{
			_properties.DamageTotalMult += 0.7;
			_properties.DamageReceivedTotalMult *= 0.9;
			_properties.TargetAttractionMult *= 1.5;
		}
	}

});

