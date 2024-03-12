this.xxwulin_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.xxwulin";
		this.m.Name = "Wu Lin";
		this.m.Icon = "ui/xxwulin_icon.png";
		this.m.BackgroundDescription = "Wu Lin is an outlaw from the Eastern Empire. Wu Lin\'s unique oriental fighting style is elusive and instills fear in his enemies.";
		this.m.GoodEnding = "%name% retired from %companyname%. His story became a legend and passed on to the people.";
		this.m.BadEnding = "%name% retired from %companyname%. Since then, no one has heard from him.";
		this.m.HiringCost = 3000;
		this.m.DailyCost = 50;
		this.m.Excluded = [
			"trait.dumb"
		];
		this.m.Names = [
			"Sun Wu",
			"Yuan Chonghuan",
			"Qi Jiguang",
			"Yue Fei",
			"Li Guang",
			"Han Xin",
			"Xiang Yu",
			"Sun Bin",
			"Yi Shin",
			"Wu Qi",
			"Han Xin",
			"Dong Zhuo",
			"Lu Bu",
			"Yuan Shao",
			"Cao Cao",
			"Dian Wei",
			"Xu Zhu",
			"Xiahou Dun",
			"Jia Xu",
			"Guo Jia",
			"Sun Ce",
			"Zhou Yu",
			"Taishi Ci",
			"Gan Ning",
			"Liu Bei",
			"Zhuge Liang",
			"Ma Chao",
			"Guan Yu",
			"Zhang Fei",
			"Zhang Fei",
			"Chen"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.Zombie;
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

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		//this.m.GoodEnding = "A woman like %name% would always find a way. The hedge knight eventually, if not inevitably, left the company and set out on her own. Unlike many other comrades, she did not spend her crowns on land or ladders with which to climb the noble life. Instead, she bought herself the finest war horses and the talents of armorers. The behemoth of a woman rode from one jousting tournament to the next, winning them all with ease. She\'s still at it to this day, and you think she won\'t stop until she\'s dead. The hedge knight simply knows no other life.";
		//this.m.BadEnding = "%name% the hedge knight eventually left the company. She traveled the lands, returning to her favorite past time of jousting, which was really a cover for her real favorite past time of lancing men off horses in a shower of splinters and glory. At some point, she was ordered to \'throw\' a match against a pitiful and gangly prince to earn the nobleman some prestige. Instead, the hedge knight drove her lance through the man\'s skull. Furious, the lord of the land ordered the hedge knight killed. They say over a hundred soldiers took to her home and only half returned alive.";
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
				text = "When using Dagger/Spear/Flail: [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee skill"
			}
		];
	}

	function onBuildDescription()
	{
		return "%name% is Wu Lin, an outlaw from the Eastern Empire. He instills fear in his enemies with his quick and nimble movements.";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				5
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				18,
				18
			],
			MeleeDefense = [
				1,
				1
			],
			RangedDefense = [
				1,
				1
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
		local xhead = actor.getSprite("head");
		local xbody = actor.getSprite("body");
		local xhair = actor.getSprite("hair");
		local xbeard = actor.getSprite("beard");
		local xtattoo_head = actor.getSprite("tattoo_head");
		
		local hair_type = [
			"hair_black_8010",
			"hair_black_8011",
			"hair_black_8012",
			"hair_black_8013",
			"hair_black_19"
		];
		hair_type = hair_type[this.Math.rand(0, hair_type.len() - 1)]
		local beard_type = [
			"xxbeard_black_1000",
			"beard_black_05",
			"beard_black_06"
			"beard_black_07",
			"beard_black_08",
			"beard_black_09"
		];
			
		if (!this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			beard_type = beard_type[this.Math.rand(0, beard_type.len() - 1)]
			local pp = this.Math.rand(1, 3);
			if (pp != 1)
			{
				xbeard.setBrush(beard_type);
			}
			xhair.setBrush(hair_type);
			xhead.Color = this.createColor("#d6b074");
			xbody.Color = xhead.Color;
		}
		else
		{
			xhair.setBrush(hair_type);
			xhead.Color = this.createColor("#e6cfab");
			xbody.Color = xhead.Color;
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		
		local twoHandedWeapons =
		[
			//"scripts/items/weapons/oriental/two_handed_scimitar",
			"scripts/items/weapons/xxruneblade",
			"scripts/items/weapons/xxmeteor",
			"scripts/items/weapons/xxkatar",
			//"scripts/items/weapons/legend_staff",
			"scripts/items/weapons/legend_tipstaff",
			//"scripts/items/weapons/oriental/two_handed_saif"
		];
		
		local oneHandedWeapons =
		[
			"scripts/items/weapons/xxringblade",
			"scripts/items/weapons/legend_battle_glaive",
			"scripts/items/weapons/ancient/ancient_sword"
		];

		local equipmentType = 0;
		local rand = this.Math.rand(0, 100);
		if(rand < 50)
			equipmentType = 0;
		else if(rand < 75)
			equipmentType = 1;
		else
			equipmentType = 2;
			
		if(equipmentType == 0)
		{
			items.equip(this.new(twoHandedWeapons[this.Math.rand(0, twoHandedWeapons.len() - 1)]));
		}
		else if(equipmentType == 1)
		{
			items.equip(this.new(oneHandedWeapons[this.Math.rand(0, oneHandedWeapons.len() - 1)]));
			items.equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
		}
		else if(equipmentType == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/composite_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
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

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			local xss = actor.getSkills();
			if (xss.hasSkill("actives.stab") || 
			xss.hasSkill("actives.thrust") || xss.hasSkill("actives.prong") || 
			xss.hasSkill("actives.flail") || xss.hasSkill("actives.cascade") || xss.hasSkill("actives.pound"))
			{
				_properties.MeleeSkill += 10;
			}
		}
	}

});

