this.fb_felinid_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.fb_felinid";
		this.m.Name = "Felinid";
		this.m.Icon = "ui/perks/perk_07.png";
		this.m.BackgroundDescription = "A rare sight in the northern kingdoms, felinids are a race of cat-like people that hail from untamed and dangerous jungles far south, where few dare to wander and even fewer return. They are known for their strength and agility, aswell as sharp senses, making them formidable mercenaries.";
		this.m.GoodEnding = "%name% retired from %companyname%. After retirement, {%name% returned to the life of an adventurer and made a name for himself in the world by slaying monsters, finding treasure, and discovering mysterious places. | %name% gathered like-minded people to form his own mercenary company and became a leader, earning the respect of his subordinates and making a name for himself in the world. | wanting to live a quiet life, %name% settled in a village, bought a piece of land with the money he had saved, built a house, and lived a normal but happy life as per his wish. | many young adventurers who had heard of his reputation came to him for instruction. It is said that %name% became a good teacher, built up a reputation, and was finally elected to the position of Master of the Adventurer\'s Guild.}";
		this.m.BadEnding = "%name% retired from %companyname%. {Since then, no one has heard any news about %name% | %name% is believed to have died shortly thereafter from injuries sustained in battle | %name% returned as an adventurer, but is said to have died a miserable death, having done nothing of note.}";
		this.m.HiringCost = 500;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.night_blind",
			"trait.short_sighted",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.ailing",
			"trait.clubfooted",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fat",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.asthmatic",
			"trait.light",
			"trait.frail",
			"trait.paranoid"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BeardChance = 0;
		
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[1];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		//this.m.PerkTreeDynamicMins.Defense = 3;
		//this.m.PerkTreeDynamicMins.Enemy = 2;
		
		//this.m.PerkTreeDynamic = {
		//	Weapon = [
		//		this.Const.Perks.GreatSwordTree,
		//		this.Const.Perks.PolearmTree,
		//		this.Const.Perks.AxeTree,
		//		this.Const.Perks.MaceTree,
		//		//this.Const.Perks.FlailTree,
		//		this.Const.Perks.HammerTree,
		//		this.Const.Perks.SpearTree,
		//		this.Const.Perks.SwordTree,
		//		this.Const.Perks.DaggerTree,
		//		//this.Const.Perks.BowTree,
		//		//this.Const.Perks.CrossbowTree,
		//		this.Const.Perks.ShieldTree,
		//		this.Const.Perks.ThrowingTree
		//	],
		//	Defense = [
		//		this.Const.Perks.LightArmorTree,
		//		this.Const.Perks.MediumArmorTree,
		//		//this.Const.Perks.HeavyArmorTree
		//	],
		//	Traits = [
		//		//this.Const.Perks.CalmTree,
		//		//this.Const.Perks.OrganisedTree,
		//		this.Const.Perks.IndestructibleTree,
		//		this.Const.Perks.AgileTree,
		//		//this.Const.Perks.DeviousTree,
		//		//this.Const.Perks.TrainedTree,
		//		this.Const.Perks.JugglerTree,
		//		this.Const.Perks.ViciousTree,
		//		//this.Const.Perks.SturdyTree,
		//		this.Const.Perks.FitTree,
		//		this.Const.Perks.BerserkerTree,
		//		this.Const.Perks.LeadershipTree
		//	],
		//	Enemy = [],
		//	Class = [],
		//	Magic = []
		//};
		
		this.m.CustomPerkTree = [
			[
				this.Const.Perks.PerkDefs.LegendAmbidextrous,
				this.Const.Perks.PerkDefs.Lookout,
				this.Const.Perks.PerkDefs.Adrenaline,
				this.Const.Perks.PerkDefs.CripplingStrikes,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.LegendAlert,
				this.Const.Perks.PerkDefs.FastAdaption,
			],
			[
				this.Const.Perks.PerkDefs.FortifiedMind,
				this.Const.Perks.PerkDefs.CoupDeGrace,
				this.Const.Perks.PerkDefs.Dodge,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.LegendBalance,
				this.Const.Perks.PerkDefs.SteelBrow,
				this.Const.Perks.PerkDefs.QuickHands,
				this.Const.Perks.PerkDefs.LegendQuickStep,
				this.Const.Perks.PerkDefs.LegendOnslaught,
				this.Const.Perks.PerkDefs.BloodyHarvest,
				this.Const.Perks.PerkDefs.LegendSmackdown,
				this.Const.Perks.PerkDefs.RallyTheTroops,
			],
			[
				this.Const.Perks.PerkDefs.Brawny,
				this.Const.Perks.PerkDefs.Anticipation,
				this.Const.Perks.PerkDefs.Rotation,
				this.Const.Perks.PerkDefs.Relentless,
				this.Const.Perks.PerkDefs.Feint,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.Debilitate,
				this.Const.Perks.PerkDefs.Sprint,
				this.Const.Perks.PerkDefs.LegendSpecSpearWall,
				//this.Const.Perks.PerkDefs.Steadfast,
			],
			[
				this.Const.Perks.PerkDefs.SpecSpear,
				this.Const.Perks.PerkDefs.SpecPolearm,
				this.Const.Perks.PerkDefs.SpecSword,
				this.Const.Perks.PerkDefs.SpecDagger,
				this.Const.Perks.PerkDefs.SpecBow,
				this.Const.Perks.PerkDefs.SpecMace,
				this.Const.Perks.PerkDefs.SpecAxe,
				this.Const.Perks.PerkDefs.LegendSpecGreatSword,
				this.Const.Perks.PerkDefs.SpecThrowing,
				this.Const.Perks.PerkDefs.ShieldExpert,
				this.Const.Perks.PerkDefs.LegendUnarmedTraining,
			],
			[
				this.Const.Perks.PerkDefs.DoubleStrike,
				this.Const.Perks.PerkDefs.Underdog,
				this.Const.Perks.PerkDefs.Footwork,
				//this.Const.Perks.PerkDefs.LoneWolf,
				this.Const.Perks.PerkDefs.LegendHeightenedReflexes,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyNomad,
				//this.Const.Perks.PerkDefs.LegendFavouredEnemyHyena,
				this.Const.Perks.PerkDefs.LegendAdaptive,
				this.Const.Perks.PerkDefs.LegendEvasion,
				this.Const.Perks.PerkDefs.LegendClarity,
			],
			[
				this.Const.Perks.PerkDefs.Berserk,
				this.Const.Perks.PerkDefs.Overwhelm,
				this.Const.Perks.PerkDefs.HeadHunter,
				this.Const.Perks.PerkDefs.LegendUnarmedLunge,
				//this.Const.Perks.PerkDefs.BattleForged,
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.LegendAssuredConquest,
				this.Const.Perks.PerkDefs.LegendForcefulSwing,
				this.Const.Perks.PerkDefs.Duelist
			],
			[
				this.Const.Perks.PerkDefs.Fearsome,
				this.Const.Perks.PerkDefs.LegendMuscularity,
				this.Const.Perks.PerkDefs.KillingFrenzy,
				this.Const.Perks.PerkDefs.PushTheAdvantage,
				this.Const.Perks.PerkDefs.Inspire,
				this.Const.Perks.PerkDefs.LegendFreedomOfMovement,
				this.Const.Perks.PerkDefs.InspiringPresence,
				//this.Const.Perks.PerkDefs.LegendCheerOn,
			],
			[],
			[],
			[],
			[]
		];
		
		local maleNames =
		[
			"Abedi",
			"Akida",
			"Amaziah",
			"Asafa",
			"Asani",
			"Asanis",
			"Ashura",
			"Athumani",
			"Auni",
			"Azizi",
			"Badru",
			"Bahati",
			"Bakari",
			"Chacha",
			"Chandu",
			"Chane",
			"Djimon",
			"Elewisa",
			"Enzi",
			"Hami",
			"Hashaan",
			"Hassian",
			"Iniko",
			"Jabali",
			"Jabori",
			"Jahari",
			"Jasiri",
			"Jel",
			"Johari",
			"Kamili",
			"Kenyada",
			"Kenyatta",
			"Khari",
			"Kion",
			"Kito",
			"Kobe",
			"Kondo",
			"Kovu",
			"Mosi",
			"Mufasa",
			"Pendo",
			"Pumba",
			"Rafiki",
			"Reth",
			"Russom",
			"Sefu",
			"Shomari",
			"Simba",
			"Tabari",
			"Thimba"
		];
		
		this.m.Names = maleNames;
	}
	
	function setGender( _gender = -1 )
	{
		if (_gender == -1)
		{
			_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);
		}

		if (_gender != 1)
		{
			return;
		}

		local femaleNames =
		[
			"Adea",
			"Adia",
			"Adiah",
			"Ahadi",
			"Aiysha",
			"Akina",
			"Amana",
			"Amne",
			"Atiena",
			"Banou",
			"Bahati",
			"Barika",
			"Binti",
			"Chiku",
			"Desia",
			"Diani",
			"Hasnaa",
			"Hediye",
			"Imara",
			"Ishaal",
			"Jamala",
			"Jamani",
			"Jendaya",
			"Julani",
			"Jina",
			"Kenzi",
			"Kamaria",
			"Karisa",
			"Keny",
			"Kesi",
			"Kichaka",
			"Kimana",
			"Kimara",
			"Lakeisha",
			"Lakicia",
			"Liela",
			"Mosiya",
			"Nalah",
			"Nalla",
			"Nea",
			"Niagh",
			"Niambi",
			"Niari",
			"Nya",
			"Nyeema",
			"Nyimbo",
			"Nyota",
			"Nzuri",
			"Pacca",
			"Penda",
			"Riziki",
			"Safiya",
			"Sarabi",
			"Shani",
			"Shenzi",
			"Sikudhani",
			"Tabia",
			"Tambika",
			"Tish",
			"Tishala",
			"Zahara"
		];
		
		this.m.Names = femaleNames;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "%name% retired from %companyname%. After retirement, {%name% returned to the life of an adventurer and made a name for herself in the world by slaying monsters, finding treasure, and discovering mysterious places. | %name% gathered like-minded people to form his/her own mercenary company and became a leader, earning the respect of her subordinates and making a name for herself in the world. | wanting to live a quiet life, %name% settled in a village, bought a piece of land with the money she had saved, built a house, and lived a normal but happy life as per his/her wish. | Many young adventurers who had heard of her reputation came to her for instruction. It is said that %name% became a good teacher, built up a reputation, and was finally elected to the position of Master of the Adventurer\'s Guild.}";
		this.m.BadEnding = "%name% retired from %companyname%. {Since then, no one has heard any news about %name% | %name% is believed to have died shortly thereafter from injuries sustained in battle | %name% returned as an adventurer, but is said to have died a miserable death, having done nothing of note.}";
	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female)
			return "{You come to wonder how a someone covered in a thick pelt is completely unbothered by heat, but freezes in the snow and then %name% with her lion mane is living proof, that looks can be deceiving. | An odd sight in cities, the furred %name% is one roar away from paralyzing all onlookers. | Covered in hair all over, with a swaying tail behind her, %name% makes onlookers gawk and stare whenever she walks in human towns. | %name%\'s fur covered face, dyed in hazel, manages to portray both animalistic fury and human inquisitiveness.} {The felinid used to be a hunter, stalking prey with spear and bow, until her life was turned upside down by something unspeakable her kin met in the southern jungles. | Despite spending her time honoring the old god\'s way and preserving the balance of life, she was forced to suddenly change her ways and seek employment in the dangerous north, amongst the violent and destructive hairless savages. | As one of the first to encounter the great evil, she fought and survived and while this left many of her kin as cripples, this felinid became a motivated and powerful fighter. | As felinids fight with unknown to the northerners techniques and great ferocity, she should make a great asset as a sellsword.} {Finding herself a stranger in a strange land, %name% will quite literally fight with tooth and claw to turn her luck around. | With her brother in slavery, captured by the gilder, %name% has vowed to do anything to release him. | Seeking to estrablish a place for themselves, %name% like many others has turned to mercenary work to gather funds and reputation. | With her grueling experiences in the unfamiliar north, %name% has vowed to be a hunter, not the hunted.}";
		else
			return "{You come to wonder how a someone covered in a thick pelt is completely unbothered by heat, but freezes in the snow and then %name% with his lion mane is living proof, that looks can be deceiving. | An odd sight in cities, the furred %name% is one roar away from paralyzing all onlookers. | Covered in hair all over, with a swaying tail behind his, %name% makes onlookers gawk and stare whenever he walks in human towns. | %name%\'s fur covered face, dyed in hazel, manages to portray both animalistic fury and human inquisitiveness.} {The felinid used to be a hunter, stalking prey with spear and bow, until his life was turned upside down by something unspeakable his kin met in the southern jungles. | Despite spending his time honoring the old god\'s way and preserving the balance of life, he was forced to suddenly change his ways and seek employment in the dangerous north, amongst the violent and destructive hairless savages. | As one of the first to encounter the great evil, he fought and survived and while this left many of his kin as cripples, this felinid became a motivated and powerful fighter. | As felinids fight with unknown to the northerners techniques and great ferocity, he should make a great asset as a sellsword.} {Finding himself a stranger in a strange land, %name% will quite literally fight with tooth and claw to turn his luck around. | With his sister in slavery, captured by the gilder, %name% has vowed to do anything to release her. | Seeking to estrablish a place for themselves, %name% like many others has turned to mercenary work to gather funds and reputation. | With his grueling experiences in the unfamiliar north, %name% has vowed to be a hunter, not the hunted.}";
	}
	
	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local xbody = actor.getSprite("body");
		local xhead = actor.getSprite("head");
		local xhair = actor.getSprite("hair");
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		
		if (!this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			local pp;
			local hair_type = [
				//"hair_brown_02",
				"hair_brown_03",
				//"hair_brown_04",
				"hair_brown_08",
				"hair_brown_21",
				"hair_beast_01",
				"hair_beast_02",
				"hair_beast_03",
				"hair_beast_04",
				"hair_beast_04",
				"hair_beast_05",
				"hair_beast_05",
				"hair_beast_05"
			];
			hair_type = hair_type[this.Math.rand(0, hair_type.len() - 1)]
			xbody.setBrush("bust_naked_body_7873");
			xhead.setBrush("bust_head_788" + this.Math.rand(0, 2));
			xhair.setBrush(hair_type);
			pp = this.Math.rand(1, 3);
			if (pp == 1)
			{
				tattoo_body.setBrush("tattoo_0" + this.Math.rand(2, 4) + "_bust_naked_body_02");
				tattoo_head.setBrush("tattoo_01_head");
				tattoo_body.Visible = true;
				tattoo_head.Visible = true;
			}
			else
			if (pp == 2)
			{
				tattoo_body.setBrush("warpaint_01_bust_naked_body_02");
				tattoo_head.setBrush("warpaint_01_head");
				tattoo_body.Visible = true;
				tattoo_head.Visible = true;
			}
		}
		else
		{
			local hair_type = [
			//"hair_brown_02",
			"hair_brown_03",
			//"hair_brown_04",
			"hair_brown_08",
			//"hair_brown_10"
			"hair_brown_21",
			"hair_beast_01",
			"hair_beast_02",
			"hair_beast_06",
			"hair_beast_06",
			"hair_beast_04",
			"hair_beast_04",
			"hair_beast_05",
			"hair_beast_05",
			//"hair_brown_southern_03",
			"hair_brown_southern_06"
			];
			hair_type = hair_type[this.Math.rand(0, hair_type.len() - 1)]
			xbody.setBrush("bust_naked_body_7875");
			xhead.setBrush("bust_head_7883");
			xhair.setBrush(hair_type);
		}
	}
	
	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				5
			],
			Bravery = [
				25,
				20
			],
			Stamina = [
				5,
				0
			],
			MeleeSkill = [
				15,
				10
			],
			RangedSkill = [
				10,
				5
			],
			MeleeDefense = [
				10,
				5
			],
			RangedDefense = [
				10,
				5
			],
			Initiative = [
				20,
				10
			]
		};
		return c;
	}
	
	function onAdded()
	{
		this.character_background.onAdded();
		this.m.Container.removeByID("actives.hand_to_hand");
		this.m.Container.add(this.new("scripts/skills/actives/xxfelinid_claws_skill"));
		this.m.Container.add(this.new("scripts/skills/actives/xxfelinid_roar_skill"));
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		
		local armors =
		[
			"barbarians/animal_hide_armor",
			"barbarians/thick_furs_armor",
			"barbarians/hide_and_bone_armor",
			"barbarians/reinforced_animal_hide_armor"
		];
		local weapons =
		[
			"scripts/items/weapons/greenskins/goblin_notched_blade",
			"scripts/items/weapons/militia_spear",
			"scripts/items/weapons/barbarians/heavy_javelin"
		];
		
		items.equip(this.new("scripts/items/shields/greenskins/orc_light_shield"));
		items.equip(this.new(weapons[this.Math.rand(0, weapons.len() - 1)]));
		
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				armors[this.Math.rand(0, armors.len() - 1)]
			]
		]));
	}

});

