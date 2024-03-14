this.xxhalforc_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BeardChance = 0;
		this.m.Names = this.Const.Strings.OrcWarlordNames;
		this.m.Name = "Half-Orc";
		this.m.Icon = "ui/xxp29.png";
		this.m.BackgroundDescription = "Half-Orcs are born from the brutality of orcs against humans. Not much less strong than an orc, half-orcs are hated by other greenskins and discriminated in human society. Their natural strength and vitality make them highly sought-after mercenaries, even if they are slow and dimwited.";
		this.m.GoodEnding = "%name% retired from %companyname%. After retirement, {%name% returned to the life of an adventurer and made a name for himself/herself in the world by slaying monsters, finding treasure, and discovering mysterious places. | %name% gathered like-minded people to form his/her own mercenary company and became a leader, earning the respect of his/her subordinates and making a name for himself/herself in the world. | wanting to live a quiet life, %name% settled in a village, bought a piece of land with the money he/she had saved, built a house, and lived a normal but happy life as per his/her wish. | many young adventurers who had heard of his/her reputation came to him/her for instruction. It is said that %name% became a good teacher, built up a reputation, and was finally elected to the position of Master of the Adventurer\'s Guild.}";
		this.m.BadEnding = "%name% retired from %companyname%. {Since then, no one has heard any news about %name% | %name% is believed to have died shortly thereafter from injuries sustained in battle | %name% returned as an adventurer, but is said to have died a miserable death, having done nothing of note.}";
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.hate_greenskins",
			"trait.ailing",
			"trait.swift",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.asthmatic",
			"trait.light",
			"trait.frail",
		];
		this.m.Titles = [
			"the Hammer",
			"the Destroyer",
			"the Shieldbreaker",
			"the Scourge",
			"the Maneater",
			"the Skullcrusher",
			"the Warbeast",
			"the Blackfist",
			"the Ravager",
			"the Slaughterer",
			"the Mountain"
		];
		this.m.HiringCost = 500;
		this.m.DailyCost = 35;
	}
	
	function onBuildDescription()
	{
		return "{Feared and hated all the same, %name%\'s towering physique dwarfs other races easily. | %name%\'s green skin and hulking body makes him stand out and be avoided. | Standing amongst people like a green giant, %name% scares onlookers and terrifies enemies. | Years of brutal combat in an orc camp has left %name% a scarred and scary figure.} {The orc has spent years mastering his craft to become a fury on the battlefield. | Discriminated in human society, the orc found employment in mercenary companies, selling his combat prowess to the highest bidder. | The orc sought military employment with a local lord, but was frequently shamed by the sergent. Eventually the small human had his skull shattered and %name% was banned from service. | Ordered to kill a lord\'s enemies, the orc kicked in the door of a family and slaughtered them all with his bare hands. When the lord refused to pay, %name% killed him, too. | The orc has spent many days mastering his ruthless craft and is eager to show it on the battlefield.} {Seeking a proper fight %name% decided to enter the employment of a sellsword's company. | Absolutely terrifying, %name% seeks the company of men who will not soil their breeches when the orc roars in battle. | Tired of fighting in the smelly orc encampment. %name% has decided to pick the other side in this war.}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local xbody = actor.getSprite("body");
		local xhead = actor.getSprite("head");
		local hair_color = [
			"black",
			"grey",
			"brown"
		];
		hair_color = hair_color[this.Math.rand(0, hair_color.len() - 1)]
		local hair_type = [
			"09",
			"19",
			"21"
		];
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local pp;
		xbody.setBrush("bust_naked_body_7872");
		xhead.setBrush("bust_head_787" + this.Math.rand(6, 8));
		pp = this.Math.rand(1, 2);
		if (pp == 1)
		{
			pp = this.Math.rand(0, hair_type.len() - 1);
			hair_type = hair_type[pp]
			actor.getSprite("hair").setBrush("hair_" + hair_color + "_" + hair_type);
			if (pp == 1)
			{
				actor.getSprite("beard").setBrush("beard_" + hair_color + "_08");
				actor.getSprite("beard").Visible = true;
			}
		}		
		pp = this.Math.rand(1, 3);
		if (pp == 1)
		{
			tattoo_body.setBrush("scar_01_bust_naked_body_southern_02");
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Saturation = 1.2;
			tattoo_body.Visible = true;
			tattoo_head.Visible = true;
		}
		else
		if (pp == 2)
		{
			tattoo_body.setBrush("warpaint_01_bust_naked_body_02");
			tattoo_head.setBrush("warpaint_01_head");
			tattoo_body.Color = this.createColor("#ff0000");
			tattoo_head.Color = this.createColor("#ff0000");
			tattoo_body.Saturation = 1.2;
			tattoo_head.Saturation = 1.2;
			tattoo_body.Visible = true;
			tattoo_head.Visible = true;
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				25,
				20
			],
			Bravery = [
				10,
				5
			],
			Stamina = [
				15,
				10
			],
			MeleeSkill = [
				20,
				15
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				5,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-15,
				-5
			]
		};
		return c;
	}
		
	function onAdded()
	{
		this.character_background.onAdded();
		this.m.Container.add(this.new("scripts/skills/actives/xxhalforc_warcry_skill"));
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		if (this.Math.rand(0, 1) == 0)
		{
			if (this.Math.rand(0, 1) == 0)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_wooden_club"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_metal_club"));
			}
		}
		else
		{
			if (this.Math.rand(0, 1) == 0)
			{
				items.equip(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
		}

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

	//function onAdded()
	//{
	//	this.character_background.onAdded();
	//	this.m.Container.add(this.new("scripts/skills/actives/xxzzfantasy_skill"));
	//	this.getContainer().getActor().getSkills().add(this.new("scripts/skills/actives/xxhalforcaa_skill"));
	//	this.getContainer().getActor().getSkills().add(this.new("scripts/skills/actives/xxhalforcbb_skill"));
	//}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = [
			"sounds/enemies/orc_hurt_01.wav",
			"sounds/enemies/orc_hurt_02.wav",
			"sounds/enemies/orc_hurt_03.wav",
			"sounds/enemies/orc_hurt_04.wav",
			"sounds/enemies/orc_hurt_05.wav",
			"sounds/enemies/orc_hurt_06.wav",
			"sounds/enemies/orc_hurt_07.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/orc_hurt_01.wav",
			"sounds/enemies/orc_hurt_02.wav",
			"sounds/enemies/orc_hurt_03.wav",
			"sounds/enemies/orc_hurt_04.wav",
			"sounds/enemies/orc_hurt_05.wav",
			"sounds/enemies/orc_hurt_06.wav",
			"sounds/enemies/orc_hurt_07.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/orc_death_01.wav",
			"sounds/enemies/orc_death_02.wav",
			"sounds/enemies/orc_death_03.wav",
			"sounds/enemies/orc_death_04.wav",
			"sounds/enemies/orc_death_05.wav",
			"sounds/enemies/orc_death_06.wav",
			"sounds/enemies/orc_death_07.wav",
			"sounds/enemies/orc_death_08.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/orc_flee_01.wav",
			"sounds/enemies/orc_flee_02.wav",
			"sounds/enemies/orc_flee_03.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/orc_idle_01.wav",
			"sounds/enemies/orc_idle_02.wav",
			"sounds/enemies/orc_idle_03.wav",
			"sounds/enemies/orc_idle_04.wav",
			"sounds/enemies/orc_idle_05.wav",
			"sounds/enemies/orc_idle_06.wav",
			"sounds/enemies/orc_idle_07.wav",
			"sounds/enemies/orc_idle_08.wav",
			"sounds/enemies/orc_idle_09.wav",
			"sounds/enemies/orc_idle_10.wav",
			"sounds/enemies/orc_idle_11.wav",
			"sounds/enemies/orc_idle_12.wav",
			"sounds/enemies/orc_idle_13.wav",
			"sounds/enemies/orc_idle_14.wav",
			"sounds/enemies/orc_idle_15.wav",
			"sounds/enemies/orc_idle_16.wav",
			"sounds/enemies/orc_idle_17.wav",
			"sounds/enemies/orc_idle_18.wav",
			"sounds/enemies/orc_idle_19.wav",
			"sounds/enemies/orc_idle_20.wav",
			"sounds/enemies/orc_idle_21.wav",
			"sounds/enemies/orc_idle_22.wav",
			"sounds/enemies/orc_idle_23.wav",
			"sounds/enemies/orc_idle_24.wav",
			"sounds/enemies/orc_idle_25.wav",
			"sounds/enemies/orc_idle_26.wav",
			"sounds/enemies/orc_idle_27.wav",
			"sounds/enemies/orc_idle_28.wav",
			"sounds/enemies/orc_idle_29.wav"
		];
		actor.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.8;
		actor.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 0.8;
	}

});

