this.xxcestus <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxcestus";
		this.m.Name = "Cestus";
		this.m.Description = "Combat gloves designed to protect boxer\'s hands.";
		this.m.Categories = "Unknown Weapon, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.IconLarge = "xx_weapon_20_70x70.png";
		this.m.Icon = "xx_weapon_20.png";
		this.m.ArmamentIcon = "icon_xx_weapon_20";
		this.m.Value = 150;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.StaminaModifier = 0;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.1;
		this.m.ChanceToHitHead = 10;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Bonus Head Hit Chance: \n[color=" + this.Const.UI.Color.PositiveValue + "]Level x 1[/color]"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Initiative"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_cestusaa_skill"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += this.getContainer().getActor().getLevel() * 1;
		_properties.Initiative += 20;
		_properties.MeleeDefense += 10;
	}

});

