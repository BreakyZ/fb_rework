this.xxmeteor <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxmeteor";
		this.m.Name = "Meteor Hammer";
		this.m.Description = "A weapon with iron balls at the ends of both ropes. This weapon has a long range.";
		this.m.Categories = "Unknown Weapon, Two-Handed";
		this.m.IconLarge = "xx_weapon_02.png";
		this.m.Icon = "xx_weapon_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_02";
		this.m.Value = 2500;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 3;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.2;
		this.m.ChanceToHitHead = 10;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Flail/Mace/Hammer weapons mastery effect: +10% chance to hit head"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Bonus Head Hit Chance: Level x 0.7"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_meteoraa_skill"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		local rr = actor.getLevel() * 0.7;
		local rrbonus = 10;
		if (actor.getCurrentProperties().IsSpecializedInFlails)
		{
			rr = rr + rrbonus;
		}
		if (actor.getCurrentProperties().IsSpecializedInHammers)
		{
			rr = rr + rrbonus;
		}
		if (actor.getCurrentProperties().IsSpecializedInMaces)
		{
			rr = rr + rrbonus;
		}
		_properties.HitChance[this.Const.BodyPart.Head] += rr;
	}

});

