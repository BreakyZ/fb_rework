this.sbp_bondage_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_bondage_skill";
		this.m.Name = "Mana Mastery (passive)";
		this.m.Icon = "ui/xxp26.png";
		this.m.Description = "Ranged damage increases by 40% of the current Resolve.";
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
		local rr = this.getContainer().getActor().getCurrentProperties().getBravery() * 0.004;
		if (rr > 0)
		{
			_properties.RangedDamageMult += rr;
		}
	}

});

