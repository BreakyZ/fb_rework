this.xxdragontown_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.xxdragontown_enter_event";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_12.png[/img]{Deep scars and burns are visible on the earth. This place where there is no life form and only silence flows, it must be the dragon nest in the stories of the old men. People say the dragons went extinct a long time ago, but the heat is proof that the nest\'s owner stayed there until recently. Soon there was a sound like thunder from the sky, and a great shadow swallowed the earth. If the old tales of the old men are true, the owner of this nest will attack the invaders mercilessly.}",
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
						pp.Music = this.Const.Music.BeastsTracks;
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
						pp.Entities = [];
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 3,
							Script = "scripts/entity/tactical/enemies/xxmob_dragon",
							Faction = this.Const.Faction.Enemy
						});
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
			Text = "[img]gfx/ui/events/event_36.png[/img]{The wounded dragon flew high into the sky in an instant and disappeared. You're sorry you didn't end your battle with that legendary creature, but maybe you're lucky. You had no idea what the outcome would be if you fought to the end. \nYou and your party took a breather and searched the area around the dragon\'s nest to see if anything could be useful. \nYou found an injured knight during the investigation. A giant bear is dead under the feet of a knight in red armor.%SPEECH_ON%Did you kill this beast?%SPEECH_OFF%At your question, the man nodded with a tired expression on his face. The bear\'s corpse was horribly ripped off. The identity of the man is unknown, but only his fighting skills are certain. Would you convince the man to join your party?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s hire him. (Need an empty slot in your mercenary roster)",
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
			Text = "[img]gfx/ui/events/event_35.png[/img]{The man smiles bitterly at your suggestion. \n\n%SPEECH_START%That\'s funny. I never imagined it would turn out like this. Maybe I was too ignorant of humans. I should take this opportunity to study human again.%SPEECH_OFF% \n\nThe man has accepted your request. He will be of great help to our power going forward.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Got a good brother.",
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
				xxlonexx.setStartValuesEx([
					"xxherocrimson_background"
				]);
				xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
				xxlonexx.m.PerkPoints = 1;
				xxlonexx.m.LevelUps = 1;
				xxlonexx.m.Level = 2;
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
				return 0;
			}
		});

		this.m.Screens.push({
			ID = "VictoryC",
			Text = "[img]gfx/ui/events/event_04.png[/img]{After the man left, your party looked around and got some useful stuff.}",
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
				this.World.Assets.addMoney(80000);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain 80000 gold"
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

