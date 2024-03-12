this.sbp_kensei_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_kensei_skill";
		this.m.Name = "Kensei (passive)";
		this.m.Icon = "ui/xxp7.png";
		this.m.Description = "Kensei is an honorary title in the eastern kingdom given to a warrior of legendary skill in swordsmanship.";
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
			text = "When using the swords: +5 Resolve, +7 Melee Skill"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When using the Warbrand: +10 Melee Defense"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When using the Nodachi: +10 Ranged Defense"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local actorsk = actor.getSkills();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (actorsk.hasSkill("actives.slash") || actorsk.hasSkill("actives.overhead_strike"))
		{
			_properties.Bravery += 5;
			_properties.MeleeSkill += 7;
		}
		if (item != null)
		{
			if (item.getID() == "weapon.warbrand" || item.getID() == "weapon.named_warbrand")
			{
				_properties.MeleeDefense += 10;
			}
			if (item.getID() == "weapon.xxnodachi")
			{
				_properties.RangedDefense += 10;
			}
		}
	}

});

