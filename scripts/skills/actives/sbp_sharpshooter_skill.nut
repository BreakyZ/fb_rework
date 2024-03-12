this.sbp_sharpshooter_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_sharpshooter_skill";
		this.m.Name = "Sharpshooter (passive)";
		this.m.Icon = "ui/xxp27.png";
		this.m.Description = "When this character uses a \'Bow\' or \'Crossbow\', the \'Bullseye\' and \'Anticipation\' perks have the following additional effects: \n+5 Ranged Skill, +3 Damage per 1 tile distance from enemy.";
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
		local tss = actor.getSkills();
		local rr = 0
		if (tss.hasSkill("perk.bullseye"))
		{
			rr = rr + 1;
		}
		if (tss.hasSkill("perk.anticipation"))
		{
			rr = rr + 1;
		}
		if (rr > 0)
		{
			if (actor.getSkills().hasSkill("actives.quick_shot") || actor.getSkills().hasSkill("actives.shoot_bolt") ||  actor.getSkills().hasSkill("actives.shoot_stake"))
			{
				_properties.RangedSkill += 5 * rr;
				_properties.DamageAdditionalWithEachTile += 3 * rr;
			}
		}
	}

});

