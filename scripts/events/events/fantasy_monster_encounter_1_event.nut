this.fantasy_monster_encounter_1_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_1_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_146.png[/img]{There are many unknown threats in this world. Warriors that do not dismount from horses, blood sucking monsters, human eating plants, toad larger than humans, etc...\n\nEnabling [color=#04c949]Fantasy Events[/color] will give you a few extra events to make your journey even more exciting. This selection cannot be changed, so please make your decision carefully.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Interesting [color=#04c949](Enable Fantasy Events)[/color]",
					function getResult( _event )
					{
						this.World.Flags.set("FantasyMonsterEncounter", 1);
						return 0;
					}

				},
				{
					Text = "Not interesting [color=#04c949](Disable Fantasy Events)[/color]",
					function getResult( _event )
					{
						this.World.Flags.set("FantasyMonsterEncounter", 0);
						return 0;
					}
				}
			],
			function start( _event )
			{
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 5)
		{
			return;
		}
		this.m.Score = 250000;
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

