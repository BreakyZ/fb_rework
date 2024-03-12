this.xxhobgoblin_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BeardChance = 0;
		this.m.Names = this.Const.Strings.GoblinNames;
		
		this.m.Name = "Hobgoblin";
		this.m.Icon = "ui/xxp2.png";
		this.m.BackgroundDescription = "Hobgoblins are a breed of particulary large and nasty goblins. As despised as greenskins are, they still sometimes find their ways to human cities, where they find work as thugs and sellswords for the right pay.";
		this.m.GoodEnding = "%name% retired from %companyname%. After retirement, {%name% returned to the life of an adventurer and made a name for himself/herself in the world by slaying monsters, finding treasure, and discovering mysterious places. | %name% gathered like-minded people to form his/her own mercenary company and became a leader, earning the respect of his/her subordinates and making a name for himself/herself in the world. | wanting to live a quiet life, %name% settled in a village, bought a piece of land with the money he/she had saved, built a house, and lived a normal but happy life as per his/her wish. | many young adventurers who had heard of his/her reputation came to him/her for instruction. It is said that %name% became a good teacher, built up a reputation, and was finally elected to the position of Master of the Adventurer\'s Guild.}";
		this.m.BadEnding = "%name% retired from %companyname%. {Since then, no one has heard any news about %name% | %name% is believed to have died shortly thereafter from injuries sustained in battle | %name% returned as an adventurer, but is said to have died a miserable death, having done nothing of note.}";
		this.m.HiringCost = 500;
		this.m.DailyCost = 35;
	}

	function onBuildDescription()
	{
		return "%fullname% is a hobogblin TODO.";
	}
	
	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local xhead = actor.getSprite("head");
		local xbody = actor.getSprite("body");
		xbody.setBrush("bust_naked_body_7871");
		xhead.setBrush("xxgoblin_head_" + this.Math.rand(100, 103));
		xbody.Saturation = 0.8;
		xbody.varySaturation(0.2);
		xbody.varyColor(0.025, 0.025, 0.025);
		xhead.Color = xbody.Color;
		xhead.Saturation = xbody.Saturation;
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
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/goblin_hurt_00.wav",
			"sounds/enemies/goblin_hurt_01.wav",
			"sounds/enemies/goblin_hurt_02.wav",
			"sounds/enemies/goblin_hurt_03.wav",
			"sounds/enemies/goblin_hurt_04.wav",
			"sounds/enemies/goblin_hurt_05.wav",
			"sounds/enemies/goblin_hurt_06.wav",
			"sounds/enemies/goblin_hurt_07.wav",
			"sounds/enemies/goblin_hurt_08.wav",
			"sounds/enemies/goblin_hurt_09.wav",
			"sounds/enemies/goblin_hurt_10.wav",
			"sounds/enemies/goblin_hurt_11.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/goblin_death_00.wav",
			"sounds/enemies/goblin_death_01.wav",
			"sounds/enemies/goblin_death_02.wav",
			"sounds/enemies/goblin_death_03.wav",
			"sounds/enemies/goblin_death_04.wav",
			"sounds/enemies/goblin_death_05.wav",
			"sounds/enemies/goblin_death_06.wav",
			"sounds/enemies/goblin_death_07.wav",
			"sounds/enemies/goblin_death_08.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/goblin_flee_00.wav",
			"sounds/enemies/goblin_flee_01.wav",
			"sounds/enemies/goblin_flee_02.wav",
			"sounds/enemies/goblin_flee_03.wav",
			"sounds/enemies/goblin_flee_04.wav",
			"sounds/enemies/goblin_flee_05.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/goblin_idle_00.wav",
			"sounds/enemies/goblin_idle_01.wav",
			"sounds/enemies/goblin_idle_02.wav",
			"sounds/enemies/goblin_idle_03.wav",
			"sounds/enemies/goblin_idle_04.wav",
			"sounds/enemies/goblin_idle_05.wav",
			"sounds/enemies/goblin_idle_06.wav",
			"sounds/enemies/goblin_idle_07.wav",
			"sounds/enemies/goblin_idle_08.wav",
			"sounds/enemies/goblin_idle_09.wav",
			"sounds/enemies/goblin_idle_10.wav",
			"sounds/enemies/goblin_idle_11.wav",
			"sounds/enemies/goblin_idle_12.wav",
			"sounds/enemies/goblin_idle_13.wav",
			"sounds/enemies/goblin_idle_14.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = actor.m.Sound[this.Const.Sound.ActorEvent.Idle];
	}

});

