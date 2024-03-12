this.xxmagicstaff <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxmagicstaff";
		this.m.Name = "Magic Staff";
		this.m.Description = "A wooden staff imbued with mysterious power. It is an ordinary staff for ordinary people, but a special weapon for those with magical power.";
		this.m.Categories = "Mace, Two-Handed";
		this.m.IconLarge = "xx_weapon_14.png";
		this.m.Icon = "xx_weapon_14_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_14";
		this.m.Value = 2000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.4;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/bash"));
		this.addSkill(this.new("scripts/skills/actives/knock_out"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local gg = this.getContainer().getActor().getCurrentProperties().getBravery();
		if (gg >= 80)
		{
			gg = gg * 0.5;
			_properties.DamageRegularMax += gg;
		}
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Current Resolve is 80 or more: Increased Max Damage [color=" + this.Const.UI.Color.PositiveValue + "](50% Current Resolve)[/color]"
		});
		return ret;
	}

});

