this.xxarena_contract <- this.inherit("scripts/contracts/contract", {
	m = {},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.xxarena";
		this.m.Name = "Adventurer\'s Guild Mission";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.setup();
		this.contract.start();
	}

	function setup()
	{
		local pay;
		if (this.World.Statistics.getFlags().getAsInt("XXADVWIN") > 9)
		{
			pay = this.World.Statistics.getFlags().getAsInt("XXADVWIN") * 20 + 1200;
		}
		else
		if (this.World.Statistics.getFlags().getAsInt("XXADVWIN") >= 2)
		{
			pay = this.World.Statistics.getFlags().getAsInt("XXADVWIN") * 20 + 700;
		}
		else
		{
			pay = this.World.Statistics.getFlags().getAsInt("XXADVWIN") * 20 + 300;
		}
		this.m.Payment.Pool = pay * this.getPaymentMult();
		this.m.Payment.Completion = 1.0;
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Visit the Adventurer\'s Guild to receive the quest.",
					"Defeat all enemies"
				];
				this.Contract.m.BulletpointsPayment = [
					"Rewards: " + this.Contract.m.Payment.getOnCompletion() + " crowns",
					"Mission Success: " + this.World.Statistics.getFlags().getAsInt("XXADVWIN") + " time"
				];
				this.Flags.set("Day", this.World.getTime().Days);
				this.World.Contracts.setActiveContract(this.Contract);
				this.Contract.setScreen("Start");
			}
		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.World.getTime().Days > this.Flags.get("Day"))
				{
					this.Contract.setScreen("FailureEndd");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("FQP") == 1)
				{
					this.Contract.setScreen("FailureEndd");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("FQP") == 2)
				{
					this.Contract.setScreen("FightWin");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("FQP") == 3)
				{
					this.Contract.setScreen("Success");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Fightbattle")
				{
					this.Flags.set("FQP", 2);
				}
				if (_combatID == "Fantasybattle")
				{
					this.Flags.set("FQP", 3);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Fantasybattle")
				{
					this.Flags.set("FQP", 1);
				}
				if (_combatID == "Fightbattle")
				{
					this.Flags.set("FQP", 1);
				}
			}
		});
	}

	function createScreens()
	{
		this.m.Screens.push({
			ID = "Start",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_63.png[/img]{The Adventurer\'s Guild is one of the busiest places in town. During the day, various adventurers come here to find work. Currently, the guild is looking for talented adventurers to perform bounty missions. Anyone can apply, but you are solely responsible for your own risk. \n\n[color=#56e64c]The difficulty increases with each success of the guild\'s mission. Starting with the 3rd mission, the difficulty and rewards increase significantly. A special reward is awarded for every successful 7th mission.[/color]}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "It\'s time to work.",
					function getResult()
					{
						this.Contract.setState("Running");
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.CombatID = "Fantasybattle";
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
						pp.IsAutoAssigningBases = false;
						pp.IsWithoutAmbience = true;
						pp.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						local btile = this.Contract.getTileToSpawnLocation(this.World.State.getPlayer().getTile(), 10, 80, [
							this.Const.World.TerrainType.Ocean,
							this.Const.World.TerrainType.Shore,
							this.Const.World.TerrainType.Mountains
						], false);
						pp.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[btile.TacticalType];
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
						else
						{
							btile = [
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
						}
						if (this.Math.rand(1, 100) <= 35)
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

						qq = this.Math.rand(1, 10);
						if (qq == 1)
						{
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						}
						else
						if (qq == 2)
						{
							local grass = this.Math.rand(1, 3);
							if (grass == 1)
							{
								pp.TerrainTemplate = "tactical.plains";
							}
							else if (grass == 2)
							{
								pp.TerrainTemplate = "tactical.steppe";
							}
							else
							{
								pp.TerrainTemplate = "tactical.tundra";
							}
							pp.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
							pp.LocationTemplate.Fortification = this.Math.rand(1, 5) == 2 ? this.Const.Tactical.FortificationType.WallsAndPalisade : this.Const.Tactical.FortificationType.Walls;
							pp.LocationTemplate.CutDownTrees = true;
							pp.LocationTemplate.ShiftX += 3;
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
							pp.BeforeDeploymentCallback = function ()
							{
								local size = this.Tactical.getMapSize();
								local tiletypemax = 0;
								for( local x = 0; x < size.X; x = ++x )
								{
									for( local y = 0; y < size.Y; y = ++y )
									{
										local tile = this.Tactical.getTileSquare(x, y);
										tile.Level = this.Math.min(0, tile.Level);
										tiletypemax = tiletypemax + 1;
										if (tiletypemax > 577)
										{
											if (this.Math.rand(1, 100) <= 95)
											{
												tile.setBrush("tile_road");
											}
											else
											{
												tile.setBrush("tile_autumn_04");
											}
											if (this.Math.rand(1, 100) <= 70)
											{
												tile.removeObject();
												tile.clear();
											}
										}
										else
										{
											if (this.Math.rand(1, 100) <= 80)
											{
												if (grass == 1)
												{
													tile.setBrush("tile_tundra_01");
												}
												else if (grass == 2)
												{
													tile.setBrush("tile_steppe_02");
												}
												else
												{
													tile.setBrush("tile_tundra_03");
												}
											}
											else
											{
												if (grass == 1)
												{
													tile.setBrush("tile_grass_02");
												}
												else if (grass == 2)
												{
													tile.setBrush("tile_steppe_01");
												}
												else
												{
													tile.setBrush("tile_tundra_04");
												}
											}
											if (this.Math.rand(1, 100) <= 70)
											{
												tile.removeObject();
												tile.clear();
											}
										}
										if (tiletypemax > 512 && tiletypemax < 545 && this.Math.rand(1, 100) <= 111)
										{
											tile.clear();
											tile.Type = 0;
											this.MapGen.get("tactical.tile.swampx1").onFirstPass({
												X = tile.SquareCoords.X,
												Y = tile.SquareCoords.Y,
												W = 1,
												H = 1,
												IsEmpty = true,
												SpawnObjects = false
											});
											tile.removeObject();
											tile.spawnDetail("steppe_stone_detail_0" + this.Math.rand(1, 9)).Scale = 0.9;
										}
										if (tiletypemax > 544 && tiletypemax < 556 && this.Math.rand(1, 100) <= 95)
										{
											tile.removeObject();
											tile.clear();
											local tt = tile.spawnObject("entity/tactical/objects/graveyard_wall");
											tt.getSprite("body").setBrush("graveyard_29_07");
										}
										if (tiletypemax > 560 && tiletypemax < 577 && this.Math.rand(1, 100) <= 95)
										{
											tile.removeObject();
											tile.clear();
											local tt = tile.spawnObject("entity/tactical/objects/graveyard_wall");
											tt.getSprite("body").setBrush("graveyard_29_07");
										}
									}
								}
							};
						}
						else
						if (qq == 3)
						{
							local grass = this.Math.rand(1, 3);
							if (grass == 1)
							{
								pp.TerrainTemplate = "tactical.plains";
							}
							else if (grass == 2)
							{
								pp.TerrainTemplate = "tactical.steppe";
							}
							else
							{
								pp.TerrainTemplate = "tactical.tundra";
							}
							pp.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
							pp.LocationTemplate.Fortification = this.Math.rand(1, 5) == 2 ? this.Const.Tactical.FortificationType.WallsAndPalisade : this.Const.Tactical.FortificationType.Walls;
							pp.LocationTemplate.CutDownTrees = true;
							pp.LocationTemplate.ShiftX += -1;
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.LineBack;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
							pp.BeforeDeploymentCallback = function ()
							{
								local size = this.Tactical.getMapSize();
								local tiletypemax = 0;
								for( local x = 0; x < size.X; x = ++x )
								{
									for( local y = 0; y < size.Y; y = ++y )
									{
										local tile = this.Tactical.getTileSquare(x, y);
										tile.Level = this.Math.min(0, tile.Level);
										tiletypemax = tiletypemax + 1;
										if (tiletypemax < 385)
										{
											if (this.Math.rand(1, 100) <= 95)
											{
												tile.setBrush("tile_road");
											}
											else
											{
												tile.setBrush("tile_autumn_04");
											}
											if (this.Math.rand(1, 100) <= 70)
											{
												tile.removeObject();
												tile.clear();
											}
										}
										else
										{
											if (this.Math.rand(1, 100) <= 80)
											{
												if (grass == 1)
												{
													tile.setBrush("tile_tundra_01");
												}
												else if (grass == 2)
												{
													tile.setBrush("tile_steppe_02");
												}
												else
												{
													tile.setBrush("tile_tundra_03");
												}
											}
											else
											{
												if (grass == 1)
												{
													tile.setBrush("tile_grass_02");
												}
												else if (grass == 2)
												{
													tile.setBrush("tile_steppe_01");
												}
												else
												{
													tile.setBrush("tile_tundra_04");
												}
											}
											if (this.Math.rand(1, 100) <= 70)
											{
												tile.removeObject();
												tile.clear();
											}
										}
										if (tiletypemax > 352 && tiletypemax < 385 && this.Math.rand(1, 100) <= 111)
										{
											tile.clear();
											tile.Type = 0;
											this.MapGen.get("tactical.tile.swampx1").onFirstPass({
												X = tile.SquareCoords.X,
												Y = tile.SquareCoords.Y,
												W = 1,
												H = 1,
												IsEmpty = true,
												SpawnObjects = false
											});
											tile.removeObject();
											tile.spawnDetail("steppe_stone_detail_0" + this.Math.rand(1, 9)).Scale = 0.9;
										}
										if (tiletypemax > 320 && tiletypemax < 335 && this.Math.rand(1, 100) <= 95)
										{
											tile.removeObject();
											tile.clear();
											local tt = tile.spawnObject("entity/tactical/objects/graveyard_wall");
											tt.getSprite("body").setBrush("graveyard_29_06");
										}
										if (tiletypemax > 338 && tiletypemax < 353 && this.Math.rand(1, 100) <= 95)
										{
											tile.removeObject();
											tile.clear();
											local tt = tile.spawnObject("entity/tactical/objects/graveyard_wall");
											tt.getSprite("body").setBrush("graveyard_29_06");
										}
									}
								}
							};
						}
						else
						if (qq == 4)
						{
							local grass = this.Math.rand(1, 3);
							if (grass == 1)
							{
								pp.TerrainTemplate = "tactical.plains";
							}
							else if (grass == 2)
							{
								pp.TerrainTemplate = "tactical.steppe";
							}
							else
							{
								pp.TerrainTemplate = "tactical.tundra";
							}
							pp.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
							pp.LocationTemplate.Fortification = this.Math.rand(1, 5) == 2 ? this.Const.Tactical.FortificationType.WallsAndPalisade : this.Const.Tactical.FortificationType.Walls;
							pp.LocationTemplate.CutDownTrees = true;
							pp.LocationTemplate.ShiftX += -1;
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
							pp.BeforeDeploymentCallback = function ()
							{
								local size = this.Tactical.getMapSize();
								local tiletypemax = 0;
								for( local x = 0; x < size.X; x = ++x )
								{
									for( local y = 0; y < size.Y; y = ++y )
									{
										local tile = this.Tactical.getTileSquare(x, y);
										tile.Level = this.Math.min(0, tile.Level);
										tiletypemax = tiletypemax + 1;
										if (tiletypemax < 481)
										{
											if (this.Math.rand(1, 100) <= 95)
											{
												tile.setBrush("tile_road");
											}
											else
											{
												tile.setBrush("tile_autumn_04");
											}
											if (this.Math.rand(1, 100) <= 70)
											{
												tile.removeObject();
												tile.clear();
											}
										}
										else
										{
											if (this.Math.rand(1, 100) <= 80)
											{
												if (grass == 1)
												{
													tile.setBrush("tile_tundra_01");
												}
												else if (grass == 2)
												{
													tile.setBrush("tile_steppe_02");
												}
												else
												{
													tile.setBrush("tile_tundra_03");
												}
											}
											else
											{
												if (grass == 1)
												{
													tile.setBrush("tile_grass_02");
												}
												else if (grass == 2)
												{
													tile.setBrush("tile_steppe_01");
												}
												else
												{
													tile.setBrush("tile_tundra_04");
												}
											}
											if (this.Math.rand(1, 100) <= 70)
											{
												tile.removeObject();
												tile.clear();
											}
										}
										if (tiletypemax > 480 && tiletypemax < 513 && this.Math.rand(1, 100) <= 111)
										{
											tile.clear();
											tile.Type = 0;
											this.MapGen.get("tactical.tile.swamp1").onFirstPass({
												X = tile.SquareCoords.X,
												Y = tile.SquareCoords.Y,
												W = 1,
												H = 1,
												IsEmpty = true,
												SpawnObjects = false
											});
											tile.removeObject();
											tile.spawnDetail("steppe_stone_detail_0" + this.Math.rand(1, 9)).Scale = 0.9;
										}
										if (tiletypemax > 448 && tiletypemax < 463 && this.Math.rand(1, 100) <= 95)
										{
											tile.removeObject();
											tile.clear();
											local tt = tile.spawnObject("entity/tactical/objects/graveyard_wall");
											tt.getSprite("body").setBrush("graveyard_29_06");
										}
										if (tiletypemax > 466 && tiletypemax < 481 && this.Math.rand(1, 100) <= 95)
										{
											tile.removeObject();
											tile.clear();
											local tt = tile.spawnObject("entity/tactical/objects/graveyard_wall");
											tt.getSprite("body").setBrush("graveyard_29_06");
										}
									}
								}
							};
						}
						else
						{
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						}

						pp.Entities = [];
						local bbb;
						local moba;
						local bc = this.World.Statistics.getFlags().getAsInt("XXADVWIN");
						bbb = this.Math.rand(1, 3);

						if (bc >= 2)
						{
							if (bbb == 1 && bc >= 8)
							{
								local ivi = this.Math.rand(1, 5);
								if (ivi == 1)
								{
									moba = [
										"scripts/entity/tactical/enemies/xxmob_battlemaster"
									];
								}
								else if (ivi == 2)
								{
									moba = [
										"scripts/entity/tactical/enemies/xxmob_horseman_b"
									];
								}
								else if (ivi == 3)
								{
									moba = [
										"scripts/entity/tactical/enemies/xxmob_cultchamp"
									];
								}
								else if (ivi == 4)
								{
									moba = [
										"scripts/entity/tactical/enemies/xxmob_wolf",
										"scripts/entity/tactical/enemies/xxmob_wendigo"
									];
								}
								else
								{
									moba = [
										"scripts/entity/tactical/enemies/xxmob_abomi",
										"scripts/entity/tactical/enemies/xxmob_hellranger"
									];
								}
								moba = moba[this.Math.rand(0, moba.len() - 1)];
								bbb = this.Math.floor(bc / 7);
								if (bbb >= 3)
								{
									bbb = 3;
								}
								for( local i = 0; i < bbb; i = ++i )
								{
									pp.Entities.push({
										ID = this.Const.EntityType.SkeletonBoss,
										Variant = 0,
										Row = 0,
										Script = moba,
										Faction = this.Const.Faction.Enemy
									});
								}
								if (ivi == 1)
								{
									moba = [
										"scripts/entity/tactical/humans/bounty_hunter",
										"scripts/entity/tactical/humans/mercenary"
									];
								}
								else if (ivi == 2)
								{
									moba = [
										"scripts/entity/tactical/enemies/xxmob_horseman_a"
									];
								}
								else if (ivi == 3)
								{
									moba = [
										"scripts/entity/tactical/humans/cultist"
									];
								}
								else if (ivi == 4)
								{
									moba = [
										"scripts/entity/tactical/enemies/direwolf_high"
									];
								}
								else
								{
									moba = [
										"scripts/entity/tactical/enemies/orc_berserker",
										"scripts/entity/tactical/enemies/skeleton_heavy_polearm"
									];
								}
								moba = moba[this.Math.rand(0, moba.len() - 1)];
								bbb = this.Math.floor(bc / 2) + 8;
								if (bbb >= 20)
								{
									bbb = 20;
								}
								for( local i = 0; i < bbb; i = ++i )
								{
									pp.Entities.push({
										ID = this.Const.EntityType.SkeletonBoss,
										Variant = 0,
										Row = 0,
										Script = moba,
										Faction = this.Const.Faction.Enemy
									});
								}
							}
							else if (bbb == 2)
							{
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
									"scripts/entity/tactical/enemies/xxmob_goblin"
								];
								moba = moba[this.Math.rand(0, moba.len() - 1)];
								bbb = this.Math.floor(bc / 3) + 4;
								if (bbb >= 12)
								{
									bbb = 12;
								}
								for( local i = 0; i < bbb; i = ++i )
								{
									pp.Entities.push({
										ID = this.Const.EntityType.SkeletonBoss,
										Variant = 0,
										Row = 0,
										Script = moba,
										Faction = this.Const.Faction.Enemy
									});
								}
							}
							else
							{
								moba = [
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
									"scripts/entity/tactical/enemies/xxmob_liger"
								];
								if (this.World.getTime().Days >= 50)
								{
									moba.push("scripts/entity/tactical/enemies/xxmob_orchunter");
								}
								if (this.World.getTime().Days >= 100)
								{
									moba.push("scripts/entity/tactical/enemies/xxmob_orclong");
								}
								moba = moba[this.Math.rand(0, moba.len() - 1)];
								bbb = this.Math.floor(bc / 2) + 8;
								if (bbb >= 20)
								{
									bbb = 20;
								}
								for( local i = 0; i < bbb; i = ++i )
								{
									pp.Entities.push({
										ID = this.Const.EntityType.SkeletonBoss,
										Variant = 0,
										Row = 0,
										Script = moba,
										Faction = this.Const.Faction.Enemy
									});
								}
							}
						}
						else
						{
							moba = [
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
									"scripts/entity/tactical/enemies/xxmob_liger"
							];
							moba = moba[this.Math.rand(0, moba.len() - 1)];
							bbb = this.Math.rand(3, 4);
							for( local i = 0; i < bbb; i = ++i )
							{
								pp.Entities.push({
									ID = this.Const.EntityType.SkeletonBoss,
									Variant = 0,
									Row = 0,
									Script = moba,
									Faction = this.Const.Faction.Enemy
								});
							}
						}

						this.World.State.startScriptedCombat(pp, false, false, false);
						return 0;
					}
				},
				{
					Text = "We will do an easy and safe side job.",
					function getResult()
					{
						return "SideJobEndd";
					}
				},
				{
					Text = "We\'re not doing this.",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.xxarena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}
				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}
		});
		this.m.Screens.push({
			ID = "SideJobEndd",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_72.png[/img]{Members of the %companyname% helped out at a nearby {pig farm | stable | cowshed}. They had a hard time with the foul smell of filth and hard labor. | Members of the %companyname% sweep and polish throughout the day, running errands and chores for the guild. | Members of the %companyname% have spent an exhausting and irritating time running errands and guarding the brothel. | Members of the %companyname% did hard manual labor on a nearby farm. | The town was large and prosperous, but there was always a lack of hands for the dirty and hard work. Members of %companyname% earned a small amount by doing hard odd jobs. %randombrother% grumbled annoyedly%SPEECH_ON%{I didn\'t become a mercenary to do this damn thing... | I want to stop doing this fucking shit and do some mercenary work! | Damn, give me some real work instead of this!}%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "That\'s enough.",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.xxarena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					local rr = this.Math.rand(1, 50)
					if (rr == 1)
					{
						bro.worsenMood(1, "was disappointed with this")
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
					else
					if (rr == 2)
					{
						bro.worsenMood(this.Math.rand(1, 3), "was furious with the company\'s decision")
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
					else
					if (rr == 3)
					{
						local effect = this.new("scripts/skills/effects_world/exhausted_effect");
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName() + " is exhausted"
						});
					}
					else
					if (rr == 4)
					{
						local effect = this.new("scripts/skills/effects_world/hangover_effect");
						effect.m.Name = "Overworked";
						effect.m.Description = "This character has recently been overworked and has muscle pain";
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName() + " is overworked"
						});
					}
					else
					if (rr == 5)
					{
						local injury;
						if (this.Math.rand(1, 100) <= 50)
						{
							injury = bro.addInjury(this.Const.Injury.Brawl);
						}
						else
						{
							injury = bro.addInjury(this.Const.Injury.PiercingBody);
						}
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = bro.getName() + " suffers " + injury.getNameOnly()
						});
					}
				}
				local gmoney = this.Math.rand(10, 150);
				this.World.Assets.addMoney(gmoney);
				this.List.push({
					id = 10,
					icon = "ui/items/supplies/money.png",
					text = "Earned [color=#56e64c]" + gmoney + "[/color] crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "Far from Town",
			Text = "[img]gfx/ui/events/event_22.png[/img]{Mission successfully completed. Collect trophy to prove mission success and prepare to return to the adventurer\'s guild.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "It\'s time to go back to town",
					function getResult()
					{
						local bc = this.World.Statistics.getFlags().getAsInt("XXADVWIN");
						this.World.Statistics.getFlags().increment("XXADVWIN", 1);
						this.World.Statistics.getFlags().increment("XXADVWINB", 1);
						if (bc <= 7 || this.Math.rand(1, 100) <= 80)
						{
							return "GoalEndd";
						}
						else
						if (this.Math.rand(1, 100) <= 50)
						{
							return "Fight0";
						}
						else
						{
							return "FightA0";
						}
					}
				}
			]
		});
		this.m.Screens.push({
			ID = "Fight0",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{A group of armed men block your path. They say you ruined their business and want you to hand over the trophy. | A group of armed men step out onto the road. One of them points at the trophy.%SPEECH_ON%How dare you touch our prey? I\'ll let you go this time, so drop the trophy and get out!%SPEECH_OFF% | A sharp whistle draws the attention of you and your men. You turn to the side of the road to see a group of men emerging from some bushes. Everyone draws their weapons, but the strangers don\'t move a foot further. Their ringleader steps forward.%SPEECH_ON%Hello fellas. We here are bounty hunters, if you couldn\'t tell, and I do believe you have one of our bounties. Now if you could please hand it over, that\'d sit pretty well with me and my friends.%SPEECH_OFF%Tapping the hilt of his sword, the man grins.%SPEECH_ON%It\'s only a matter of business. I\'m sure you understand.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "If you want it, come and take it!",
					function getResult()
					{
						return "Fight1";
					}

				},
				{
					Text = "It\'s not worth dying over. Take that damn the trophy and be gone.",
					function getResult()
					{
						return "Fight2Endd";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Fight1",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{They don\'t want to talk anymore. A battle seems inevitable.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare for battle!",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Fightbattle";
						p.Music = this.Const.Music.NobleTracks;
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						local btile = this.Contract.getTileToSpawnLocation(this.World.State.getPlayer().getTile(), 10, 80, [
							this.Const.World.TerrainType.Ocean,
							this.Const.World.TerrainType.Shore,
							this.Const.World.TerrainType.Mountains
						], false);
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[btile.TacticalType];
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						if (this.Math.rand(1, 100) <= 50)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BanditRaiders, 360 * this.Math.rand(1, 2) * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						}
						else
						if (this.Math.rand(1, 100) <= 50)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BountyHunters, 360 * this.Math.rand(1, 2) * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						}
						else
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Mercenaries, 360 * this.Math.rand(1, 2) * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						}
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Fight2Endd",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{Not wanting a fight, you hand the trophy over. They laugh at you as you leave.%SPEECH_ON%A wise choice, loser!%SPEECH_OFF% | The trophy is not as valuable as the lives of your men. You hand over the trophy with a hard expression.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Damn it!",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.xxarena").refreshCooldown();
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FightWin",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_22.png[/img]{The enemies routed and fled. It\'s time to go back to town. | You have killed every enemy who tried to steal the trophy. It\'s time to go back to town.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Come on, let\'s hurry!",
					function getResult()
					{
						return "GoalEndd";
					}
				}
			],
			function start()
			{
				local fightmoney = this.Math.rand(100, 900);
				this.World.Assets.addMoney(fightmoney);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + fightmoney + " crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "FightA0",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_120.png[/img]{On your way back to town, an unknown woman stopped you.%SPEECH_ON%Greeting. I came to hear the news of your success. Won\'t you sell me that trophy you have? The price is twice the condition stated in the guild.%SPEECH_OFF% | On your way back to town, a mysterious woman blocks your way.%SPEECH_ON%Mercenary, why don\'t you use that trophy you have for something more valuable? If you sell it to me, I'll give you double the conditions suggested by the guild.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Double money? the more money, the better",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "FightA1Endd";
						}
						else
						{
							return "FightA2Endd";
						}
					}

				},
				{
					Text = "Not interesting",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "FightA3";
						}
						else
						{
							return "GoalEndd";
						}
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FightA1Endd",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{When the woman was handed over the trophy, she paid double price and disappeared. Today is lucky day.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "I wish every day was the same as today",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.xxarena").refreshCooldown();
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				local fightmoney = this.Math.floor(this.Contract.m.Payment.getOnCompletion() * 2);
				this.World.Assets.addMoney(fightmoney);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + fightmoney + " crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "FightA2Endd",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_12.png[/img]{She disappeared like smoke without paying for it. What could it have been? Witch? Hexen? Geist? The important thing is that you lost the trophy and get nothing in return.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Fucking bitch!",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.xxarena").refreshCooldown();
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FightA3",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_69.png[/img]{The woman\'s expression contorts viciously as you decline her offer.%SPEECH_ON%How dare you decline my offer? then die here%SPEECH_OFF%As soon as she cast the spell, a group of monsters appeared.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Prepare for battle!",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Fightbattle";
						p.Music = this.Const.Music.BeastsTracks;
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						local btile = this.Contract.getTileToSpawnLocation(this.World.State.getPlayer().getTile(), 10, 80, [
							this.Const.World.TerrainType.Ocean,
							this.Const.World.TerrainType.Shore,
							this.Const.World.TerrainType.Mountains
						], false);
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[btile.TacticalType];
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						if (this.Math.rand(1, 100) <= 50)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Direwolves, 360 * this.Math.rand(1, 2) * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						}
						else
						if (this.Math.rand(1, 100) <= 50)
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Ghouls, 360 * this.Math.rand(1, 2) * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						}
						else
						{
							this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BanditsDisguisedAsDirewolves, 360 * this.Math.rand(1, 2) * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						}
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "GoalEndd",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_62.png[/img]{Returning to the town, you visited the guild and received a fair reward.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "It\'s hard but worth it",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.xxarena").refreshCooldown();
						this.World.Contracts.finishActiveContract();
						return 0;
					}
				}
			],
			function start()
			{
				if (this.World.Statistics.getFlags().getAsInt("XXADVWINB") >= 7)
				{
					this.World.Statistics.getFlags().increment("XXADVWINB", -7);
					local weapons = [
						"helmets/named/gold_and_black_turban",
						"helmets/named/golden_feathers_helmet",
						"helmets/named/heraldic_mail_helmet",
						"helmets/named/lindwurm_helmet",
						"helmets/named/named_conic_helmet_with_faceguard",
						"helmets/named/named_metal_bull_helmet",
						"helmets/named/named_metal_nose_horn_helmet",
						"helmets/named/named_metal_skull_helmet",
						"helmets/named/named_nordic_helmet_with_closed_mail",
						"helmets/named/named_steppe_helmet_with_mail",
						"helmets/named/nasal_feather_helmet",
						"helmets/named/norse_helmet",
						"helmets/named/red_and_gold_band_helmet",
						"helmets/named/sallet_green_helmet",
						"helmets/named/red_and_gold_band_helmet",
						"helmets/named/wolf_helmet",
						"armor/named/black_and_gold_armor",
						"armor/named/black_leather_armor",
						"armor/named/blue_studded_mail_armor",
						"armor/named/brown_coat_of_plates_armor",
						"armor/named/golden_scale_armor",
						"armor/named/green_coat_of_plates_armor",
						"armor/named/heraldic_mail_armor",
						"armor/named/leopard_armor",
						"armor/named/lindwurm_armor",
						"armor/named/named_bronze_armor",
						"armor/named/named_golden_lamellar_armor",
						"armor/named/named_noble_mail_armor",
						"armor/named/named_plated_fur_armor",
						"armor/named/named_sellswords_armor",
						"armor/named/named_skull_and_chain_armor",
						"shields/named/named_bandit_heater_shield",
						"shields/named/named_bandit_kite_shield",
						"shields/named/named_dragon_shield",
						"shields/named/named_full_metal_heater_shield",
						"shields/named/named_golden_round_shield",
						"shields/named/named_lindwurm_shield",
						"shields/named/named_orc_heavy_shield",
						"shields/named/named_red_white_shield",
						"shields/named/named_rider_on_horse_shield",
						"shields/named/named_sipar_shield",
						"shields/named/named_undead_heater_shield",
						"shields/named/named_undead_kite_shield",
						"shields/named/named_wing_shield"
					];
					this.World.Assets.getStash().makeEmptySlots(2);
					local item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					if (this.Math.rand(1, 100) <= 90)
					{
						item = this.new("scripts/items/misc/xxsbook_sp");
					}
					else
					{
						item = this.new("scripts/items/special/fountain_of_youth_item");
					}
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
				this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + this.Contract.m.Payment.getOnCompletion() + " crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "FailureEndd",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_88.png[/img]{Quest failed. Rewards cannot be received.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Damn it!",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.xxarena").refreshCooldown();
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function setScreenForArena()
	{
		if (!this.m.IsActive)
		{
			return;
		}
		if (this.World.getTime().Days > this.m.Flags.get("Day"))
		{
			this.setScreen("FailureEndd");
		}
		else
		{
			this.setScreen("Start");
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.m.Home.getSprite("selection").Visible = false;
			this.m.Home.getBuilding("building.xxarena").refreshCooldown();
		}
	}

	function onSerialize( _out )
	{
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
	}

});

