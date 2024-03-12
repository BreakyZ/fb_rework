this.sbp_counter_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_counter_skill";
		this.m.Name = "Adaptive Counter (passive)";
		this.m.Icon = "ui/xxp15.png";
		this.m.Description = "Gain additional Max Fatigue, Melee Skill, Ranged Skill by the following amounts: [color=" + this.Const.UI.Color.PositiveValue + "]Ranged Defense x 0.7[/color]";
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
		local rr = this.getContainer().getActor().getBaseProperties().RangedDefense * 0.7;
		if (rr >= 1)
		{
			_properties.Stamina += rr;
			_properties.MeleeSkill += rr;
			_properties.RangedSkill += rr;
		}
	}

});

