this.xxblackdragontown_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.xxblackdragontown_enter_event";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_50.png[/img]{A gigantic and violent creature, the Black Dragon is one of the most vicious creatures. One of the most threatening creatures of late is the Black Dragon, a huge and ferocious ancient creature. He possesses high intelligence and boundless hostility towards humans, and has amassed an army of his own. Allied forces have rallied to thwart his world-destroying ambitions. Elite warriors and your army will face off against the Black Dragon while the Allies battle the forces of evil.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Prepare for Battle!",
					function getResult( _event )
					{					
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.CombatID = "Event";
						pp.Music = this.Const.Music.NobleTracks;
						pp.IsAutoAssigningBases = false;
						pp.IsLootingProhibited = true;
						pp.IsWithoutAmbience = true;
						pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						pp.BeforeDeploymentCallback = function ()
						{
							local size = this.Tactical.getMapSize();
							for( local x = 0; x < size.X; x = ++x )
							{
								for( local y = 0; y < size.Y; y = ++y )
								{
									local tile = this.Tactical.getTileSquare(x, y);
									if (this.Math.rand(1, 100) <= 50)
									{
										tile.removeObject();
										tile.clear();
										tile.Level = this.Math.min(0, tile.Level);
									}
									else
									{
										tile.Level = this.Math.min(1, tile.Level);
									}
								}
							}
						};
						if (this.Const.DLC.Desert)
						{
							pp.IsArenaMode = true;
							this.Const.Sound.Volume.Arena = 0;
							this.Const.Sound.ArenaStart = [ "sounds/cloth_01.wav" ];
							this.Const.Sound.ArenaEnd = [ "sounds/cloth_01.wav" ];
							this.Const.Sound.ArenaOutro = [ "sounds/cloth_01.wav" ];
						}
						pp.Entities = [];

						for( local i = 0; i < 3; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row =0,
								Script = "scripts/entity/tactical/enemies/orc_warrior",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row =0,
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
								Row = 1,
								Script = "scripts/entity/tactical/enemies/xxmob_orclong",
								Faction = this.Const.Faction.Enemy
							});
						}
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 1,
							Script = "scripts/entity/tactical/enemies/goblin_leader",
							Faction = this.Const.Faction.Enemy
						});
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 1,
							Script = "scripts/entity/tactical/enemies/orc_warlord",
							Faction = this.Const.Faction.Enemy
						});
						for( local i = 0; i < 2; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/zombie_treasure_hunter",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/vampire",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/xxmob_vampguard",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/goblin_ambusher",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 9,
								Script = "scripts/entity/tactical/enemies/goblin_wolfrider",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 9,
								Script = "scripts/entity/tactical/enemies/xxmob_goblin",
								Faction = this.Const.Faction.Enemy
							});
						}
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/xxmob_vamp",
							Faction = this.Const.Faction.Enemy
						});
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/xxmob_hellranger",
							Faction = this.Const.Faction.Enemy
						});
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/xxmob_elemental",
							Faction = this.Const.Faction.Enemy
						});
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/xxmob_abomi",
							Faction = this.Const.Faction.Enemy
						});
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 3,
							Script = "scripts/entity/tactical/enemies/xxmob_blackdragon",
							Faction = this.Const.Faction.Enemy
						});

						///

						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 0,
							Script = "scripts/entity/tactical/enemies/xxmob_horseman_b",
							Faction = this.Const.Faction.PlayerAnimals
						});
						for( local i = 0; i < 4; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/xxmob_horseman_a",
								Faction = this.Const.Faction.PlayerAnimals
							});
						}
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 1,
							Script = "scripts/entity/tactical/humans/swordmaster",
							Faction = this.Const.Faction.PlayerAnimals
						});
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 1,
							Script = "scripts/entity/tactical/humans/hedge_knight",
							Faction = this.Const.Faction.PlayerAnimals
						});
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/humans/master_archer",
							Faction = this.Const.Faction.PlayerAnimals
						});
						for( local i = 0; i < 2; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/militia_captain",
								Faction = this.Const.Faction.PlayerAnimals
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/bounty_hunter_ranged",
								Faction = this.Const.Faction.PlayerAnimals
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/mercenary_ranged",
								Faction = this.Const.Faction.PlayerAnimals
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/militia_veteran",
								Faction = this.Const.Faction.PlayerAnimals
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/xxmob_battlemaster",
								Faction = this.Const.Faction.PlayerAnimals
							});
						}
						_event.registerToShowAfterCombat("VictoryA", "Defeat");
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
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}
		});
		this.m.Screens.push({
			ID = "VictoryA",
			Text = "[img]gfx/ui/events/event_26.png[/img]{The evil beast that tried to destroy mankind has been slain. The few surviving enemies fled, and a victory party and rewards were set up for the heroes. When the party is in full swing, a high elf who was impressed by your mercenaries expresses interest in joining your group.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to join. (Need an empty slot in your mercenary roster)",
					function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							return "VictoryB";
						}
						else
						{
							return "VictoryC";
						}
					}
				},
				{
					Text = "No, I don\'t want strangers in our group.",
					function getResult( _event )
					{
						return "VictoryC";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
				}
			}

		});
		this.m.Screens.push({
			ID = "VictoryB",
			Text = "[img]gfx/ui/events/event_04.png[/img]{Eat and drink enough beer and food to wash away the fatigue of battle. After getting enough rest, your party receives the rewards of the battle and sets off on the next journey.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It was worth it.",
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
				xxlonexx.setStartValuesEx([
					"xxherohighelf_background"
				]);
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

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/accessory/xxgoldtrophy");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.addMoney(200000);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain 200000 gold"
				});
				this.List.push({
					id = 12,
					icon = "ui/perks/perk_28_active.png",
					text = "A new brother joins the party"
				});
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					bro.improveMood(10, "Morale has risen.");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
				return 0;
			}
		});

		this.m.Screens.push({
			ID = "VictoryC",
			Text = "[img]gfx/ui/events/event_04.png[/img]{Eat and drink enough beer and food to wash away the fatigue of battle. After getting enough rest, your party receives the rewards of the battle and sets off on the next journey.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It was worth it.",
					function getResult( _event )
					{
						this.Const.Sound.Volume.Arena = 0.6;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/accessory/xxgoldtrophy");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 11,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.addMoney(200000);
				this.List.push({
					id = 12,
					icon = "ui/items/supplies/money.png",
					text = "You gain 200000 gold"
				});
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					bro.improveMood(10, "Morale has risen.");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_88.png[/img]{What the hell is this place? Seeing an escape opportunity, you decide to run away from this place.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Shouldn\'t have come here...",
					function getResult( _event )
					{
						this.Const.Sound.Volume.Arena = 0.6;
						return 0;
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
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

