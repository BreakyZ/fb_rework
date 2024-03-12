this.fantasy_monster_encounter_17_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_17_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]{A group of armed individuals has gathered. Upon discovering your mercenary band, they eye you with tense expressions. Judging by their meager armament and unsteady stances, they don\'t seem like seasoned bandits. A man who appears to be their representative steps forward and addresses you.%SPEECH_ON%We are those who have risen for justice and equality in this land. Since we have risen up against the greed and discrimination of the nobles, we hope that you will also share 1000 crowns in our cause. Should you refuse, we will judge you in accordance with our cause.%SPEECH_OFF%You could infer from the yellow flags they carried that they were recently formed peasant rebel forces. Known as bandits who seize the wealth of the rich and nobility to distribute it freely among the poor, they have gained significant popularity among the common folk. However, upon encountering them firsthand, things seemed quite different from the stories you had heard}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-5);
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.CombatID = "Event";
						pp.Music = this.Const.Music.CivilianTracks;
						pp.IsAutoAssigningBases = false;
						pp.Entities = [];
						local moba;
						moba = [
							"scripts/entity/tactical/humans/peasant",
							"scripts/entity/tactical/humans/peasant",
							"scripts/entity/tactical/humans/peasant_armed",
							"scripts/entity/tactical/humans/peasant_armed",
							"scripts/entity/tactical/humans/peasant_armed",
							"scripts/entity/tactical/humans/slave_northern",
							"scripts/entity/tactical/humans/slave",
							"scripts/entity/tactical/humans/peasant_southern"
						];
						for( local i = 0; i < 5; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
						}
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				},
				{
					Text = "I will accept your request",
					function getResult( _event )
					{
						this.World.Assets.addMoney(-1000);
						this.World.Assets.addMoralReputation(5);
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
			Text = "[img]gfx/ui/events/event_22.png[/img]{You emerged victorious in the battle. One dying rebel, amidst his last breaths, cursed that this wouldn\'t be the end and that his brethren would surely seek vengeance. %randombrother% put an end to his suffering.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You should have chosen your opponent more wisely",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				local xxmoney = this.Math.rand(100, 500);
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
			Text = "[img]gfx/ui/events/event_88.png[/img]{You were defeated in battle and barely managed to escape with your life.}",
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
		if (this.World.Assets.getMoney() < 1000)
		{
			return;
		}
		if (this.World.Flags.get("FantasyMonsterEncounter") != 1)
		{
			return;
		}
		this.m.Score = 3;
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

