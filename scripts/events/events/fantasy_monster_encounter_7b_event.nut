this.fantasy_monster_encounter_7b_event <- this.inherit("scripts/events/event", {
	m = {
		SwornBroA = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_7b_event";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%swornbroa% walks up to you.%SPEECH_ON%I'm weary now, Boss. My sworn brother has also departed, and the life of a mercenary has grown distasteful. I shall retire henceforth. I'll leave my gear here, so do as thou wilt.%SPEECH_OFF%You wanted to dissuade him, but instead, you decided to respect his choice by requesting a handshake.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Farewell!",
					function getResult( _event )
					{
						_event.m.SwornBroA.getItems().transferToStash(this.World.Assets.getStash());
						_event.m.SwornBroA.getSkills().onDeath(this.Const.FatalityType.None);
						this.World.getPlayerRoster().remove(_event.m.SwornBroA);
						_event.m.SwornBroA = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.SwornBroA.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.SwornBroA.getName() + " leaves the " + this.World.Assets.getName()
				});
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 100)
		{
			return;
		}
		if (this.World.Flags.get("FantasyMonsterEncounter") != 1)
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		local check = 0;
		foreach( bro in brothers )
		{
			if (bro.getFlags().has("SwornBrotherS"))
			{
				check = check + 1;
				this.m.SwornBroA = bro;
			}
		}
		if (check != 1)
		{
			return;
		}
		this.m.Score = 100;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"swornbroa",
			this.m.SwornBroA.getName()
		]);
	}

	function onClear()
	{
		this.m.SwornBroA = null;
	}

});

