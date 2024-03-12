this.fantasy_monster_encounter_15_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight1 = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_15_event";
		this.m.Title = "At town...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_92.png[/img]{While resting in a nearby village, %hedgeknight1% and several like-minded brothers performed for the villagers. Fortunately, the performance of these art-loving friends was well received by the village people. The villagers rewarded the great performance.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "These guys have talent.",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
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
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					bro.improveMood(1, "Was feeling better");
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[bro.getMoodState()],
						text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
					});
				}
				local xxmoney = this.Math.rand(100, 500);
				this.World.Assets.addMoney(xxmoney);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + xxmoney + " crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_65.png[/img]{As the performance neared its crescendo, %hedgeknight1% became excited and shouted loudly to the crowd.%SPEECH_ON%Ladies and gentlemen, this is not the end. Highlight of today\'s performance! The most dangerous stunt in the world! To be, or not to be, that is the question!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sounds fun. Go ahead!",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}
				},
				{
					Text = "Hey, stop being dangerous! It\'s an order!",
					function getResult( _event )
					{
						_event.m.HedgeKnight1.worsenMood(2, "Was feeling worse");
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_85.png[/img]{%hedgeknight1%\'s life-threatening performance began with people cheering. When the performance that made the audience very nervous ended successfully, thunderous cheers and applause erupted.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You\'re the best!",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				local r = 3;
				_event.m.HedgeKnight1.getBaseProperties().MeleeSkill += r;
				_event.m.HedgeKnight1.getBaseProperties().RangedSkill += r;
				_event.m.HedgeKnight1.getBaseProperties().MeleeDefense += r;
				_event.m.HedgeKnight1.getBaseProperties().RangedDefense += r;
				_event.m.HedgeKnight1.getBaseProperties().Hitpoints += r;
				_event.m.HedgeKnight1.getBaseProperties().Stamina += r;
				_event.m.HedgeKnight1.getBaseProperties().Initiative += r;
				_event.m.HedgeKnight1.getBaseProperties().Bravery += r;
				_event.m.HedgeKnight1.getSkills().update();
				this.List.push({
					id = 11,
					icon = "ui/icons/plus.png",
					text = _event.m.HedgeKnight1.getName() + "\'s all stats increased by +3"
				});
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_12.png[/img]{%hedgeknight1%\'s life-threatening performance began with people cheering. %hedgeknight1%\'s close performance ended in disaster when he lost his balance and fell. People screamed in horror at the tragic ending of the performance.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "No!",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local fallen = {
					Name = _event.m.HedgeKnight1.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, _event.m.HedgeKnight1.getDaysWithCompany()),
					Kills = _event.m.HedgeKnight1.getLifetimeStats().Kills,
					Battles = _event.m.HedgeKnight1.getLifetimeStats().Battles,
					KilledBy = "Died recklessly",
					Expendable = false
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 10,
					icon = "ui/icons/kills.png",
					text = _event.m.HedgeKnight1.getName() + " has died"
				});
				_event.m.HedgeKnight1.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.HedgeKnight1.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.HedgeKnight1);
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 10)
		{
			return;
		}

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

		local brothers = this.World.getPlayerRoster().getAll();
		local xsong = [];
		local xdance = [];
		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkill("trait.player") && bro.getBackground().getID() == "background.minstrel")
			{
				xsong.push(bro);
			}
			if (!bro.getSkills().hasSkill("trait.player") && bro.getBackground().getID() == "background.juggler")
			{
				xdance.push(bro);
			}
		}
		if (xsong.len() < 1)
		{
			return;
		}
		if (xdance.len() < 1)
		{
			return;
		}
		this.m.HedgeKnight1 = xdance[this.Math.rand(0, xdance.len() - 1)];
		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hedgeknight1",
			this.m.HedgeKnight1.getName()
		]);
	}

	function onClear()
	{
		this.m.HedgeKnight1 = null;
	}

});

