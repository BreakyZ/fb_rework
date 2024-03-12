this.fantasy_monster_encounter_2_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_2_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_60.png[/img]{In the distance, you spot people being attacked by hordes of unknown monsters. Unfortunately, most have already lost their lives and only a handful of survivors are dying screaming in agony. It\'s too late to save them, but defeating the monsters will save their luggage and valuables. Or better run away when the monsters aren\'t paying attention to your mercenaries.}",
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
						if (this.Math.rand(1, 100) <= 25)
						{
							pp.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
							pp.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						}
						pp.Entities = [];
						local moba;
						moba = [
							"scripts/entity/tactical/enemies/xxmob_lizard",
							"scripts/entity/tactical/enemies/xxmob_slime_b",
							"scripts/entity/tactical/enemies/xxmob_spiderdemon",
							"scripts/entity/tactical/enemies/xxmob_toad",
							"scripts/entity/tactical/enemies/xxmob_lion",
							"scripts/entity/tactical/enemies/xxmob_bloodsucker",
							"scripts/entity/tactical/enemies/xxmob_liger",
							"scripts/entity/tactical/enemies/xxmob_orchunter"
						];
						moba = moba[this.Math.rand(0, moba.len() - 1)];
						for( local i = 0; i < this.Math.rand(5, 8); i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = moba,
								Faction = this.Const.Faction.Enemy
							});
						}
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}

				},
				{
					Text = "Retreat!",
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
			Text = "[img]gfx/ui/events/event_112.png[/img]{After a fierce battle, your mercenaries have won. The victims are all dead, but their luggage and valuables are unharmed.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s take what can be money and leave this place",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				local xxmoney = this.Math.rand(500, 1000);
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
		if (this.World.getTime().Days < 50)
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

