this.xxcustom_hero_intro_event <- this.inherit("scripts/events/event", {
	m = {
		Bought = 0
	},
	function create()
	{
		this.m.ID = "event.xxcustom_hero_intro_event";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "apage1",
			Text = "[img]gfx/ui/events/event_62.png[/img]{The world is a dangerous place. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid. \n\n[color=#56e64c]Choose your avatar character[/color]}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Male Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 1;
						return "GG";
					}
				},
				{
					Text = "Female Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 2;
						return "GG";
					}
				},
				{
					Text = "Orc Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 3;
						return "GG";
					}
				},
				{
					Text = "Goblin Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 4;
						return "GG";
					}
				},
				{
					Text = "Undead Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 5;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage2";
					}

				}
			],
			function start( _event )
			{
			}
		});

		this.m.Screens.push({
			ID = "apage2",
			Text = "[img]gfx/ui/events/event_62.png[/img]{The world is a dangerous place. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid. \n\n[color=#56e64c]Choose your avatar character[/color]}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Felinid Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 6;
						return "GG";
					}
				},
				{
					Text = "Elf Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 7;
						return "GG";
					}
				},
				{
					Text = "Random Adventurer + Skill Book",
					function getResult( _event )
					{
						_event.m.Bought = 8;
						return "GG";
					}
				},
				{
					Text = "Wizard",
					function getResult( _event )
					{
						_event.m.Bought = 9;
						return "GG";
					}
				},
				{
					Text = "Fightmaster",
					function getResult( _event )
					{
						_event.m.Bought = 10;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage3";
					}

				}
			],
			function start( _event )
			{
			}
		});

		this.m.Screens.push({
			ID = "apage3",
			Text = "[img]gfx/ui/events/event_62.png[/img]{The world is a dangerous place. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid. \n\n[color=#56e64c]Choose your avatar character[/color]}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Spellsword",
					function getResult( _event )
					{
						_event.m.Bought = 11;
						return "GG";
					}
				},
				{
					Text = "Necromancer",
					function getResult( _event )
					{
						_event.m.Bought = 12;
						return "GG";
					}
				},
				{
					Text = "Elite Shooter",
					function getResult( _event )
					{
						_event.m.Bought = 13;
						return "GG";
					}
				},
				{
					Text = "Royalty(avatar) + Royal Guard",
					function getResult( _event )
					{
						_event.m.Bought = 14;
						return "GG";
					}
				},
				{
					Text = "Holy Knight(avatar) + 2 Templar",
					function getResult( _event )
					{
						_event.m.Bought = 15;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage4";
					}

				}
			],
			function start( _event )
			{
			}
		});

		this.m.Screens.push({
			ID = "apage4",
			Text = "[img]gfx/ui/events/event_62.png[/img]{The world is a dangerous place. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid. \n\n[color=#56e64c]Choose your avatar character[/color]}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "12 Adventurer of the same background",
					function getResult( _event )
					{
						return "bpage1";
					}
				},
				{
					Text = "Test (cheat)",
					function getResult( _event )
					{
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxcestus"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxcestusb"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxarcanespear"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxbamboospear"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxkusarigama"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxrifle"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxdeadbook"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxringblade"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxnodachi"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxruneblade"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxkatar"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxdragonsw"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxmeteor"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxmstaff"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxlefts"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxshuriken"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxheavylance"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/xxmagicstaff"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/legendary/obsidian_dagger"));
						this.World.Assets.getStash().add(this.new("scripts/items/shields/xxhorse_shield"));
						this.World.Assets.getStash().add(this.new("scripts/items/shields/xxheavyhorse_shield"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/named/xxcrosslance"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/named/xxorc_flail_two_handed"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/named/xxscythe"));
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/xxsilvertrophy"));
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/xxgoldtrophy"));
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/xxdefring"));
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/xxatkring"));
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/xxbloodring"));
						this.World.Assets.getStash().add(this.new("scripts/items/helmets/xxhat_hairband"));
						this.World.Assets.getStash().add(this.new("scripts/items/helmets/xxhat_hunshat"));
						this.World.Assets.getStash().add(this.new("scripts/items/helmets/xxhat_hunshelm"));
						this.World.Assets.getStash().add(this.new("scripts/items/helmets/xxhat_hwaranghat"));
						this.World.Assets.getStash().add(this.new("scripts/items/helmets/xxhat_kasa"));
						this.World.Assets.getStash().add(this.new("scripts/items/helmets/xxhat_samurai"));
						this.World.Assets.getStash().add(this.new("scripts/items/helmets/xxknighthelm"));
						this.World.Assets.getStash().add(this.new("scripts/items/armor/xxdress"));
						this.World.Assets.getStash().add(this.new("scripts/items/armor/xxmonkrobe"));
						this.World.Assets.getStash().add(this.new("scripts/items/armor/xxsamuraiarmor"));
						this.World.Assets.getStash().add(this.new("scripts/items/armor/xxwokoulightarmor"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_sp"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_sp"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_sp"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_sp"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_sp"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_se"));
						this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_se"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/named/named_goblin_pike"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/greenskins/orc_javelin"));
						this.World.Assets.getStash().add(this.new("scripts/items/weapons/lute"));
						local roster = this.World.getPlayerRoster();
						local xxlonexx;
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxherocrimson_background"
						]);
						xxlonexx.getSkills().removeByID("trait.survivor");
						xxlonexx.getSkills().removeByID("trait.greedy");
						xxlonexx.getSkills().removeByID("trait.loyal");
						xxlonexx.getSkills().removeByID("trait.disloyal");
						xxlonexx.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
						xxlonexx.setPlaceInFormation(4);
						xxlonexx.getFlags().set("IsPlayerCharacter", true);
						xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
						xxlonexx.m.PerkPoints = 1;
						xxlonexx.m.LevelUps = 1;
						xxlonexx.m.Level = 2;
						xxlonexx.getBaseProperties().Hitpoints += 1;
						xxlonexx.getBaseProperties().Bravery += 1;
						xxlonexx.getBaseProperties().Stamina += 1;
						xxlonexx.getBaseProperties().MeleeSkill += 1;
						xxlonexx.getBaseProperties().RangedSkill += 1;
						xxlonexx.getBaseProperties().MeleeDefense += 1;
						xxlonexx.getBaseProperties().RangedDefense += 1;
						xxlonexx.getBaseProperties().Initiative += 1;
						xxlonexx.m.Talents = [];
						xxlonexx.m.Attributes = [];
						local talents = xxlonexx.getTalents();
						talents.resize(this.Const.Attributes.COUNT, 0);
						talents[this.Const.Attributes.Hitpoints] = 3;
						talents[this.Const.Attributes.Bravery] = 3;
						talents[this.Const.Attributes.Fatigue] = 3;
						talents[this.Const.Attributes.MeleeSkill] = 3;
						talents[this.Const.Attributes.RangedSkill] = 3;
						talents[this.Const.Attributes.MeleeDefense] = 2;
						talents[this.Const.Attributes.RangedDefense] = 2;
						talents[this.Const.Attributes.Initiative] = 3;
						xxlonexx.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);

						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxherohighelf_background"
						]);
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxheroroyal_background"
						]);

						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxhero_male_background"
						]);
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_firebomb_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_waterbomb_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_rain_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_snow_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_pull_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_pull2_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_snake_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_demon_skill"));

						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxhero_female_background"
						]);
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_beartrap_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_drainblood_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_earthquake_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_electric_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_fonature_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_puri_skill"));
						xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_warcrime_skill"));

						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxi_female_background"
						]);
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxhero_goblin_background"
						]);
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxhalforc_background"
						]);
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxhero_elf_background"
						]);
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxfelinid_background"
						]);
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxhero_undead_background"
						]);
						xxlonexx = roster.create("scripts/entity/tactical/player");
						xxlonexx.setStartValuesEx([
							"xxhero_male_background"
						]);

						local xxbrothers = this.World.getPlayerRoster().getAll();
						foreach(zxz in xxbrothers)
						{
							zxz.m.HireTime = this.Time.getVirtualTimeF();
							if (zxz.getBackground().getID() == "background.beggar")
							{
								zxz.setName("DummyStarter");
								if (this.Const.DLC.Desert)
								{
									zxz.getSkills().onDeath(this.Const.FatalityType.None);
								}
								this.World.getPlayerRoster().remove(zxz);
								break;
							}
						}
						return 0;
					}
				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage1";
					}

				}
			],
			function start( _event )
			{
			}
		});

		this.m.Screens.push({
			ID = "GG",
			Text = "[img]gfx/ui/events/event_74.png[/img]{Think carefully and act wisely to survive in this wild and dangerous world. Good luck. \n\n[color=#56e64c]The game is over when the avatar character dies.[/color]}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Start",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getPlayerRoster();
				local xxlonexx = roster.create("scripts/entity/tactical/player");
				local hero_type = [
					"xxhero_male_background",
					"xxhero_female_background",
					"xxhero_elf_background",
					"xxhero_undead_background",
					"xxfelinid_background",
					"xxhalforc_background",
					"xxhero_goblin_background"
				];
				if (_event.m.Bought == 1)
				{
					xxlonexx.setStartValuesEx([
						"xxhero_male_background"
					]);
				}
				else if (_event.m.Bought == 2)
				{
					xxlonexx.setStartValuesEx([
						"xxhero_female_background"
					]);
				}
				else if (_event.m.Bought == 3)
				{
					xxlonexx.setStartValuesEx([
						"xxhalforc_background"
					]);
				}
				else if (_event.m.Bought == 4)
				{
					xxlonexx.setStartValuesEx([
						"xxhero_goblin_background"
					]);
				}
				else if (_event.m.Bought == 5)
				{
					xxlonexx.setStartValuesEx([
						"xxhero_undead_background"
					]);
				}
				else if (_event.m.Bought == 6)
				{
					xxlonexx.setStartValuesEx([
						"xxfelinid_background"
					]);
				}
				else if (_event.m.Bought == 7)
				{
					xxlonexx.setStartValuesEx([
						"xxhero_elf_background"
					]);
				}
				else if (_event.m.Bought == 9)
				{
					xxlonexx.setStartValuesEx([
						hero_type[this.Math.rand(0, hero_type.len() - 1)]
					]);
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_fireball_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_frostblast_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_manaforce_skill"));
					xxlonexx.getBaseProperties().RangedSkill += 10;
					local items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					items.equip(this.new("scripts/items/armor/wizard_robe"));
					items.equip(this.new("scripts/items/helmets/wizard_hat"));
					items.equip(this.new("scripts/items/weapons/xxmagicstaff"));
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Wizard");
					xxlonexx.getBackground().m.RawDescription = "The mystical being known as %name% the Wizard wields powers beyond mortal comprehension, casting spells that leave even the strongest adversaries trembling.";
					xxlonexx.getBackground().buildDescription(true);
				}
				else if (_event.m.Bought == 10)
				{
					xxlonexx.setStartValuesEx([
						hero_type[this.Math.rand(0, hero_type.len() - 1)]
					]);
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_strike_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_chokentoss_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sbp_selfcare_skill"));
					xxlonexx.getBaseProperties().Hitpoints += 10;
					local items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Fightmaster");
					xxlonexx.getBackground().m.RawDescription = "As swift as the wind and fierce as a raging inferno, %name% the Fightmaster is a martial artist of unparalleled skill and deadly precision, striking fear into the hearts of all who stand in their path.";
					xxlonexx.getBackground().buildDescription(true);
				}
				else if (_event.m.Bought == 11)
				{
					xxlonexx.setStartValuesEx([
						hero_type[this.Math.rand(0, hero_type.len() - 1)]
					]);
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_whirlwind_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_shockwave_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sbp_challenger_skill"));
					local items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					items.equip(this.new("scripts/items/weapons/arming_sword"));
					items.equip(this.new("scripts/items/armor/decayed_reinforced_mail_hauberk"));
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Spellsword");
					xxlonexx.getBackground().m.RawDescription = "Striking fear into their enemies with every flick of their enchanted sword, %name% the Spellsword is a warrior-mage of unparalleled skill and deadly grace";
					xxlonexx.getBackground().buildDescription(true);
				}
				else if (_event.m.Bought == 12)
				{
					xxlonexx.setStartValuesEx([
						hero_type[this.Math.rand(0, hero_type.len() - 1)]
					]);
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_sumfiend_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_sumskel_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sbp_lifestealer_skill"));
					local items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					items.equip(this.new("scripts/items/weapons/arming_sword"));
					items.equip(this.new("scripts/items/helmets/dark_cowl"));
					items.equip(this.new("scripts/items/armor/ragged_dark_surcoat"));
					if (this.Math.rand(0, 1) == 1)
					{
						local hat = this.new("scripts/items/helmets/hood");
						hat.setVariant(63);
						items.equip(hat);
						items.equip(this.new("scripts/items/armor/thick_dark_tunic"));
					}
					else
					{
						items.equip(this.new("scripts/items/helmets/dark_cowl"));
						items.equip(this.new("scripts/items/armor/ragged_dark_surcoat"));
					}
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Necromancer");
					xxlonexx.getBackground().m.RawDescription = "%name% is a necromancer obsessed with forbidden knowledge and uses evil and unethical black magic.";
					xxlonexx.getBackground().buildDescription(true);
				}
				else if (_event.m.Bought == 13)
				{
					xxlonexx.setStartValuesEx([
						hero_type[this.Math.rand(0, hero_type.len() - 1)]
					]);
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_cqcthrowing_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_multishot_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_penshot_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_zeroshot_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sbp_hunting_skill"));
					xxlonexx.getBaseProperties().RangedSkill += 10;
					xxlonexx.getBaseProperties().Initiative += 10;
					local items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					items.equip(this.new("scripts/items/weapons/hunting_bow"));
					items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
					local hat = this.new("scripts/items/helmets/hood");
					hat.setVariant(36);
					items.equip(hat);
					items.equip(this.new("scripts/items/armor/thick_tunic"));
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Elite Shooter");
					xxlonexx.getBackground().m.RawDescription = "%name% is a genius who is skilled at using any ranged weapon and possesses outstanding skills.";
					xxlonexx.getBackground().buildDescription(true);
				}
				else if (_event.m.Bought == 14)
				{
					xxlonexx.setStartValuesEx([
						"squire_background"
					]);
					local talentss = xxlonexx.getTalents();
					talentss.resize(this.Const.Attributes.COUNT, 0);
					talentss[this.Const.Attributes.Hitpoints] = 3;
					talentss[this.Const.Attributes.Bravery] = 3;
					talentss[this.Const.Attributes.Fatigue] = 3;
					talentss[this.Const.Attributes.MeleeSkill] = 3;
					talentss[this.Const.Attributes.RangedSkill] = 3;
					talentss[this.Const.Attributes.MeleeDefense] = 3;
					talentss[this.Const.Attributes.RangedDefense] = 3;
					talentss[this.Const.Attributes.Initiative] = 3;
					local items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
					items.equip(this.new("scripts/items/armor/mail_hauberk"));
					items.equip(this.new("scripts/items/weapons/shortsword"));
					xxlonexx.setTitle("Royal Guard");
					xxlonexx.getBackground().m.RawDescription = "As a seasoned and highly-trained Royal Guard, %name% has devoted his life to safeguarding the royal family, carrying out his duties with poise and unwavering loyalty.";
					xxlonexx.getBackground().buildDescription(true);
					xxlonexx.setPlaceInFormation(5);
					xxlonexx.m.HireTime = this.Time.getVirtualTimeF();

					xxlonexx = roster.create("scripts/entity/tactical/player")
					xxlonexx.setStartValuesEx([
						"xxheroroyal_background"
					]);
				}
				else if (_event.m.Bought == 15)
				{
					xxlonexx.setStartValuesEx([
						"monk_background"
					]);
					local talentss = xxlonexx.getTalents();
					talentss.resize(this.Const.Attributes.COUNT, 0);
					talentss[this.Const.Attributes.Hitpoints] = 3;
					talentss[this.Const.Attributes.Bravery] = 3;
					talentss[this.Const.Attributes.Fatigue] = 3;
					talentss[this.Const.Attributes.MeleeSkill] = 3;
					talentss[this.Const.Attributes.RangedSkill] = 3;
					talentss[this.Const.Attributes.MeleeDefense] = 3;
					talentss[this.Const.Attributes.RangedDefense] = 3;
					talentss[this.Const.Attributes.Initiative] = 3;
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_pincer_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_holyspear_skill"));
					local items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
					items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
					items.equip(this.new("scripts/items/weapons/militia_spear"));
					items.equip(this.new("scripts/items/shields/wooden_shield_old"));
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Templar");
					xxlonexx.setPlaceInFormation(3);
					xxlonexx.m.HireTime = this.Time.getVirtualTimeF();

					xxlonexx = roster.create("scripts/entity/tactical/player")
					xxlonexx.setStartValuesEx([
						"monk_background"
					]);
					talentss = xxlonexx.getTalents();
					talentss.resize(this.Const.Attributes.COUNT, 0);
					talentss[this.Const.Attributes.Hitpoints] = 3;
					talentss[this.Const.Attributes.Bravery] = 3;
					talentss[this.Const.Attributes.Fatigue] = 3;
					talentss[this.Const.Attributes.MeleeSkill] = 3;
					talentss[this.Const.Attributes.RangedSkill] = 3;
					talentss[this.Const.Attributes.MeleeDefense] = 3;
					talentss[this.Const.Attributes.RangedDefense] = 3;
					talentss[this.Const.Attributes.Initiative] = 3;
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_pincer_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_holyspear_skill"));
					items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.equip(this.new("scripts/items/armor/patched_mail_shirt"));
					items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
					items.equip(this.new("scripts/items/weapons/militia_spear"));
					items.equip(this.new("scripts/items/shields/wooden_shield_old"));
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Templar");
					xxlonexx.setPlaceInFormation(5);
					xxlonexx.m.HireTime = this.Time.getVirtualTimeF();

					xxlonexx = roster.create("scripts/entity/tactical/player")
					xxlonexx.setStartValuesEx([
						"monk_background"
					]);
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_pincer_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_holyspear_skill"));
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/sb_command_skill"));
					items = xxlonexx.getItems();
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
					items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
					items.equip(this.new("scripts/items/helmets/mail_coif"));
					items.equip(this.new("scripts/items/weapons/militia_spear"));
					items.equip(this.new("scripts/items/shields/wooden_shield"));
					xxlonexx.getFlags().increment("xxSkillBookTraining", 9999989);
					xxlonexx.setTitle("Holy Knight");
					xxlonexx.getBackground().m.RawDescription = "True to their sacred oath, %name% the Holy Knight charges forward with a noble purpose, ready to face any foe that threatens to snuff out the justice.";
					xxlonexx.getBackground().buildDescription(true);
				}
				else
				{
					xxlonexx.setStartValuesEx([
						hero_type[this.Math.rand(0, hero_type.len() - 1)]
					]);
				}
				xxlonexx.getSkills().removeByID("trait.survivor");
				xxlonexx.getSkills().removeByID("trait.greedy");
				xxlonexx.getSkills().removeByID("trait.loyal");
				xxlonexx.getSkills().removeByID("trait.disloyal");
				xxlonexx.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
				xxlonexx.setPlaceInFormation(4);
				xxlonexx.getFlags().set("IsPlayerCharacter", true);
				xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
				xxlonexx.m.PerkPoints = 1;
				xxlonexx.m.LevelUps = 1;
				xxlonexx.m.Level = 2;
				xxlonexx.getBaseProperties().MeleeDefense -= 1;
				xxlonexx.m.Talents = [];
				xxlonexx.m.Attributes = [];
				local talents = xxlonexx.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);
				talents[this.Const.Attributes.Hitpoints] = 3;
				talents[this.Const.Attributes.Bravery] = 3;
				talents[this.Const.Attributes.Fatigue] = 3;
				talents[this.Const.Attributes.MeleeSkill] = 3;
				talents[this.Const.Attributes.RangedSkill] = 3;
				talents[this.Const.Attributes.MeleeDefense] = 3;
				talents[this.Const.Attributes.RangedDefense] = 3;
				talents[this.Const.Attributes.Initiative] = 3;
				xxlonexx.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
				local xxbrothers = this.World.getPlayerRoster().getAll();
				foreach(zxz in xxbrothers)
				{
					if (zxz.getBackground().getID() == "background.beggar")
					{
						zxz.setName("DummyStarter");
						if (this.Const.DLC.Desert)
						{
							zxz.getSkills().onDeath(this.Const.FatalityType.None);
						}
						this.World.getPlayerRoster().remove(zxz);
						break;
					}
				}
				if (_event.m.Bought <= 8)
				{
					this.World.Assets.getStash().add(this.new("scripts/items/misc/xxsbook_se"));
				}
				return 0;
			}
		});

		this.m.Screens.push({
			ID = "bpage1",
			Text = "[img]gfx/ui/events/event_78.png[/img]{The world is a dangerous place. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid. \n\n[color=#56e64c]Choose a background for your mercenaries[/color]}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Male",
					function getResult( _event )
					{
						_event.m.Bought = 1;
						return "GX";
					}
				},
				{
					Text = "Female",
					function getResult( _event )
					{
						_event.m.Bought = 2;
						return "GX";
					}
				},
				{
					Text = "Orc",
					function getResult( _event )
					{
						_event.m.Bought = 3;
						return "GX";
					}
				},
				{
					Text = "Goblin",
					function getResult( _event )
					{
						_event.m.Bought = 4;
						return "GX";
					}
				},
				{
					Text = "Undead",
					function getResult( _event )
					{
						_event.m.Bought = 5;
						return "GX";
					}
				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "bpage2";
					}

				}
			],
			function start( _event )
			{
			}
		});

		this.m.Screens.push({
			ID = "bpage2",
			Text = "[img]gfx/ui/events/event_78.png[/img]{The world is a dangerous place. Robbers and pillagers lay in ambush by the roads, wild beasts roam the dark forests and orc tribes are restless beyond the boundaries of civilization. There are rumors even of dark magic being at work, the dead rising from their graves and walking again. There is plenty of opportunity to earn good money, whether by taking on contracts you can find in the villages and cities all over the land, or by venturing out on your own to explore and raid. \n\n[color=#56e64c]Choose a background for your mercenaries[/color]}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Felinid",
					function getResult( _event )
					{
						_event.m.Bought = 6;
						return "GX";
					}
				},
				{
					Text = "Elf",
					function getResult( _event )
					{
						_event.m.Bought = 7;
						return "GX";
					}
				},
				{
					Text = "Back to single avatar selection",
					function getResult( _event )
					{
						return "apage1";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "bpage1";
					}

				}
			],
			function start( _event )
			{
			}
		});

		this.m.Screens.push({
			ID = "GX",
			Text = "[img]gfx/ui/events/event_74.png[/img]{Think carefully and act wisely to survive in this wild and dangerous world. Good luck. \n\n[color=#56e64c]The game ends when all 12 starting members die.[/color]}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Start",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getPlayerRoster();
				local brotype;
				if (_event.m.Bought == 1)
				{
					brotype = "xxhero_male_background";
				}
				else if (_event.m.Bought == 2)
				{
					brotype = "xxhero_female_background";
				}
				else if (_event.m.Bought == 3)
				{
					brotype = "xxhalforc_background";
				}
				else if (_event.m.Bought == 4)
				{
					brotype = "xxhero_goblin_background";
				}
				else if (_event.m.Bought == 5)
				{
					brotype = "xxhero_undead_background";
				}
				else if (_event.m.Bought == 6)
				{
					brotype = "xxfelinid_background";
				}
				else
				{
					brotype = "xxhero_elf_background";
				}

				local xxbro;
				for( local i = 0; i < 12; i = ++i )
				{
					xxbro = roster.create("scripts/entity/tactical/player");
					xxbro.m.HireTime = this.Time.getVirtualTimeF();
					xxbro.setStartValuesEx([
						brotype
					]);
					xxbro.getSkills().removeByID("trait.greedy");
					xxbro.getSkills().removeByID("trait.loyal");
					xxbro.getSkills().removeByID("trait.disloyal");
					xxbro.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
					xxbro.getFlags().set("IsPlayerCharacter", true);
				}

				local xxbrothers = this.World.getPlayerRoster().getAll();
				foreach(zxz in xxbrothers)
				{
					if (zxz.getBackground().getID() == "background.beggar")
					{
						zxz.setName("DummyStarter");
						if (this.Const.DLC.Desert)
						{
							zxz.getSkills().onDeath(this.Const.FatalityType.None);
						}
						this.World.getPlayerRoster().remove(zxz);
						break;
					}
				}
				return 0;
			}
		});
	}

	function onDetermineStartScreen()
	{
		return "apage1";
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The " + this.World.Assets.getName();
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}
});

