this.xxmstaff <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		LastSkillUse = 0
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxmstaff";
		this.m.Name = "Lightning Staff";
		this.m.Description = "Hextech weapon that slaughters multiple enemies from a distance. It has strong destructive power, but its durability is very weak and decreases quickly.";
		this.m.Categories = "Unknown Weapon, Two-Handed";
		this.m.IconLarge = "xx_weapon_04.png";
		this.m.Icon = "xx_weapon_04_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_04";
		this.m.Value = 12000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 19;
		this.m.ConditionMax = 19;
		this.m.StaminaModifier = -15;
		this.m.RangeMin = 2;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0;
		this.m.DirectDamageMult = 1.0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_mstaffaa_skill"));
	}

	function onUse( _skill )
	{
		if (this.getContainer().getActor().isPlayerControlled() && _skill.getID() == "actives.aoe_a" && this.m.ConditionMax > 1)
		{
			this.lowerCondition(3);
		}
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
	}

});

