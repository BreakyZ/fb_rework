this.sbp_skullsurgery_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_skullsurgery_skill";
		this.m.Name = "Skull Surgery (passive)";
		this.m.Icon = "ui/xxp14.png";
		this.m.Description = "When using Flail or Mace: [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee skill";
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
		local a = this.getContainer().getActor().getSkills();
		if (a.hasSkill("actives.flail") || a.hasSkill("actives.lash") || a.hasSkill("actives.cascade") || a.hasSkill("actives.pound") || 
		a.hasSkill("actives.bash") || a.hasSkill("actives.crumble") || a.hasSkill("actives.cudgel") || 
		a.hasSkill("actives.knock_out") || a.hasSkill("actives.knock_over") || a.hasSkill("actives.strike_down"))
		{
			_properties.MeleeSkill += 10;
		}
	}

});

