this.sbp_maso_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_maso_skill";
		this.m.Name = "Masochism (passive)";
		this.m.Icon = "ui/xxp11.png";
		this.m.Description = "This character enjoys its own pain and becomes stronger as they take more damage.";
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
			id = 3,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Your damage increases by up to 80% in proportion to your lost health"
		});
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When you are bleeding: +5 Melee and Ranged skill"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When your background is \'Flagellant\': +5 Melee and Ranged skill"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local rr = 1 - actor.getHitpointsPct();
		rr = rr * 0.8;
		if (rr > 0)
		{
			_properties.DamageTotalMult += rr;
		}
		if (actor.getSkills().hasSkill("effects.bleeding"))
		{
			_properties.MeleeSkill += 5;
			_properties.RangedSkill += 5;
		}
		if (actor.getSkills().hasSkill("background.flagellant"))
		{
			_properties.MeleeSkill += 5;
			_properties.RangedSkill += 5;
		}
	}

});

