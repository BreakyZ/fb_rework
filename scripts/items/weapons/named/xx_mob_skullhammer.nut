this.xx_mob_skullhammer <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.xx_mob_skullhammer";
		this.m.Name = "cultist hammer";
		this.m.Description = "cultist hammer";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 3200;
		this.m.ShieldDamage = 26;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.StaminaModifier = -16;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.8;
		this.m.DirectDamageMult = 0.5;
		this.m.DirectDamageAdd = 0.1;
		this.m.ChanceToHitHead = 0;
		this.m.ArmamentIcon = "icon_wildmen_06_named_01";
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill = this.new("scripts/skills/actives/smite_skill");
		skill.m.Icon = "skills/active_180.png";
		skill.m.IconDisabled = "skills/active_180_sw.png";
		skill.m.Overlay = "active_180";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/shatter_skill");
		skill.m.Icon = "skills/active_181.png";
		skill.m.IconDisabled = "skills/active_181_sw.png";
		skill.m.Overlay = "active_181";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/batter_skill");
		skill.m.Icon = "skills/active_180.png";
		skill.m.IconDisabled = "skills/active_180_sw.png";
		skill.m.Overlay = "active_180";
		skill.m.SoundOnUse = [
			"sounds/combat/smash_01.wav",
			"sounds/combat/smash_02.wav",
			"sounds/combat/smash_03.wav"
		];
		skill.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav",
			"sounds/combat/smash_hit_02.wav",
			"sounds/combat/smash_hit_03.wav"
		];
		skill.m.MinRange = 2;
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/reap_skill");
		skill.m.Icon = "skills/active_181.png";
		skill.m.IconDisabled = "skills/active_181_sw.png";
		skill.m.Overlay = "active_181";
		skill.m.SoundOnUse = [
			"sounds/combat/shatter_01.wav",
			"sounds/combat/shatter_02.wav",
			"sounds/combat/shatter_03.wav"
		];
		skill.m.SoundOnHitHitpoints = [
			"sounds/combat/shatter_hit_01.wav",
			"sounds/combat/shatter_hit_02.wav",
			"sounds/combat/shatter_hit_03.wav"
		];
		skill.m.MinRange = 2;
		skill.m.DirectDamageMult = 0.3;
		this.addSkill(skill);
	}

});

