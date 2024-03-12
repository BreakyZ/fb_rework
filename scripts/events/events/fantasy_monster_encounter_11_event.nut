this.fantasy_monster_encounter_11_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight1 = null,
		Mname = ""
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_11_event";
		this.m.Title = "During camp...";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%hedgeknight1% walks up to you.%SPEECH_ON%Boss, I recently heard that another mercenary group, \'%mname%\' needs me. They\'ve offered to pay me 1.5 times more than my current wage. I like this life, but I want to go somewhere that needs me more, Boss. It\'s time to say goodbye.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Respect %hedgeknight1%\'s decision to leave",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 37)
						{
							return "B1";
						}
						else
						{
							return "B2";
						}
					}

				},
				{
					Text = "2x pay to keep %hedgeknight1% from leaving",
					function getResult( _event )
					{
						return "B3";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_64.png[/img]{You wanted to dissuade him, but instead, you decided to respect his choice by requesting a handshake.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Farewell!",
					function getResult( _event )
					{
						_event.m.HedgeKnight1.getItems().transferToStash(this.World.Assets.getStash());
						_event.m.HedgeKnight1.getSkills().onDeath(this.Const.FatalityType.None);
						this.World.getPlayerRoster().remove(_event.m.HedgeKnight1);
						_event.m.HedgeKnight1 = null;
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/kills.png",
					text = _event.m.HedgeKnight1.getName() + " leaves the " + this.World.Assets.getName()
				});
			}
		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_64.png[/img]{When you respect %hedgeknight1%\'s decision and permit him to leave %companyname%, %hedgeknight1% awkwardly smiles and says.%SPEECH_ON%Well, on second thought, I\'ve changed my mind. I\'m canceling my decision to leave %companyname%, Boss.%SPEECH_OFF%After the conversation, %hedgeknight1% grumbles and walks away from you.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A swindler like that bastard...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				_event.m.HedgeKnight1.worsenMood(this.Math.rand(2, 3), "Was denied a pay raise");
				if (_event.m.HedgeKnight1.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.HedgeKnight1.getMoodState()],
						text = _event.m.HedgeKnight1.getName() + this.Const.MoodStateEvent[_event.m.HedgeKnight1.getMoodState()]
					});
				}
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B3",
			Text = "[img]gfx/ui/events/event_64.png[/img]{When you proposed 2x pay, %hedgeknight1% smiled widely and pledged to remain loyal to %companyname% in the future as well.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good choice",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				_event.m.HedgeKnight1.getBaseProperties().Bravery += 1;
				_event.m.HedgeKnight1.getBaseProperties().DailyWage += (_event.m.HedgeKnight1.getDailyCost() * 1) + 1;
				_event.m.HedgeKnight1.improveMood(2.0, "Received a pay raise");
				_event.m.HedgeKnight1.getSkills().update();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.HedgeKnight1.getName() + " is now paid " + _event.m.HedgeKnight1.getDailyCost() + " crowns a day"
				});
				this.List.push({
					id = 11,
					icon = "ui/icons/bravery.png",
					text = _event.m.HedgeKnight1.getName() + "\'s Bravery increased by +1"
				});
				if (this.Math.rand(1, 100) <= 50)
				{
					local xtrait = this.new("scripts/skills/traits/loyal_trait");
					_event.m.HedgeKnight1.getSkills().add(xtrait);
					this.List.push({
						id = 12,
						icon = xtrait.getIcon(),
						text = _event.m.HedgeKnight1.getName() + " gets loyal"
					});
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
		if (this.World.Flags.get("FantasyMonsterEncounter") != 1)
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local rr = 3;
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("trait.loyal"))
			{
				continue;
			}

			if (bro.getLevel() < 5)
			{
				continue;
			}

			if (bro.getSkills().hasSkill("effects.xxzzfantasy_skill"))
			{
				candidates.push(bro);
			}
		}
		if (candidates.len() < rr)
		{
			return;
		}
		rr = this.Math.rand(0, candidates.len() - 1);
		this.m.HedgeKnight1 = candidates[rr];
		candidates.remove(rr);
		local mname = this.Const.Strings.MercenaryCompanyNames;
		mname.push("Devil Dogs");
		mname.push("War Pigs");
		mname.push("Blood Raven");
		mname.push("Band of the Falcon");
		mname.push("Steel Wolves");
		mname.push("Lion Company");
		mname.push("Chimera Squad");
		mname.push("Blood Union Pack");
		mname.push("Free Merchants Guild");
		this.m.Mname = mname[this.Math.rand(0, mname.len() - 1)];
		this.m.Score = 5;
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
		_vars.push([
			"mname",
			this.m.Mname
		]);
	}

	function onClear()
	{
		this.m.HedgeKnight1 = null;
	}

});

