this.xxknighttown_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.xxknighttown_enter_event";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_78.png[/img]{This region has fertile land and a merciful monarch, making the people happy. There were many enemies who were aiming for this fertile land, but the lord and the people overcame the ordeal with one heart. Unfortunately, the Order of the Griffin, called the strongest Knights on the continent, invaded this land. The lord and the people have asked you for help to defeat them. Are you ready to make your worst enemy for a little sympathy and valuable material rewards?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We will protect your people",
					function getResult( _event )
					{
						return "AA";
					}
				},
				{
					Text = "Nonsense! We can\'t take this risk",
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
			ID = "AA",
			Text = "[img]gfx/ui/events/event_78.png[/img]{The lord and his people are very grateful for your courageous decision. Now is the time to prepare for the great battle. Do you want to go into battle with them? Or would you only go out with your troops?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s defeat the enemy together",
					function getResult( _event )
					{
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.CombatID = "Event";
						pp.Music = this.Const.Music.NobleTracks;
						pp.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						if (this.Math.rand(1, 3) == 1)
						{
							pp.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
						}
						pp.TerrainTemplate = "tactical.steppe";
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
									tile.Level = this.Math.min(1, tile.Level);
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
						for( local i = 0; i < 10; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/xxmob_horseman_a",
								Faction = this.Const.Faction.PlayerAnimals
							});
						}
						for( local i = 0; i < 3; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/humans/bounty_hunter",
								Faction = this.Const.Faction.PlayerAnimals
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/humans/militia_veteran",
								Faction = this.Const.Faction.PlayerAnimals
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/militia_captain",
								Faction = this.Const.Faction.PlayerAnimals
							});
						}
						for( local i = 0; i < 2; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/master_archer",
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
							Script = "scripts/entity/tactical/enemies/xxmob_battlemaster",
							Faction = this.Const.Faction.PlayerAnimals
						});

						for( local i = 0; i < 8; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 3,
								Script = "scripts/entity/tactical/enemies/xxmob_horseman_b",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 4,
								Script = "scripts/entity/tactical/enemies/xxmob_horseman_b",
								Faction = this.Const.Faction.Enemy
							});
						}
						_event.registerToShowAfterCombat("VictoryA", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				},

				{
					Text = "We have enough troops to defeat them. You and your men focus on defense.",
					function getResult( _event )
					{
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.CombatID = "Event";
						pp.Music = this.Const.Music.NobleTracks;
						pp.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						if (this.Math.rand(1, 3) == 1)
						{
							pp.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
						}
						pp.TerrainTemplate = "tactical.steppe";
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
									tile.Level = this.Math.min(1, tile.Level);
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
						for( local i = 0; i < 8; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 3,
								Script = "scripts/entity/tactical/enemies/xxmob_horseman_b",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 4,
								Script = "scripts/entity/tactical/enemies/xxmob_horseman_b",
								Faction = this.Const.Faction.Enemy
							});
						}
						_event.registerToShowAfterCombat("VictoryB", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "VictoryA",
			Text = "[img]gfx/ui/events/event_87.png[/img]{You have triumphed against the greatest army in history. The lord and his people praise you for your deeds. This battle will be remembered forever. But what is more important to a mercenary is a reward worthy of it.}",
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
				_event.m.Title = "After the battle...";
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/accessory/xxsilvertrophy");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 12,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.addMoney(5000);
				this.List.push({
					id = 14,
					icon = "ui/items/supplies/money.png",
					text = "You gain 5000 gold"
				});
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					bro.improveMood(1.5, "Morale has risen.");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
				}
			}

		});
		this.m.Screens.push({
			ID = "VictoryB",
			Text = "[img]gfx/ui/events/event_24.png[/img]{You have won the greatest army in history without any help. The lord and his people praise you for your deeds. This battle will be remembered forever. But what is more important to a mercenary is a reward worthy of it.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Received more rewards than promised.",
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
				this.World.Assets.getStash().makeEmptySlots(3);
				local item ;
				item = this.new("scripts/items/accessory/xxsilvertrophy");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 12,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/special/spiritual_reward_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 13,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.addMoney(10000);
				this.List.push({
					id = 14,
					icon = "ui/items/supplies/money.png",
					text = "You gain 10000 gold"
				});
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					bro.improveMood(1.5, "Morale has risen.");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
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

