this.xxdarkstartown_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.xxdarkstartown_enter_event";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_154.png[/img]{A long time ago, there was a large city with a brilliant civilization. The city prospered for a long time, but was destroyed by a dark star that fell from the sky. Currently, only a group of lunatics who serve the Dark Star remain here.}",
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
						pp.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						pp.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
						pp.TerrainTemplate = "tactical.quarry";
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
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 0,
							Script = "scripts/entity/tactical/enemies/xxmob_cosmicsummoner",
							Faction = this.Const.Faction.Enemy
						});
						for( local i = 0; i < 3; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/enemies/bandit_thug",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 3,
								Script = "scripts/entity/tactical/enemies/bandit_raider_low",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 4,
								Script = "scripts/entity/tactical/enemies/bandit_raider",
								Faction = this.Const.Faction.Enemy
							});
						}
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
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}
		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_154.png[/img]{The fierce battle is over. You and your companions have scoured the area for valuables. After collecting all the valuables, the party decided to leave.}",
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
				local item = this.new("scripts/items/misc/xxmysteriouspotion");
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

