this.xxinfidungeon_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.xxinfidungeon_enter_event";
		this.m.Cooldown = 0.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_132.png[/img]{This wicked place is a disaster brought on by the endless desires of sorcerers. This huge magical portal has become a hellish dungeon, pouring out an endless stream of malevolent beings.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Title = "As you approach...";
				local aaaxx = this.World.Statistics.getFlags().getAsInt("aaaxx");
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
				if (aaaxx <= 0)
				{
					this.Options.push({
						Text = "Keep moving.",
						function getResult( _event )
						{
							return "B";
						}
					});
				}
				else
				{
					this.Options.push({
						Text = "Keep moving.",
						function getResult( _event )
						{
							return "C";
						}
					});
				}
			}
		});

		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_87.png[/img]{%SPEECH_START%Damn I heard about this place. It is said to be the graveyard of adventurers.%SPEECH_OFF%%randombrother% says as he looks at the slain corpses. He spit and grinned.%SPEECH_ON%It seems like the perfect grave for fools drawn to gold. just like us%SPEECH_OFF%You nodded and smiled bitterly. Thousands of adventurers and villains have come to their end here, guided by rumors of shiny and valuable things. Your party searches the area to confirm the rumors.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Look around carefully.",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.World.Statistics.getFlags().increment("aaaxx", 1);
			}

		});

		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_29.png[/img]Many enemies are approaching your party. Prepare for endless battles against hostile and vicious hordes! \n\n[color=#56e64c]If you win the battle, the next battle difficulty will be even higher. \nChallenge your limits![/color]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Prepare for Battle!",
					function getResult( _event )
					{
						local aaaxx = this.World.Statistics.getFlags().getAsInt("aaaxx");
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						if (aaaxx > 1)
						{
							local brothers = this.World.getPlayerRoster().getAll();
							foreach( bro in brothers )
							{

								bro.getSkills().removeByID("effects.ai_ddebuff_skill");
								local debuff = this.new("scripts/skills/effects/ai_ddebuff_skill");								
								bro.getSkills().add(debuff);
								debuff.setTurns(aaaxx - 1);
							}
						}
						pp.CombatID = "Event";
						pp.Music = [
						"music/noble_01.ogg",
						"music/noble_02.ogg",
						"music/undead_01.ogg",
						"music/undead_02.ogg",
						"music/undead_03.ogg",
						"music/orcs_01.ogg",
						"music/orcs_02.ogg",
						"music/orcs_03.ogg",
						"music/goblins_01.ogg",
						"music/goblins_02.ogg",
						"music/beasts_01.ogg",
						"music/beasts_02.ogg",
						"music/civilians_01.ogg"
						];
						pp.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						local btile = [
							"tactical.autumn",
							"tactical.forest",
							"tactical.forest_leaves",
							"tactical.forest_snow",
							"tactical.hills",
							"tactical.hills_snow",
							"tactical.hills_steppe",
							"tactical.hills_tundra",
							"tactical.mountain",
							"tactical.plains",
							"tactical.quarry",
							"tactical.steppe",
							"tactical.snow",
							"tactical.swamp",
							"tactical.tundra"
						];
						if (this.Const.DLC.Desert)
						{
							btile.push("tactical.desert");
							btile.push("tactical.hills_desert");
							btile.push("tactical.oasis");
							btile.push("tactical.sinkhole");
						}			
						pp.TerrainTemplate = btile[this.Math.rand(0, btile.len() - 1)];
						local qq = this.Math.rand(0, 11);
						if (qq == 1)
						{
							pp.LocationTemplate.Template[0] = "tactical.graveyard";
						}
						else
						if (qq == 2)
						{
							pp.LocationTemplate.Template[0] = "tactical.ruins";
						}
						else
						if (qq == 3)
						{
							pp.LocationTemplate.Template[0] = "tactical.human_camp";
						}
						else
						if (qq == 4)
						{
							pp.LocationTemplate.Template[0] = "tactical.orc_camp";
						}
						else
						if (qq == 5)
						{
							pp.LocationTemplate.Template[0] = "tactical.goblin_camp";
						}
						else
						if (qq == 6)
						{
							pp.LocationTemplate.Template[0] = "tactical.barbarian_camp";
						}
						else
						if (qq == 7)
						{
							pp.TerrainTemplate = "tactical.steppe";
							pp.LocationTemplate.Template[0] = "tactical.southern_ruins";
						}
						else
						if (qq == 8)
						{
							pp.LocationTemplate.Template[0] = "tactical.xxtactical_ruintown";
						}
						else
						if (qq == 9)
						{
							pp.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
						}
						else
						if (qq == 10)
						{
							pp.TerrainTemplate = "tactical.quarry";
						}
						if (this.Math.rand(1, 3) == 2);
						{
							pp.BeforeDeploymentCallback = function ()
							{
								local size = this.Tactical.getMapSize();
								for( local x = 0; x < size.X; x = ++x )
								{
									for( local y = 0; y < size.Y; y = ++y )
									{
										local tile = this.Tactical.getTileSquare(x, y);
										tile.Level = this.Math.min(1, tile.Level);
									}
								}
							}
						}

						pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						pp.IsAutoAssigningBases = false;
						pp.IsLootingProhibited = true;
						pp.IsWithoutAmbience = true;
						if (this.Const.DLC.Desert)
						{
							pp.IsArenaMode = true;
							this.Const.Sound.Volume.Arena = 0;
							this.Const.Sound.ArenaStart = [ "sounds/cloth_01.wav" ];
							this.Const.Sound.ArenaEnd = [ "sounds/cloth_01.wav" ];
							this.Const.Sound.ArenaOutro = [ "sounds/cloth_01.wav" ];
						}
						pp.Entities = [];

				//stage boss//////
		if (aaaxx == 10)
		{
						for( local i = 0; i < 12; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/humans/cultist",
								Faction = this.Const.Faction.Enemy
							});
						}
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 1,
							Script = "scripts/entity/tactical/enemies/xxmob_demon",
							Faction = this.Const.Faction.Enemy
						});
						for( local i = 0; i < 15; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/xxmob_hellranger",
								Faction = this.Const.Faction.Enemy
							});
						}
						for( local i = 0; i < 15; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/xxmob_abomi",
								Faction = this.Const.Faction.Enemy
							});
						}
						for( local i = 0; i < 12; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/vampire",
								Faction = this.Const.Faction.Enemy
							});
						}
		}
		else
		{
				//1//////////////
						local moba;
						local bbb;
						moba = [
							"scripts/entity/tactical/enemies/xxmob_bear",
							"scripts/entity/tactical/enemies/xxmob_clone",
							"scripts/entity/tactical/enemies/xxmob_wokousamurai",
							"scripts/entity/tactical/enemies/xxmob_fungal_b",
							"scripts/entity/tactical/enemies/xxmob_spiderhag",
							"scripts/entity/tactical/enemies/xxmob_bat",
							"scripts/entity/tactical/enemies/xxmob_shaolin",
							"scripts/entity/tactical/enemies/xxmob_hunscaptain",
							"scripts/entity/tactical/enemies/xxmob_syndicate",
							"scripts/entity/tactical/enemies/xxmob_goblin",
							"scripts/entity/tactical/enemies/xxmob_lizard",
							"scripts/entity/tactical/enemies/xxmob_horseman_a",
							"scripts/entity/tactical/enemies/xxmob_witchhunter",
							"scripts/entity/tactical/enemies/xxmob_slime_b",
							"scripts/entity/tactical/enemies/xxmob_hwarang",
							"scripts/entity/tactical/enemies/xxmob_wokou",
							"scripts/entity/tactical/enemies/xxmob_spiderdemon",
							"scripts/entity/tactical/enemies/xxmob_toad",
							"scripts/entity/tactical/enemies/xxmob_huns",
							"scripts/entity/tactical/enemies/xxmob_lion",
							"scripts/entity/tactical/enemies/xxmob_bloodsucker",
							"scripts/entity/tactical/enemies/xxmob_liger",
							"scripts/entity/tactical/enemies/xxmob_kraken_tentacle",
							"scripts/entity/tactical/enemies/xxmob_vampguard",
							"scripts/entity/tactical/enemies/xxmob_orclong",
							"scripts/entity/tactical/enemies/xxmob_orchunter",
							"scripts/entity/tactical/enemies/goblin_fighter",
							"scripts/entity/tactical/enemies/goblin_wolfrider",
							"scripts/entity/tactical/enemies/orc_berserker",
							"scripts/entity/tactical/enemies/orc_warrior",
							"scripts/entity/tactical/enemies/orc_young",
							"scripts/entity/tactical/enemies/zombie_knight",
							"scripts/entity/tactical/enemies/zombie_betrayer",
							"scripts/entity/tactical/enemies/skeleton_heavy",
							"scripts/entity/tactical/enemies/skeleton_heavy_bodyguard",
							"scripts/entity/tactical/enemies/direwolf_high",
							"scripts/entity/tactical/enemies/unhold",
							"scripts/entity/tactical/enemies/unhold_bog",
							"scripts/entity/tactical/enemies/unhold_frost",
							"scripts/entity/tactical/enemies/ghoul_medium",
							"scripts/entity/tactical/enemies/ghoul_high",
							"scripts/entity/tactical/enemies/bandit_leader",
							"scripts/entity/tactical/humans/cultist",
							"scripts/entity/tactical/humans/hedge_knight",
							"scripts/entity/tactical/humans/knight",
							"scripts/entity/tactical/humans/militia_captain",
							"scripts/entity/tactical/humans/mercenary",
							"scripts/entity/tactical/humans/noble_footman",
							"scripts/entity/tactical/humans/noble_sergeant",
							"scripts/entity/tactical/humans/noble_greatsword",
							"scripts/entity/tactical/humans/oathbringer",
							"scripts/entity/tactical/humans/swordmaster"
						];
						bbb = this.Math.rand(3, 5) + aaaxx;
						if (bbb >= 20)
						{
							bbb = 20
						}
						for( local i = 0; i < bbb; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
						}

				//2//////////////
						moba = [
							"scripts/entity/tactical/enemies/xxmob_bear",
							"scripts/entity/tactical/enemies/xxmob_clone",
							"scripts/entity/tactical/enemies/xxmob_wokousamurai",
							"scripts/entity/tactical/enemies/xxmob_fungal_b",
							"scripts/entity/tactical/enemies/xxmob_spiderhag",
							"scripts/entity/tactical/enemies/xxmob_bat",
							"scripts/entity/tactical/enemies/xxmob_shaolin",
							"scripts/entity/tactical/enemies/xxmob_hunscaptain",
							"scripts/entity/tactical/enemies/xxmob_syndicate",
							"scripts/entity/tactical/enemies/xxmob_goblin",
							"scripts/entity/tactical/enemies/xxmob_lizard",
							"scripts/entity/tactical/enemies/xxmob_horseman_a",
							"scripts/entity/tactical/enemies/xxmob_witchhunter",
							"scripts/entity/tactical/enemies/xxmob_slime_b",
							"scripts/entity/tactical/enemies/xxmob_hwarang",
							"scripts/entity/tactical/enemies/xxmob_wokou",
							"scripts/entity/tactical/enemies/xxmob_spiderdemon",
							"scripts/entity/tactical/enemies/xxmob_toad",
							"scripts/entity/tactical/enemies/xxmob_huns",
							"scripts/entity/tactical/enemies/xxmob_lion",
							"scripts/entity/tactical/enemies/xxmob_bloodsucker",
							"scripts/entity/tactical/enemies/xxmob_liger",
							"scripts/entity/tactical/enemies/xxmob_kraken_tentacle",
							"scripts/entity/tactical/enemies/xxmob_vampguard",
							"scripts/entity/tactical/enemies/xxmob_orclong",
							"scripts/entity/tactical/enemies/xxmob_orchunter",
							"scripts/entity/tactical/enemies/goblin_fighter",
							"scripts/entity/tactical/enemies/goblin_wolfrider",
							"scripts/entity/tactical/enemies/orc_berserker",
							"scripts/entity/tactical/enemies/orc_warrior",
							"scripts/entity/tactical/enemies/orc_young",
							"scripts/entity/tactical/enemies/goblin_ambusher",
							"scripts/entity/tactical/enemies/goblin_leader",
							"scripts/entity/tactical/enemies/direwolf_high",
							"scripts/entity/tactical/enemies/ghoul_medium",
							"scripts/entity/tactical/enemies/ghoul_high",
							"scripts/entity/tactical/enemies/zombie_betrayer",
							"scripts/entity/tactical/enemies/zombie_treasure_hunter",
							"scripts/entity/tactical/enemies/vampire",
							"scripts/entity/tactical/enemies/vampire_low",
							"scripts/entity/tactical/enemies/skeleton_medium_polearm",
							"scripts/entity/tactical/enemies/skeleton_heavy_polearm",
							"scripts/entity/tactical/enemies/ghost",
							"scripts/entity/tactical/humans/bounty_hunter_ranged",
							"scripts/entity/tactical/humans/master_archer",
							"scripts/entity/tactical/humans/mercenary_ranged",
							"scripts/entity/tactical/humans/noble_billman",
							"scripts/entity/tactical/humans/noble_arbalester"
						];
						bbb = this.Math.rand(3, 5) + aaaxx;
						if (bbb >= 20)
						{
							bbb = 20
						}
						for( local i = 0; i < bbb; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
						}

				//s//////////////
						moba = [
							"scripts/entity/tactical/enemies/xxmob_wendigo",
							"scripts/entity/tactical/enemies/xxmob_jinn",
							"scripts/entity/tactical/enemies/xxmob_arcane",
							"scripts/entity/tactical/enemies/xxmob_horseman_b",
							"scripts/entity/tactical/enemies/xxmob_battlemaster",
							"scripts/entity/tactical/enemies/xxmob_elemental",
							"scripts/entity/tactical/enemies/xxmob_abomi",
							"scripts/entity/tactical/enemies/xxmob_hellranger",
							"scripts/entity/tactical/enemies/xxmob_darkman",
							"scripts/entity/tactical/enemies/xxmob_cultchamp",
							"scripts/entity/tactical/enemies/xxmob_elf",
							"scripts/entity/tactical/enemies/xxmob_elfsword",
							"scripts/entity/tactical/enemies/xxmob_wolf",
							"scripts/entity/tactical/enemies/xxmob_vamp",
							"scripts/entity/tactical/enemies/xxmob_subzero",
							"scripts/entity/tactical/enemies/xxmob_mage"
						];
						bbb = 1 + aaaxx;
						if (bbb >= 20)
						{
							bbb = 20
						}
						for( local i = 0; i < bbb; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = this.Math.rand(0, 1),
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
						}

				//b//////////////
						moba = [
							"scripts/entity/tactical/enemies/xxmob_archlich",
							"scripts/entity/tactical/enemies/xxmob_archmage",
							"scripts/entity/tactical/enemies/xxmob_goblinking",
							"scripts/entity/tactical/enemies/xxmob_guildmaster",
							"scripts/entity/tactical/enemies/xxmob_ghoul",
							"scripts/entity/tactical/enemies/xxmob_orcking",
							"scripts/entity/tactical/enemies/xxmob_blackorc",
							"scripts/entity/tactical/enemies/xxmob_demon",
							"scripts/entity/tactical/enemies/xxmob_demonking",
							"scripts/entity/tactical/enemies/xxmob_golem",
							"scripts/entity/tactical/enemies/xxmob_knight",
							"scripts/entity/tactical/enemies/xxmob_berserkguts"
						];
						for( local i = 0; i < 1; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
						}

				//3last//////////
						bbb = this.Math.rand(1, 10);
					if (this.Const.DLC.Unhold && this.Const.DLC.Wildmen && this.Const.DLC.Desert)
					{
						if (bbb == 1)
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/hexe",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/spider_eggs",
								Faction = this.Const.Faction.Enemy
							});
							for( local i = 0; i < 3; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/enemies/hyena_high",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 1,
									Script = "scripts/entity/tactical/enemies/direwolf_high",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 2,
									Script = "scripts/entity/tactical/enemies/spider_bodyguard",
									Faction = this.Const.Faction.Enemy
								});
							}
						}
						else if (bbb == 2)
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/necromancer",
								Faction = this.Const.Faction.Enemy
							});
							for( local i = 0; i < 3; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/enemies/zombie_betrayer",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 1,
									Script = "scripts/entity/tactical/enemies/zombie_treasure_hunter",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 2,
									Script = "scripts/entity/tactical/enemies/skeleton_heavy_bodyguard",
									Faction = this.Const.Faction.Enemy
								});
							}
						}
						else if (bbb == 3)
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 3,
								Script = "scripts/entity/tactical/humans/barbarian_drummer",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/barbarian_beastmaster",
								Faction = this.Const.Faction.Enemy
							});
							for( local i = 0; i < 3; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/enemies/unhold_armored",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/enemies/unhold_frost_armored",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 1,
									Script = "scripts/entity/tactical/humans/barbarian_marauder",
									Faction = this.Const.Faction.Enemy
								});
							}
						}
						else if (bbb == 4)
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 3,
								Script = "scripts/entity/tactical/humans/officer",
								Faction = this.Const.Faction.Enemy
							});
							for( local i = 0; i < 4; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/humans/gunner",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 1,
									Script = "scripts/entity/tactical/humans/noble_arbalester",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 2,
									Script = "scripts/entity/tactical/enemies/goblin_ambusher",
									Faction = this.Const.Faction.Enemy
								});
							}
						}
						else if (bbb == 5)
						{
							for( local i = 0; i < 5; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/enemies/orc_berserker",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 1,
									Script = "scripts/entity/tactical/enemies/skeleton_heavy_polearm",
									Faction = this.Const.Faction.Enemy
								});
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/humans/hedge_knight",
									Faction = this.Const.Faction.Enemy
								});
							}
						}
						else
						{
							moba = [
								"scripts/entity/tactical/enemies/zombie_knight",
								"scripts/entity/tactical/enemies/zombie_betrayer",
								"scripts/entity/tactical/enemies/zombie_treasure_hunter",
								"scripts/entity/tactical/enemies/skeleton_heavy",
								"scripts/entity/tactical/humans/barbarian_marauder",
								"scripts/entity/tactical/humans/barbarian_champion",
								"scripts/entity/tactical/humans/barbarian_chosen",
								"scripts/entity/tactical/humans/conscript",
								"scripts/entity/tactical/humans/desert_devil",
								"scripts/entity/tactical/humans/executioner",
								"scripts/entity/tactical/humans/gladiator",
								"scripts/entity/tactical/humans/knight",
								"scripts/entity/tactical/humans/hedge_knight",
								"scripts/entity/tactical/humans/noble_greatsword",
								"scripts/entity/tactical/humans/oathbringer",
								"scripts/entity/tactical/humans/swordmaster",
								"scripts/entity/tactical/enemies/goblin_wolfrider",
								"scripts/entity/tactical/enemies/orc_berserker",
								"scripts/entity/tactical/enemies/orc_warrior",
								"scripts/entity/tactical/enemies/ghoul_high",
								"scripts/entity/tactical/enemies/unhold",
								"scripts/entity/tactical/enemies/unhold_bog",
								"scripts/entity/tactical/enemies/unhold_frost",
								"scripts/entity/tactical/enemies/serpent",
								"scripts/entity/tactical/enemies/direwolf_high",
								"scripts/entity/tactical/enemies/hyena_high",
								"scripts/entity/tactical/enemies/goblin_wolfrider"
							];
							for( local i = 0; i < 4; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = moba[this.Math.rand(0, moba.len() - 1)],
									Faction = this.Const.Faction.Enemy
								});
							}

							moba = [
								"scripts/entity/tactical/humans/officer",
								"scripts/entity/tactical/humans/conscript_polearm",
								"scripts/entity/tactical/humans/gunner",
								"scripts/entity/tactical/humans/nomad_leader",
								"scripts/entity/tactical/humans/desert_stalker",
								"scripts/entity/tactical/humans/assassin",
								"scripts/entity/tactical/enemies/bandit_leader",
								"scripts/entity/tactical/enemies/skeleton_heavy_polearm",
								"scripts/entity/tactical/enemies/goblin_ambusher",
								"scripts/entity/tactical/enemies/goblin_leader",
								"scripts/entity/tactical/enemies/goblin_shaman",
								"scripts/entity/tactical/humans/bounty_hunter_ranged",
								"scripts/entity/tactical/humans/master_archer",
								"scripts/entity/tactical/humans/mercenary_ranged",
								"scripts/entity/tactical/enemies/skeleton_priest"
							];
							for( local i = 0; i < 4; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 1,
									Script = moba[this.Math.rand(0, moba.len() - 1)],
									Faction = this.Const.Faction.Enemy
								});
							}

							moba = [
								"scripts/entity/tactical/enemies/skeleton_boss",
								"scripts/entity/tactical/enemies/ghost_knight",
								"scripts/entity/tactical/enemies/skeleton_lich_mirror_image",
								"scripts/entity/tactical/humans/barbarian_madman",
								"scripts/entity/tactical/enemies/orc_warlord",
								"scripts/entity/tactical/enemies/lindwurm",
								"scripts/entity/tactical/enemies/schrat",
								"scripts/entity/tactical/enemies/sand_golem_high"
							];
							for( local i = 0; i < 1; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 2,
									Script = moba[this.Math.rand(0, moba.len() - 1)],
									Faction = this.Const.Faction.Enemy
								});
							}
						}
					}
					else
					{
						for( local i = 0; i < 5; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/orc_berserker",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/skeleton_heavy_polearm",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/humans/hedge_knight",
								Faction = this.Const.Faction.Enemy
							});
						}
					}
		}
	/////////////////////////////////////////

						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				},
				{
					Text = "Fall back!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local aaaxx = this.World.Statistics.getFlags().getAsInt("aaaxx");
				_event.m.Title = "Infinite Dungeon : Level " + (aaaxx + 0) + "";
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_132.png[/img]{In the pile of corpses, you sigh for a moment. What the hell is this place? You are determined to leave this place before the evil ones are summoned again. \n\n[color=#56e64c]Choose the next battle difficulty of the infinite dungeon[/color]}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Increase infinite dungeon difficulty + Get the blue vial",
					function getResult( _event )
					{
						this.World.Assets.getStash().makeEmptySlots(1);
						local iitem = this.new("scripts/items/special/spiritual_reward_item");
						this.World.Assets.getStash().add(iitem);

						this.World.Statistics.getFlags().increment("aaaxx", 1);
						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							local hhhxx = this.World.Statistics.getFlags().getAsInt("hhhxx");
							if (hhhxx >= 2)
							{
								this.World.Statistics.getFlags().increment("hhhxx", -2);
								return "NewbroA";
							}
							else
							{
								this.World.Statistics.getFlags().increment("hhhxx", 1);
								if (this.Math.rand(1, 5) == 3)
								{
									return "NewbroA";
								}
								else
								{
									return 0;
								}
							}
						}
						else
						{
							return 0;
						}
					}
				},
				{
					Text = "Maintain infinite dungeon difficulty",
					function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							local hhhxx = this.World.Statistics.getFlags().getAsInt("hhhxx");
							if (hhhxx >= 2)
							{
								this.World.Statistics.getFlags().increment("hhhxx", -2);
								return "NewbroA";
							}
							else
							{
								this.World.Statistics.getFlags().increment("hhhxx", 1);
								if (this.Math.rand(1, 5) == 3)
								{
									return "NewbroA";
								}
								else
								{
									return 0;
								}
							}
						}
						else
						{
							return 0;
						}
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				this.Const.Sound.Volume.Arena = 0.6;
				this.World.Assets.getStash().makeEmptySlots(2);
				local item = this.new("scripts/items/special/fountain_of_youth_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local weapons = [
						"weapons/named/named_axe",
						"weapons/named/named_billhook",
						"weapons/named/named_cleaver",
						"weapons/named/named_flail",
						"weapons/named/named_greataxe",
						"weapons/named/named_greatsword",
						"weapons/named/named_longaxe",
						"weapons/named/named_mace",
						"weapons/named/named_orc_axe",
						"weapons/named/named_orc_cleaver",
						"weapons/named/named_pike",
						"weapons/named/named_spear",
						"weapons/named/named_sword",
						"weapons/named/named_warhammer"
				];
				if (this.Const.DLC.Unhold && this.Const.DLC.Wildmen && this.Const.DLC.Desert)
				{
					weapons = [
						"weapons/named/named_axe",
						"weapons/named/named_bardiche",
						"weapons/named/named_battle_whip",
						"weapons/named/named_billhook",
						"weapons/named/named_bladed_pike",
						"weapons/named/named_cleaver",
						"weapons/named/named_crossbow",
						"weapons/named/named_crypt_cleaver",
						"weapons/named/named_dagger",
						"weapons/named/named_fencing_sword",
						"weapons/named/named_flail",
						"weapons/named/named_goblin_falchion",
						"weapons/named/named_goblin_heavy_bow",
						"weapons/named/named_goblin_pike",
						"weapons/named/named_goblin_spear",
						"weapons/named/named_greataxe",
						"weapons/named/named_greatsword",
						"weapons/named/named_handgonne",
						"weapons/named/named_heavy_rusty_axe",
						"weapons/named/named_javelin",
						"weapons/named/named_khopesh",
						"weapons/named/named_longaxe",
						"weapons/named/named_mace",
						"weapons/named/named_orc_axe",
						"weapons/named/named_orc_cleaver",
						"weapons/named/named_pike",
						"weapons/named/named_polehammer",
						"weapons/named/named_polemace",
						"weapons/named/named_qatal_dagger",
						"weapons/named/named_rusty_warblade",
						"weapons/named/named_shamshir",
						"weapons/named/named_skullhammer",
						"weapons/named/named_spear",
						"weapons/named/named_spetum",
						"weapons/named/named_sword",
						"weapons/named/named_swordlance",
						"weapons/named/named_three_headed_flail",
						"weapons/named/named_throwing_axe",
						"weapons/named/named_two_handed_flail",
						"weapons/named/named_two_handed_hammer",
						"weapons/named/named_two_handed_mace",
						"weapons/named/named_two_handed_scimitar",
						"weapons/named/named_two_handed_spiked_mace",
						"weapons/named/named_warbow",
						"weapons/named/named_warbrand",
						"weapons/named/named_warhammer",
						"weapons/named/named_warscythe"
					];
				}
				item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 11,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});

				this.World.Assets.addMoney(2000);
				this.List.push({
					id = 12,
					icon = "ui/items/supplies/money.png",
					text = "You gain 2000 gold"
				});
			}

		});
		this.m.Screens.push({
			ID = "NewbroA",
			Text = "[img]gfx/ui/events/event_133.png[/img]{Your party has found a survivor in this hellish place. The demons of Hell often kidnap and indoctrinate strong warriors to make them their minions. This survivor is probably one of the abducted warriors.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let that survivor join our party.",
					function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							return "NewbroB";
						}
						else
						{
							return 0;
						}
					}
				},
				{
					Text = "No, I don\'t want strangers in our group.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "NewbroB",
			Text = "[img]gfx/ui/events/event_90.png[/img]{Your party leaves this place in a hurry.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Come on, everyone, hurry up!",
					function getResult( _event )
					{
						this.Const.Sound.Volume.Arena = 0.6;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getPlayerRoster();
				local xxlonexx = roster.create("scripts/entity/tactical/player");
				if (this.Math.rand(1, 5) == 3)
				{
					xxlonexx.setStartValuesEx([
			"xxhero_baku_background",
			"xxhero_elf_background",
			"xxhero_female_background",
			"xxhero_goblin_background",
			"xxhero_male_background",
			"xxhero_orc_background",
			"xxhero_undead_background"
					]);
				}
				else
				{
					xxlonexx.setStartValuesEx([
			"adventurous_noble_background",
			"anatomist_background",
			"apprentice_background",
			"assassin_background",
			"assassin_southern_background",
			"barbarian_background",
			"bastard_background",
			"beast_hunter_background",
			"beggar_background",
			"beggar_southern_background",
			"belly_dancer_background",
			"bowyer_background",
			"brawler_background",
			"butcher_background",
			"butcher_southern_background",
			"caravan_hand_background",
			"caravan_hand_southern_background",
			"companion_1h_background",
			"companion_1h_southern_background",
			"companion_2h_background",
			"companion_2h_southern_background",
			"companion_ranged_background",
			"companion_ranged_southern_background",
			"cripple_background",
			"cripple_southern_background",
			"cultist_background",
			"daytaler_background",
			"daytaler_southern_background",
			"deserter_background",
			"disowned_noble_background",
			"eunuch_background",
			"eunuch_southern_background",
			"farmhand_background",
			"fisherman_background",
			"fisherman_southern_background",
			"flagellant_background",
			"gambler_background",
			"gambler_southern_background",
			"gladiator_background",
			"gravedigger_background",
			"graverobber_background",
			"hedge_knight_background",
			"historian_background",
			"houndmaster_background",
			"hunter_background",
			"juggler_background",
			"juggler_southern_background",
			"killer_on_the_run_background",
			"lindwurm_slayer_background",
			"lumberjack_background",
			"manhunter_background",
			"mason_background",
			"messenger_background",
			"militia_background",
			"miner_background",
			"minstrel_background",
			"monk_background",
			"nomad_background",
			"nomad_ranged_background",
			"paladin_background",
			"peddler_background",
			"peddler_southern_background",
			"pimp_background",
			"poacher_background",
			"raider_background",
			"ratcatcher_background",
			"refugee_background",
			"retired_soldier_background",
			"sellsword_background",
			"servant_background",
			"servant_southern_background",
			"shepherd_background",
			"shepherd_southern_background",
			"slave_background",
			"slave_barbarian_background",
			"slave_southern_background",
			"squire_background",
			"swordmaster_background",
			"tailor_background",
			"tailor_southern_background",
			"thief_background",
			"thief_southern_background",
			"vagabond_background",
			"wildman_background",
			"witchhunter_background"
					]);
				}
				xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
				xxlonexx.m.PerkPoints = 1;
				xxlonexx.m.LevelUps = 1;
				xxlonexx.m.Level = 2;
				xxlonexx.m.Talents = [];
				xxlonexx.m.Attributes = [];
				xxlonexx.getBaseProperties().Hitpoints += this.Math.rand(0, 5);
				xxlonexx.getBaseProperties().Bravery += this.Math.rand(0, 5);
				xxlonexx.getBaseProperties().Stamina += this.Math.rand(0, 5);
				xxlonexx.getBaseProperties().MeleeSkill += this.Math.rand(0, 5);
				xxlonexx.getBaseProperties().RangedSkill += this.Math.rand(0, 5);
				xxlonexx.getBaseProperties().MeleeDefense += this.Math.rand(0, 5);
				xxlonexx.getBaseProperties().RangedDefense += this.Math.rand(0, 5);
				xxlonexx.getBaseProperties().Initiative += this.Math.rand(0, 5);
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
				this.List.push({
					id = 11,
					icon = "ui/perks/perk_28_active.png",
					text = "A new brother joins the party"
				});
				return 0;
			}
		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_88.png[/img]{What the hell is this madness place? Seeing an escape opportunity, you decide to run away from this place.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Shouldn\'t have come here...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				this.Const.Sound.Volume.Arena = 0.6;
			}
		});


	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

