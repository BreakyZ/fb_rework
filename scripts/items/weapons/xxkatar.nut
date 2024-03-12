this.xxkatar <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxkatar";
		this.m.Name = "Katar";
		this.m.Description = "Unusual swords that grips like a fist in each hand.";
		this.m.Categories = "Unknown Weapon/Sword, Two-Handed";
		this.m.IconLarge = "xx_weapon_01.png";
		this.m.Icon = "xx_weapon_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_01";
		this.m.Value = 5000;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 10;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Max Damage Bonus: [color=" + this.Const.UI.Color.PositiveValue + "]Initiative - 105[/color]"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local ww;
		this.addSkill(this.new("scripts/skills/actives/xxitem_kataraa_skill"));
		ww = this.new("scripts/skills/actives/swing");
		ww.m.DirectDamageMult = 0.4;
		this.addSkill(ww);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local gg = this.getContainer().getActor().getBaseProperties().Initiative;
		if (gg > 105)
		{
			_properties.DamageRegularMax += gg - 105;
		}
	}

});

