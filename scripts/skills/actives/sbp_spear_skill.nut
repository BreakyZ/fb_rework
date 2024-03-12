this.sbp_spear_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_spear_skill";
		this.m.Name = "Phalanx (passive)";
		this.m.Icon = "ui/xxp4.png";
		this.m.Description = "+5 Melee skill and +40% Melee damage when the user has the \'Spear Wall\' buff";
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
		if (this.getContainer().getActor().getSkills().hasSkill("effects.spearwall"))
		{
			_properties.MeleeDamageMult += 0.4;
			_properties.MeleeSkill += 5;
		}
	}

});

