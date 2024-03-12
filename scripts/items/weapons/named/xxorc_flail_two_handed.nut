this.xxorc_flail_two_handed <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.xxorc_flail_two_handed";
		this.m.Description = "A weapon that brutally crushed thousands of human heads. This weapon contain the grudges of the dead.";
		this.m.Categories = "Flail, Two-Handed";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 3500;
		this.m.ShieldDamage = 0;
		this.m.Condition = 90;
		this.m.ConditionMax = 90;
		this.m.StaminaModifier = -30;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 120;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 25;
		this.m.FatigueOnSkillUse = 5;
		this.m.IconLarge = "xx_weapon_91.png";
		this.m.Icon = "xx_weapon_91_70x70.png";
		this.m.ArmamentIcon = "icon_orc_weapon_05";
		this.m.Name = "Overlord\'s Human Crusher";
		this.randomizeValues();
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] melee defense"
		});
		return ret;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/pound");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/thresh");
		this.addSkill(skill);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		_properties.Threat += 10;
		_properties.MeleeDefense += 10;
	}

});

