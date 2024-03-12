this.sbp_hunting_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_hunting_skill";
		this.m.Name = "Primitive Hunting Skills (passive)";
		this.m.Icon = "ui/xxp3.png";
		this.m.Description = "Transcending humanity by mastering primitive hunting techniques to the extreme.";
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
			text = "When using the Throwing Spear / Staff sling / Spiked bolas / Orc javelin: [color=" + this.Const.UI.Color.PositiveValue + "]Level x 3[/color] Max Damage (max 60)"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			local dmg = this.Math.min(this.getContainer().getActor().getLevel() * 3, 60);
			if (actor.getSkills().hasSkill("actives.sling_stone") || actor.getSkills().hasSkill("actives.throw_balls") || item.getID() == "weapon.throwing_spear" || item.getID() == "weapon.orc_javelin")
			{
				_properties.DamageRegularMax += dmg;
			}
		}
	}

});

