this.xxheavylance <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxheavylance";
		this.m.Name = "Heavy Lance";
		this.m.Description = "A huge cone-shaped spear. A good weapon for cavalry in heavy armor.";
		this.m.Categories = "Unknown Weapon, One-Handed";
		this.m.IconLarge = "xx_weapon_13.png";
		this.m.Icon = "xx_weapon_13_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_13";
		this.m.Value = 2000;
		this.m.Condition = 70;
		this.m.ConditionMax = 70;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.4;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When riding on a \'Horse\' or \'Wolf\' : Add special skill"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When the total durability of armor and helmet is 500 or more : +50% Increase armor damage"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_heavylanceaa_skill"));
		this.addSkill(this.new("scripts/skills/actives/xxitem_heavylancebb_skill"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		local zzhead = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local xxhead = 0;
		local zzbody = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		local xxbody = 0;
		if (zzhead != null)
		{
			xxhead = this.Math.floor(actor.getArmorMax(this.Const.BodyPart.Head) * 1);
		}
		if (zzbody != null)
		{
			xxbody = this.Math.floor(actor.getArmorMax(this.Const.BodyPart.Body) * 1);
		}
		if (xxhead + xxbody >= 500)
		{
			_properties.DamageArmorMult += 0.5;
		}
	}

});

