this.xxrifle <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		IsLoaded = true
	},
	function isLoaded()
	{
		return this.m.IsLoaded;
	}

	function setLoaded( _l )
	{
		this.m.IsLoaded = _l;
	}

	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxrifle";
		this.m.Name = "Hextech Rifle";
		this.m.Description = "Advanced long range weapon that uses gunpowder. This weapon is the pinnacle of advanced technology, and few currently know how to make it.";
		this.m.Categories = "Unknown Weapon, Two-Handed";
		this.m.IconLarge = "xx_weapon_18.png";
		this.m.Icon = "xx_weapon_18_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_18";
		this.m.Value = 7000;
		this.m.RangeMin = 3;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -10;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.5;
	}

	function getAmmoID()
	{
		return "ammo.powder";
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Throwing/Crossbow/Bow mastery effect: +1 Range, +1 Vision, +7 Max damage"
		});
		if (!this.m.IsLoaded)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}
		return ret;
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInThrowing)
		{
			_properties.Vision += 1;
			_properties.DamageRegularMax += 7;
		}
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCrossbows)
		{
			_properties.Vision += 1;
			_properties.DamageRegularMax += 7;
		}
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInBows)
		{
			_properties.Vision += 1;
			_properties.DamageRegularMax += 7;
		}
		_properties.TargetAttractionMult *= 1.5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_rifleaa_skill"));

		if (!this.m.IsLoaded)
		{
			this.addSkill(this.new("scripts/skills/actives/xxitem_riflebb_skill"));
		}
	}

	function onCombatFinished()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
		this.m.IsLoaded = true;
	}

});

