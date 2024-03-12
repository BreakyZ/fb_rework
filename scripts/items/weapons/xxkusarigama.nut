this.xxkusarigama <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxkusarigama";
		this.m.Name = "Kusarigama";
		this.m.Description = "It is a weapon for self-defense that has been modified from agricultural equipment. It is difficult to handle, but very powerful when used by professionals.";
		this.m.Categories = "Cleaver/Flail, Two-Handed";
		this.m.IconLarge = "xx_weapon_17.png";
		this.m.Icon = "xx_weapon_17_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_17";
		this.m.Value = 3500;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -12;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "On Hit: 15% chance to strong bleeding (250 Damage, 2 Turn, Ignore bleeding immunity)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] Experience Gain"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local ttt = this.new("scripts/skills/actives/decapitate");
		ttt.m.ID = "actives.cleave";
		ttt.m.IsIgnoredAsAOO = false;
		ttt.m.FatigueCost = 15;
		this.addSkill(ttt);
		ttt = this.new("scripts/skills/actives/lash_skill");
		ttt.m.ID = "actives.flail";
		ttt.m.MaxRange = 2;
		this.addSkill(ttt);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		_properties.XPGainMult *= 1.2;
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.weapon.onDamageDealt(_target, _skill, _hitInfo);
		if (!_target.isAlive() || _target.isDying())
		{
			return;
		}
		if (_skill.getID() == "actives.decapitate" || _skill.getID() == "actives.lash")
		{
			if (this.Math.rand(1, 100) <= 15)
			{
				local effect = this.new("scripts/skills/effects/bleeding_effect");
				effect.setDamage(250);
				_target.getSkills().add(effect);
			}
		}
	}

});

