this.fb_dragonslayer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.fb_dragonslayer";
		this.m.Name = "Dragon Slayer";
		this.m.Icon = "ui/xxherocrimson_icon.png";
		this.m.BackgroundDescription = "Once, dragons ruled the skies and struck fear into the hearts of men, and dragon slayers lived to hunt them down. But now, dragons are nearly gone. Left without purpose, many of them became ordinary mercenaries.";
		this.m.GoodEnding = "%name% retired from %companyname%. After retirement, he continued his life as a mercenary and adventurer, gaining fame for his many exploits, and his stories became legendary and passed down to future generations.";
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
			"trait.disloyal",
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
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.BeardChance = 50;
		this.m.Names = this.Const.Strings.KnightNames;
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
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Action point"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Damage"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Chance to hit head"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Armor piercing damage"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Armor Damage"
			}
		];
	}

	function onBuildDescription()
	{
		return "{Some believe dragons to be legend. And yet %name% insists not only to have seen them, but that slaying them was his occupation. | The vivid descriptions of flying fire breathing beasts make them seem like they once existed, could there be some truth to the stories? } {Turns out %name% may have been too good at his job, and has not been able to find work in a while. | Some may say that the man is clearly delusional, now spending his days in the tavern getting drunk, but he still looks more than capable. } { Mercenary work may not be as grandiose as slaying dragons, but it will do. | After slaying dragons, slaying beasts and bandits is basically child's play. The man offers you his sword, for the right pay.}";
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
				20,
				20
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
				10,
				10
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("accessory_special").setBrush("bust_militia_band_01");
		actor.getSprite("surcoat").setBrush("surcoat_04");
		actor.getSprite("surcoat").Saturation = 1.2;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/helmets/named/xxdragonhat"));
		items.equip(this.new("scripts/items/weapons/greatsword"));
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

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.ActionPoints += 1
		_properties.DamageTotalMult += 0.1;
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
		_properties.DamageDirectAdd += 0.1;
		_properties.DamageArmorMult += 0.1;
	}

	function onDeath( _fatalityType )
	{
		this.getContainer().getActor().getSprite("surcoat").setBrush("");
		this.skill.onDeath( _fatalityType )
	}

});

