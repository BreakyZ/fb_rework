this.xxruneblade <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxruneblade";
		this.m.Name = "Rune Glaive";
		this.m.Description = "A weapon with a blade engraved with runic magic.";
		this.m.Categories = "Cleaver/Sword, Two-Handed";
		this.m.IconLarge = "xx_weapon_06.png";
		this.m.Icon = "xx_weapon_06_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_06";
		this.m.Value = 5000;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.4;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Max Damage Bonus: [color=" + this.Const.UI.Color.PositiveValue + "]Ranged Defense x 1.2[/color]"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local ww;
		ww = this.new("scripts/skills/actives/cleave");
		ww.m.FatigueCost = 15;
		ww.m.ActionPointCost = 5;
		ww.m.DirectDamageMult = 0.4;
		this.addSkill(ww);
		ww = this.new("scripts/skills/actives/split");
		ww.m.DirectDamageMult = 0.4;
		this.addSkill(ww);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local gg = this.getContainer().getActor().getBaseProperties().RangedDefense;
		if (gg >= 1)
		{
			_properties.DamageRegularMax += gg * 1.2;
		}
	}

});

