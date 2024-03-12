this.fantasy_monster_encounter_3_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_3_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 200 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_22.png[/img]{A group of warriors are fighting against hordes of monsters to protect the people. The number of monsters was huge, but they were fighting among themselves, so the warriors could barely hold on. One of the people has spotted your mercenaries and calls for help.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.CombatID = "Event";
						pp.Music = this.Const.Music.NobleTracks;
						pp.IsAutoAssigningBases = false;
						if (this.Math.rand(1, 100) <= 25)
						{
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						}
						else
						{
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						}
						pp.Entities = [];
						for( local i = 0; i < 1; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/enemies/xxmob_battlemaster",
								Faction = this.Const.Faction.PlayerAnimals
							});
						}
						local xtroops = [
							this.Const.World.Spawn.UndeadScourge,
							this.Const.World.Spawn.NecromancerSouthern,
							this.Const.World.Spawn.Zombies,
							this.Const.World.Spawn.Vampires,
							this.Const.World.Spawn.UndeadArmy,
							this.Const.World.Spawn.GreenskinHorde,
							this.Const.World.Spawn.OrcBoss,
							this.Const.World.Spawn.GoblinBoss,
							this.Const.World.Spawn.Direwolves,
							this.Const.World.Spawn.Ghouls,
							this.Const.World.Spawn.Lindwurm,
							this.Const.World.Spawn.Unhold,
							this.Const.World.Spawn.UnholdFrost,
							this.Const.World.Spawn.UnholdBog
						];
						this.Const.World.Common.addUnitsToCombat(pp.Entities, this.Const.World.Spawn.Mercenaries, 100, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Settlement).getID());
						this.Const.World.Common.addUnitsToCombat(pp.Entities, xtroops.remove(this.Math.rand(0, xtroops.len() - 1)), this.Math.rand(250, 350), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.Const.World.Common.addUnitsToCombat(pp.Entities, xtroops.remove(this.Math.rand(0, xtroops.len() - 1)), this.Math.rand(250, 350), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
						this.Const.World.Common.addUnitsToCombat(pp.Entities, xtroops.remove(this.Math.rand(0, xtroops.len() - 1)), this.Math.rand(250, 350), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID());
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}

				},
				{
					Text = "No reason to take risk. Retreat!",
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
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_04.png[/img]{After the battle was won, the survivors offered a substantial amount of gold as a token of gratitude.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It was worth it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				local xxmoney = this.Math.rand(1000, 5000);
				this.World.Assets.addMoney(xxmoney);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + xxmoney + " gold"
				});
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_88.png[/img]{Your party was defeated and managed to escape.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Damn it!",
					function getResult( _event )
					{
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
		if (this.World.getTime().Days < 120)
		{
			return;
		}
		if (this.World.Flags.get("FantasyMonsterEncounter") == 1)
		{
			local currentTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();
			foreach( t in towns )
			{
				if (t.getTile().getDistanceTo(currentTile) <= 3)
				{
					return;
				}
			}
		}
		else
		{
			return;
		}
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

