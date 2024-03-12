this.xxringblade <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxringblade";
		this.m.Name = "Ring Blade";
		this.m.Description = "An ancient weapon with a ring-shaped blade. A mysterious weapon that returns when thrown.";
		this.m.Categories = "Unknown Weapon, One-Handed";
		this.m.IconLarge = "xx_weapon_05.png";
		this.m.Icon = "xx_weapon_05_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_05";
		this.m.Value = 5000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 3;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.5;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Melee + Ranged Skill is 160 or more: [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense, Hitpoints, Max Fatigue"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_ringbladeaa_skill"));
		this.addSkill(this.new("scripts/skills/actives/xxitem_ringbladebb_skill"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local gg = this.getContainer().getActor().getBaseProperties().MeleeSkill;
		gg = gg + this.getContainer().getActor().getBaseProperties().RangedSkill;
		if (gg >= 160)
		{
			_properties.MeleeDefense += 10;
			_properties.Hitpoints += 10;
			_properties.Stamina += 10;
		}
	}

});

