this.sbp_battletrance_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_battletrance_skill";
		this.m.Name = "Battle Trance (passive)";
		this.m.Icon = "ui/xxp9.png";
		this.m.Description = "People with this skill become more powerful as they become more fatigued.";
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
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When the currently used fatigue is 80% or more of the total fatigue: +8 Melee Defense, +8 Ranged Defense"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When remaining fatigue is 25 or less more: +8 Melee Skill, +8 Ranged Skill"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getFatiguePct() >= 0.8)
		{
			_properties.MeleeDefense += 8;
			_properties.RangedDefense += 8;
		}
		if (actor.getCurrentProperties().Stamina - actor.getFatigue() <= 25)
		{
			_properties.MeleeSkill += 8;
			_properties.RangedSkill += 8;
		}
	}

});

