this.xxnodachi <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxnodachi";
		this.m.Name = "Nodachi";
		this.m.Description = "This is an exotic two handed sword with a very long blade. Only skilled warriors can use it properly.";
		this.m.Categories = "Sword, Two-Handed";
		this.m.IconLarge = "xx_weapon_07.png";
		this.m.Icon = "xx_weapon_07_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = false;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_07";
		this.m.Value = 5000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
		this.m.StaminaModifier = -15;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.2;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Current Defense is 8 or less: \n[color=" + this.Const.UI.Color.PositiveValue + "]+(Level x 2)[/color] Damage"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Current Health is 70 or less: \n[color=" + this.Const.UI.Color.PositiveValue + "]+(Level x 2)[/color] Damage"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local gash = this.new("scripts/skills/actives/gash_skill");
		gash.m.ID = "actives.slash";
		gash.m.IsIgnoredAsAOO = false;
		gash.m.FatigueCost = 15;
		this.addSkill(gash);
		local riposte = this.new("scripts/skills/actives/riposte");
		riposte.m.FatigueCost = 27;
		this.addSkill(riposte);
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		local rr = actor.getLevel() * 2
		if (actor.getCurrentProperties().getMeleeDefense() <= 8)
		{
			_properties.DamageRegularMin += rr;
			_properties.DamageRegularMax += rr;
		}
		if (this.getContainer().getActor().getHitpoints() <= 70)
		{
			_properties.DamageRegularMin += rr;
			_properties.DamageRegularMax += rr;
		}
	}

});

