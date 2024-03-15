this.fb_darkelf_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.fb_darkelf";
		this.m.Name = "Dark Elf";
		this.m.Icon = "ui/xxelf_icon.png";
		this.m.BackgroundDescription = "Elves are an ancient race who claim ancestral territories in the forests from before any human can remember and are so far denied their coveted Elven Kingdom. While their foolish kin struggle as their race goes exinct, dark elves have found new power by turning their back on the elven gods and embracing Davkul. This move might seem desperate, but has awarded the dark elves strength and ruthlessness beyond measure.";
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
			return "{Hidden behind hulking and horrific armor, %name%\'s face has surprisingly fair features even if she has the complexion of a cadaver. | %name%, clad in the signature dark elf armor is something out of a nightmare. She is feared and reviled all the same. | As a ghastly voice booms inside %name%\'s helmet, you become unsure if there is even someone alive inside. | %name% has unmistakable elven features, but she looks much paler than her kin. } {Through dark rituals to her new god this elf has attained great power, some even say she has become impossible to defeat in single combat. | This elf followed years of warring against humans with years of ritual slaughter to attain great prowess and skill in battle. | The unnerving confidence with which she speaks makes it certain that there is little on the battlefield to match her strength. | You can tell this knife ear glides through battlefields like a venomous snake. | Very secretive about her fighting techniques, the elf has done unspeakable things to become certain death to her enemies. } {You are unsure if %name% will bring death to your enemies or herald the end of the world, but you are glad she fights for your coin and you're on the same side of the battlefield. | For %name% the elven ideals are forever doomed, so she will sacrifice to Davkul until there are none left. | The devotion with which %name% once fought for the elven cause is now replaced with cold sadism for her future offerings to Davkul.}";
		}
		else
		{
			return "{Hidden behind hulking and horrific armor, %name%\'s face has surprisingly fair features even if he has the complexion of a cadaver. | %name%, clad in the signature dark elf armor is something out of a nightmare. He is feared and reviled all the same. | As a ghastly voice booms inside %name%\'s helmet, you become unsure if there is even someone alive inside. | %name% has unmistakable elven features, but he looks much paler than his kin. } {Through dark rituals to his new god this elf has attained great power, some even say he has become impossible to defeat in single combat. | This elf followed years of warring against humans with years of ritual slaughter to attain great prowess and skill in battle. | The unnerving confidence with which he speaks makes it certain that there is little on the battlefield to match his strength. | You can tell this knife ear glides through battlefields like a venomous snake. | Very secretive about his fighting techniques, the elf has done unspeakable things to become certain death to his enemies. } {You are unsure if %name% will bring death to your enemies or herald the end of the world, but you are glad he fights for your coin and you're on the same side of the battlefield. | For %name% the elven ideals are forever doomed, so he will sacrifice to Davkul until there are none left. | The devotion with which %name% once fought for the elven cause is now replaced with cold sadism for his future offerings to Davkul.}";
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
		local actor = this.getContainer().getActor();
		local items = actor.getItems();
		if (this.Math.rand(1, 2) == 1)
		{
			if (this.Math.rand(1, 2) == 2)
			{
				items.equip(this.new("scripts/items/armor/named/lindwurm_armor"));
				actor.getSprite("surcoat").setBrush("bust_body_noble_08");
			}
			else
			{
				local itt = this.new("scripts/items/armor/named/named_sellswords_armor");
				itt.setVariant(82);
				items.equip(itt);
			}
		}
		else
		{
			items.equip(this.new("scripts/items/armor/named/named_sellswords_armor"));
			if (this.Math.rand(1, 3) == 2)
			{
				actor.getSprite("surcoat").setBrush("bust_body_noble_0" + this.Math.rand(7, 8));
			}
		}
	}

});

