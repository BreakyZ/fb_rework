this.xxelf_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.xxelf";
		this.m.Name = "Elf";
		this.m.Icon = "ui/xxelf_icon.png";
		this.m.BackgroundDescription = "Elves are very long lived humanoids with a beautiful appearance and pointed ears, also famous for their dexterity and amazing shooting and archery skills. They have been steadily decreasing in numbers because of their lower fertility rate compared to humans. Many of them choose to live in hidden covenants deep in the woods, or in human cities where they are known as urban elves.";
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
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the elf eventually saw fit to leave it all behind. He returned to the forests, finding a place among his own kind. He rarely showed the grim reality of hunting humans, but you have to imagine he\'d just rather stop doing it. As far as you know, he\'s doing well for himself these days.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the elf departed from the company and returned to the forest. Unfortunately, his people were not ready to welcome him back. He left to find his own place to settle down. He has not been seen since.";
	}
	
	function onBuildDescription()
	{
		if (!this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{His twin sister was his closest ally, they learned the bow together. | Born in the forests near of %randomtown%, %name% has spent much of his life defending the forests from the advance of civilization. | %name% lost his sister in a battle with men. He missed the shot on the one who felled her. Killing men has become the fuel for his fire. | Early in his life, %name% was one with the forests. When the men of the nearby village threatened the trees he took up arms to defend them.} {After the death of his sister %name% left the forest to find more men to kill. | The elf hid the thought well, but for the longest time he wondered what it would be like to hunt the ultimate game: man. | Sadly, the loss of his village to a local lords army led %name% to find another place to exist in the world | His desperation for a new life is understandable. | When he discovered that he could get payed for killing men, he followed the call of mercenary work. | War drove his people to retreat to the Old Lands, %name% decided to stay. Now he seeks a place to play his deadly symphony.} {Any outfit could use a deadeye such as this man. | Though not certain of his allegiance, %name% is a professional bowman nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another he knocks it out. Impressive. | %name% looks like he has something to prove - just make sure he does it against your enemies. When you tried to train him with a sword he refused, he maintains that no one can get in melee range with him anyway. | The elf wields his bow like another limb, and shoots his arrows like a preacher does words.}";
		}
		else
		{
			return "{Her twin sister was his closest ally, they learned the bow together. | Born in the forests near of %randomtown%, %name% has spent much of his life defending the forests from the advance of civilization. | %name% lost her sister in a battle with men. She missed the shot on the one who felled her. Killing men has become the fuel for her fire. | Early in her life, %name% was one with the forests. When the men of the nearby village threatened the trees she took up arms to defend them.} {After the death of her sister %name% left the forest to find more men to kill. | The elf hid the thought well, but for the longest time she wondered what it would be like to hunt the ultimate game: man. | Sadly, the loss of her village to a local lords army led %name% to find another place to exist in the world | Her desperation for a new life is understandable. | When she discovered that she could get payed for killing men, she followed the call of mercenary work. | War drove his people to retreat to the Old Lands, %name% decided to stay. Now he seeks a place to play his deadly symphony.} {Any outfit could use a deadeye such as this woman. | Though not certain of her allegiance, %name% is a professional archer nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another she knocks it out. Impressive. | %name% looks like she has something to prove - just make sure she does it against your enemies. When you tried to train her with a sword she refused, he maintains that no one can get in melee range with her anyway. | The elf wields her bow like another limb, and shoots her arrows like a preacher does words.}";
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

