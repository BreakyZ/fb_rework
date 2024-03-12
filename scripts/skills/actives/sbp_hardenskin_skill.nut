this.sbp_hardenskin_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_hardenskin_skill";
		this.m.Name = "Harden Skin (passive)";
		this.m.Icon = "ui/xxp8.png";
		this.m.Description = "By training the body to the extreme, one can become so invincible that even armor is not necessary";
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
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When the head slot is empty: +12 Melee Skill, +12 Ranged Skill, +12 Melee Defense"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When the body slot is empty: +120 HP"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When the head and body slots are empty: No morale check triggered upon losing hitpoints"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local bodyt = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local headt = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		if (bodyt == null)
		{
			_properties.Hitpoints += 120;
		}
		if (headt == null)
		{
			_properties.MeleeDefense += 12;
			_properties.MeleeSkill += 12;
			_properties.RangedSkill += 12;
		}
		if (bodyt == null && headt == null)
		{
			_properties.IsAffectedByLosingHitpoints = false;
		}
	}

});

