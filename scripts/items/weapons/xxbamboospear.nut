this.xxbamboospear <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxbamboospear";
		this.m.Name = "Bamboo Spear";
		this.m.Description = "A simple weapon made of bamboo. Crude but useful.";
		this.m.Categories = "Spear, Two-Handed";
		this.m.IconLarge = "xx_weapon_16.png";
		this.m.Icon = "xx_weapon_16_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_16";
		this.m.Value = 150;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.25;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] experience gain when less than or equal to level 8"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Melee Skill"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.setFatigueCost(15);
		thrust.m.ActionPointCost = 6;
		this.addSkill(thrust);
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
		this.addSkill(this.new("scripts/skills/actives/ai_spearwall_fake"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		_properties.MeleeSkill += 10;
		if (this.getContainer().getActor().getLevel() <= 8)
		{
			_properties.XPGainMult *= 1.1;
		}
	}

});

