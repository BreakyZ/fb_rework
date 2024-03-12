this.xxdarkelf_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.xxherosp";
		this.m.Name = "High Elf";
		this.m.Icon = "ui/xxherohighelf_icon.png";
		this.m.BackgroundDescription = "High Elves are the oldest and purest bloodline of ancient elf races. [color=" + this.Const.UI.Color.NegativeValue + "](Warning: This character cannot use skill books.)[/color]";
		this.m.GoodEnding = "%name% retired from %companyname%. After retirement, she continued her life as a mercenary and adventurer, gaining fame for her many exploits, and her story has become legendary and passed down through generations.";
		this.m.BadEnding = "%name% retired from %companyname%. Since then, no one has heard any news about %name%";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 50;
		this.m.Excluded = [
			"trait.dumb",
			"trait.greedy",
			"trait.night_blind",
			"trait.short_sighted",
			"trait.superstitious",
			"trait.paranoid",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.ailing",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.asthmatic"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BeardChance = 0;
		this.m.Names = this.Const.Strings.AncientDeadNames;
	  if("LegendMod" in this.Const)
	  {
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.PerkTreeDynamicMins.Defense = 3;
		this.m.PerkTreeDynamicMins.Enemy = 2;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.GreatSwordTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.BowTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.MediumArmorTree,
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.CalmTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		};
	  };
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=#135213]+20%[/color] Ranged skill damage"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=#135213]+2[/color] Vision"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=#135213]+5[/color] Health and Fatigue regeneration per turn"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When killing enemy: [color=#135213]+2[/color] AP, [color=#135213]-10[/color] fatigue (cannot exceed 9 AP)"
			}
		];
	}

	function onBuildDescription()
	{
		return "%name% is a High Elf, belonging to the oldest and purest bloodline of the ancient elf races. [color=" + this.Const.UI.Color.NegativeValue + "](Warning: This character cannot use skill books.)[/color]";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				10
			],
			Bravery = [
				10,
				10
			],
			Stamina = [
				10,
				10
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				25,
				25
			],
			MeleeDefense = [
				5,
				5
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				15,
				15
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local xbody = actor.getSprite("body");
		local xhead = actor.getSprite("head");
		local xhair = actor.getSprite("hair");
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		xbody.setBrush("bust_naked_body_78" + this.Math.rand(69, 70));
		xhead.setBrush("bust_head_787" + this.Math.rand(0, 1));
		xhair.setBrush("hair_elf_0" + this.Math.rand(1, 6));
		local pp = this.Math.rand(0, 3)
		if (pp == 1)
		{
			tattoo_body.setBrush("warpaint_01_" + actor.getSprite("body").getBrush().Name);
			tattoo_body.Visible = true;
			tattoo_head.setBrush("warpaint_01_head");
			tattoo_head.Visible = true;
		}
		else
		if (pp == 2)
		{
			tattoo_body.setBrush("tattoo_02_" + actor.getSprite("body").getBrush().Name);
			tattoo_body.Visible = true;
			tattoo_head.setBrush("tattoo_02_head");
			tattoo_head.Visible = true;
		}
		tattoo_body.Scale = 0.8;
		actor.getSprite("permanent_injury_4").setBrush("zombie_rage_eyes");
		actor.getSprite("permanent_injury_4").Visible = true;
		actor.getSprite("permanent_injury_4").Color = this.createColor("#ffffff");
		actor.getSprite("permanent_injury_4").Saturation = 0.3;
		actor.setSpriteOffset("permanent_injury_4", this.createVec(0, -0.9));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/war_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.addToBag(this.new("scripts/items/weapons/dagger"));
	  if("LegendMod" in this.Const)
	  {
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"worn_mail_shirt"
			]
		]));
	  }
	  else
	  {
		items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
	  }
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/ghost_death_01.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/ghost_death_02.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
			"sounds/enemies/ghastly_touch_01.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_04.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
	}

	function onAfterUpdate( _properties )
	{
		_properties.RangedDamageMult += 0.2;
		_properties.FatigueRecoveryRate += 5;
		_properties.HitpointsRecoveryRate += 4;
		_properties.Vision += 2;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + 1));
		actor.setDirty(true);
		actor.onUpdateInjuryLayer();
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		if (actor.isAlliedWith(_targetEntity))
		{
			return;
		}
		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID())
		{
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 2));
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - 10));
			this.spawnIcon("status_effect_29", this.m.Container.getActor().getTile());
			actor.setDirty(true);
		}
	}

});

