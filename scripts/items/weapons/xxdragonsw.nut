this.xxdragonsw <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxdragonsw";
		this.m.Name = "Dragon Slayer";
		this.m.Description = "It was too big to be called a sword. Massive, thick, heavy, and far too rough. Indeed, it was a heap of raw iron. This weapon has a fixed attack hit chance.";
		this.m.Categories = "Unknown Weapon, Two-Handed";
		this.m.IconLarge = "xx_weapon_08.png";
		this.m.Icon = "xx_weapon_08_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_08";
		this.m.Value = 7000;
		this.m.ShieldDamage = 50;
		this.m.Condition = 200;
		this.m.ConditionMax = 200;
		this.m.StaminaModifier = -40;
		this.m.RegularDamage = 100;
		this.m.RegularDamageMax = 130;
		this.m.ArmorDamageMult = 1.7;
		this.m.DirectDamageMult = 0.5;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_dragonswaa_skill"));
		this.addSkill(this.new("scripts/skills/actives/xxitem_dragonswbb_skill"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 8);
		this.addSkill(skillToAdd);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		_properties.MeleeDefense += 5;
	}

});

