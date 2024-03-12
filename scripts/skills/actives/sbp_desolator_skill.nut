this.sbp_desolator_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_desolator_skill";
		this.m.Name = "Desolator (passive)";
		this.m.Icon = "ui/xxp22.png";
		this.m.Description = "+20% AoE Damage per each following perk: \n#Crippling Strikes, #Executioner, #Fearsome";
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAOE() && _skill.isAttack())
		{
			_properties.MeleeSkill += 15;
			local rr = 0;
			local bb = 0.2;
			local actor = this.getContainer().getActor();
			local tss = actor.getSkills();
			if (tss.hasSkill("perk.crippling_strikes"))
			{
				rr = rr + bb;
			}
			if (tss.hasSkill("perk.coup_de_grace"))
			{
				rr = rr + bb;
			}
			if (tss.hasSkill("perk.fearsome"))
			{
				rr = rr + bb;
			}
			_properties.DamageTotalMult += rr;
		}
	}

});

