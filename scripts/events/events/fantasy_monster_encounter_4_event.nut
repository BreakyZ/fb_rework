this.fantasy_monster_encounter_4_event <- this.inherit("scripts/events/event", {
	m = {
		Champion = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_4_event";
		this.m.Title = "At town...";
		this.m.Cooldown = 150 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A1",
			Text = "[img]gfx/ui/events/event_65.png[/img]{Entering the nearby town, it was crowded with excited crowds. The reason they gathered was because a legal murder festival was taking place while the town leaders and guards were watching. The festival was a \'Deathmatch\' in which one of the two armed men fought until death. Sometimes a festival is better to attend than to just watch. The reason, of course, is the prize money.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local roster = [];

				foreach( bro in brothers )
				{
					roster.push(bro);
				}

				roster.sort(function ( _a, _b )
				{
					if (_a.getXP() > _b.getXP())
					{
						return -1;
					}
					else if (_a.getXP() < _b.getXP())
					{
						return 1;
					}

					return 0;
				});

				local e = this.Math.min(5, roster.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = roster[i];
					this.Options.push({
						Text = bro.getName() + " joins the Deathmatch",
						function getResult( _event )
						{
							_event.m.Champion = bro;
							return "B1";
						}

					});
				}

				this.Options.push({
					Text = "We do not participate",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%chosen% finishes preparing for battle and enters the arena. The crowd laughs, chats and cheers. On the other side you see an armed tough guy. Probably one of the two will never see the sun rise tomorrow.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.Music = this.Const.Music.NobleTracks;
						properties.Entities = [];
						local moba = [
							"scripts/entity/tactical/enemies/bandit_thug",
							"scripts/entity/tactical/enemies/bandit_raider_low",
							"scripts/entity/tactical/enemies/bandit_raider",
							"scripts/entity/tactical/enemies/bandit_raider_wolf",
							"scripts/entity/tactical/enemies/bandit_leader",
							"scripts/entity/tactical/humans/peasant",
							"scripts/entity/tactical/humans/peasant_armed",
							"scripts/entity/tactical/humans/caravan_guard",
							"scripts/entity/tactical/humans/caravan_hand",
							"scripts/entity/tactical/humans/militia",
							"scripts/entity/tactical/humans/militia_captain",
							"scripts/entity/tactical/humans/mercenary_low",
							"scripts/entity/tactical/humans/mercenary",
							"scripts/entity/tactical/humans/bounty_hunter",
							"scripts/entity/tactical/humans/cultist",
							"scripts/entity/tactical/humans/gladiator",
							"scripts/entity/tactical/humans/noble_greatsword",
							"scripts/entity/tactical/humans/noble_sergeant",
							"scripts/entity/tactical/humans/knight",
							"scripts/entity/tactical/humans/hedge_knight",
							"scripts/entity/tactical/humans/swordmaster"
						];
						moba = moba[this.Math.rand(0, moba.len() - 1)];
						properties.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 0,
							Script = moba,
							Faction = this.Const.Faction.Enemy
						});
						properties.Players.push(_event.m.Champion);
						properties.IsUsingSetPlayers = true;
						properties.IsFleeingProhibited = true;
						properties.IsLootingProhibited = true;
						properties.IsWithoutAmbience = true;
						properties.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						properties.LocationTemplate.Template[0] = "tactical.xxtactical_knighttown";
						properties.TerrainTemplate = "tactical.steppe";
						properties.BeforeDeploymentCallback = function ()
						{
							local size = this.Tactical.getMapSize();

							for( local x = 0; x < size.X; x = ++x )
							{
								for( local y = 0; y < size.Y; y = ++y )
								{
									local tile = this.Tactical.getTileSquare(x, y);
									tile.Level = this.Math.min(1, tile.Level);
									if (this.Math.rand(1, 100) <= 25)
									{
										tile.removeObject();
										tile.clear();
									}
								}
							}
						};
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(properties, false, false, false);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Options[0].Text = "You can take him, %chosen%!";
				this.Characters.push(_event.m.Champion.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_58.png[/img]{After %chosen%\'s fatal attack, the man stumbles and falls. He is not breathing and motionless. %chosen% is quite alright, nodding smugly as he sheathes his weapon.%SPEECH_ON%No big deal. I didn\'t break a sweat killing this fucker.%SPEECH_OFF%You don\'t know if it\'s true or not, but one thing is for sure. That he won and received a prize.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You did well, %chosen%.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Champion.getImagePath());
				local xxmoney = this.Math.min(this.World.getTime().Days * 10 + 500, 3000);
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
			Text = "[img]gfx/ui/events/event_12.png[/img]{You helplessly watched as the man cut %chosen%.}",
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
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(2, "was furious at your poor decision");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
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
			local nearTown = false;
			local currentTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();
			foreach( t in towns )
			{
				if (t.getTile().getDistanceTo(currentTile) <= 3 && t.isAlliedWithPlayer())
				{
					nearTown = true;
					break;
				}
			}
			if (!nearTown)
			{
				return;
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
		_vars.push([
			"chosen",
			this.m.Champion != null ? this.m.Champion.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A1";
	}

	function onClear()
	{
		this.m.Champion = null;
	}

});

