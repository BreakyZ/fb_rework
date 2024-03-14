this.fb_forestelf_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.fb_forestelf";
		this.m.Name = "Forest Elf";
		this.m.Icon = "ui/xxelf_icon.png";
		this.m.BackgroundDescription = "Elves are an ancient race who claim ancestral territories in the forests from before any human can remember and are so far denied their coveted Elven Kingdom. While their brethren are enjoying what little the human cities have to offer, forest elves fight directly against the humans from small forest camps, raiding caravans and taking prisoners for ransom. The once proud race\'s numbers dwindle as their longevity and low birthrates can\'t match the humans. Despite being deadly fighters the forest elves live much like brigands and enter mercenary employment very rarely.";
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the elf eventually saw fit to leave it all behind. He returned to the forests, finding a place among his own kind. He rarely showed the grim reality of hunting humans, but you have to imagine he\'d just rather stop doing it. As far as you know, he\'s doing well for himself these days.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the elf departed from the company and returned to the forest. Unfortunately, his people were not ready to welcome him back. He left to find his own place to settle down. He has not been seen since.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.dumb",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.brute",
			"trait.short_sighted",
			"trait.fat",
			"trait.clumsy",
			"trait.gluttonous",
			"trait.asthmatic",
			"trait.ailing",
			"trait.craven",
			"trait.dastard",
			"trait.drunkard"
		];
		this.m.Titles = [
			"the Deerhunter",
			"Woodstalker",
			"the Woodsman",
			"the Hunter",
			"True-Shot",
			"One Shot",
			"Eagle Eye"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BeardChance = 0;
		this.m.Level = this.Math.rand(1, 2);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[3];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Terrain = [
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.05,
			0.05,
			0.05,
			0.05,
			0.0,
			0.0,
			0.0,
			0.01,
			0.01,
			0.01,
			0.0,
			0.0,
			0.0,
			0.0
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.BowTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.DirewolfTree,
				this.Const.Perks.SpiderTree,
				this.Const.Perks.SchratTree
			],
			Class = [],
			Magic = []
		};
		
		local maleNames =
		[
			"Aeron",
			"Afon",
			"Aled",
			"Alun",
			"Alwyn",
			"Aneirin",
			"Arwel",
			"Arwyn",
			"Bedwyr",
			"Berwyn",
			"Bleddyn",
			"Brynmor",
			"Bron",
			"Cadell",
			"Cadeyrn",
			"Cadfael",
			"Cadwalader",
			"Cadwgan",
			"Caerwyn",
			"Caradoc",
			"Carwyn",
			"Cefin",
			"Cledwyn",
			"Cynfelyn",
			"Cystennin",
			"Dafydd",
			"Delwyn",
			"Deryn",
			"Dilwyn",
			"Drystan",
			"Dylan",
			"Eifion",
			"Eirwyn",
			"Ellis",
			"Emlyn",
			"Emrys",
			"Emyr",
			"Eurig",
			"Evan",
			"Folant",
			"Gareth",
			"Geraint",
			"Gerallt",
			"Gethin",
			"Glendower",
			"Glyn",
			"Griffith",
			"Gronw",
			"Gwallter",
			"Gwilym",
			"Gwydion",
			"Gwyn",
			"Gwynedd",
			"Gwynfor",
			"Heddwyn",
			"Hefin",
			"Huw",
			"Hywel",
			"Iago",
			"Idris",
			"Idwal",
			"Iefan",
			"Iestyn",
			"Ieuan",
			"Ifan",
			"Ilar",
			"Illtyd",
			"Ioan",
			"Iorwerth",
			"Islwyn",
			"Ithel",
			"Ivor",
			"Iwan",
			"Lleu",
			"Llywelyn",
			"Luc",
			"Madoc",
			"Maldwyn",
			"Martyn",
			"Maxen",
			"Meical",
			"Meirion",
			"Merfyn",
			"Meurig",
			"Morgan",
			"Myrddin",
			"Neifion",
			"Ofydd",
			"Owain",
			"Padrig",
			"Pedr",
			"Pryce",
			"Pryderi",
			"Reece",
			"Rheinallt",
			"Rhisiart",
			"Rhodri",
			"Rhydderch",
			"Rhys",
			"Roderick",
			"Talfryn",
			"Taliesin",
			"Tegid",
			"Tudwal",
			"Vaughan",
			"Wynn",
		];

		//this.m.Names = this.Const.Strings.AncientDeadNames;
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
			"Aerona",
			"Aeronwen",
			"Aeronwy"
			"Alis",
			"Angharad",
			"Anwen"
			"Arianwen"
			"Bethan",
			"Betrys",
			"Blodeuyn",
			"Blodwen",
			"Branwen",
			"Briallen",
			"Bronwen",
			"Bryn",
			"Cadi",
			"Carys",
			"Catrin",
			"Ceinwen",
			"Celyn",
			"Ceri",
			"Ceridwen",
			"Cerys",
			"Cristyn",
			"Delyth",
			"Dilwen",
			"Dilys",
			"Efa",
			"Eilwen",
			"Eira",
			"Eirlys",
			"Eirwen",
			"Elain",
			"Elen",
			"Eleri",
			"Elin",
			"Eluned",
			"Enid",
			"Esyllt",
			"Eurwen",
			"Ffion",
			"Fflur",
			"Ffraid",
			"Gaenor",
			"Gladys",
			"Glenice",
			"Glenys",
			"Gwawr",
			"Gwen",
			"Gwenda",
			"Gwendolen",
			"Gwenfrewi",
			"Gwenllian",
			"Gwenneth",
			"Gwyneira",
			"Gwyneth",
			"Haf",
			"Hefina",
			"Heledd",
			"Heulwen",
			"Lleucu",
			"Llewella",
			"Lowri",
			"Luned",
			"Mair",
			"Mairwen",
			"Mallt",
			"Mari",
			"Megan",
			"Meinir",
			"Meinwen",
			"Meiriona",
			"Meredith",
			"Mererid",
			"Morwen",
			"Myfanwy",
			"Nerys",
			"Olwen",
			"Owena",
			"Rhiannon",
			"Rhonwen",
			"Rhosyn",
			"Sawyl",
			"Seren",
			"Siwan",
			"Tegan",
			"Tegwen",
			"Tesni",
			"Tydfil",
			"Winifred",
		];
		
		this.m.Names = femaleNames;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the elf eventually saw fit to leave it all behind. He returned to the forests, finding a place among her own kind. She rarely showed the grim reality of hunting humans, but you have to imagine she\'d just rather stop doing it. As far as you know, she\'s doing well for herself these days.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the elf departed from the company and returned to the forest. Unfortunately, her people were not ready to welcome her back. She left to find her own place to settle down. She has not been seen since.";
	}
	
	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name%\'s beautiful features cannot be hidden even by the dirt and scratches on her face. | %name% is a graceful figure with long sharp ears that speaks to you like you\'re a child. | As %name% speaks with great disdain, her knife ears twitch and you wonder if she\'ll ever follow your orders. | If looks could kill, %name% wouldn't hessitate to take your life with inhuman grace.} {The elf has spent many years being a Gwalch only to be betrayed by human lords. | This elf walks with such grace and ease in the forests, that you look down to check if there aren\'t cobblestone roads under her feet. | The condescending and vile tongue with which %name% speaks to people makes it hard to employ this elf for more than single battles. | You can tell this knife ear glides through battlefields like a venomous snake. | The elf is very secretive about her martial training and honestly a mere mortal couldn\'t grasp it within their lifespan.} {While his goals are not known, %name% will fight for coin like every other person who she looks down on. | Aiming to carry the ideals of the Gwalch forward, %name% reluctantly enters contracts with men who she might have killed on sight in the past. | Seeking to restore the Elven Kingdom by any means necessary, %name% has sold her skills to the highest bidder.}";
		}
		else
		{
			return "{%name%\'s beautiful features cannot be hidden even by the dirt and scratches on his face. | %name% is a graceful figure with long sharp ears that speaks to you like you\'re a child. | As %name% speaks with great disdain, his knife ears twitch and you wonder if he\'ll ever follow your orders. | If looks could kill, %name% wouldn't hessitate to take your life with inhuman grace.} {The elf has spent many years being a Gwalch only to be betrayed by human lords. | This elf walks with such grace and ease in the forests, that you look down to check if there aren\'t cobblestone roads under his feet. | The condescending and vile tongue with which %name% speaks to people makes it hard to employ this elf for more than single battles. | You can tell this knife ear glides through battlefields like a venomous snake. | The elf is very secretive about his martial training and honestly a mere mortal couldn\'t grasp it within their lifespan.} {While his goals are not known, %name% will fight for coin like every other person who he looks down on. | Aiming to carry the ideals of the Gwalch forward, %name% reluctantly enters contracts with men who he might have killed on sight in the past. | Seeking to restore the Elven Kingdom by any means necessary, %name% has sold his skills to the highest bidder.}";
		}
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
			local pp = this.Math.rand(0, 3)
			if (pp == 1)
			{
				tattoo_body.setBrush("warpaint_01_" + xbody.getBrush().Name);
				tattoo_body.Visible = true;
				tattoo_head.setBrush("warpaint_01_head");
				tattoo_head.Visible = true;
			}
			else
			if (pp == 2)
			{
				tattoo_body.setBrush("tattoo_02_" + xbody.getBrush().Name);
				tattoo_body.Visible = true;
				tattoo_head.setBrush("tattoo_02_head");
				tattoo_head.Visible = true;
			}
			if (this.Math.rand(1, 2) == 1)
			{
				xhair.setBrush("hair_elf_0" + this.Math.rand(1, 6));
			}
			else
			{
				xhair.setBrush("hair_elf_0" + this.Math.rand(1, 3));
			}
		}
		else
		{
			xbody.setBrush("bust_naked_body_78" + this.Math.rand(69, 70));
			xhead.setBrush("bust_head_787" + this.Math.rand(0, 1));
			xhair.setBrush("hair_elf_0" + this.Math.rand(1, 6));
		}
	}
	
	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				5
			],
			Stamina = [
				7,
				5
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				30,
				25
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				3
			],
			Initiative = [
				5,
				10
			]
		};
		return c;
	}
	
	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		if (this.Math.rand(0, 1) == 0)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
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

});

