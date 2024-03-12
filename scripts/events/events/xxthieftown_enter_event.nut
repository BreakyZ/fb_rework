this.xxthieftown_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.xxthieftown_enter_event";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_31.png[/img]{At one time the city was a symbol and hope for the people who rose up against the oppression of the nobility. However, its innocence has disappeared and it is now a fortress for villains.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Prepare for battle",
					function getResult( _event )
					{
						this.World.Events.showCombatDialog(true, true, true);
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
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A"
	}

	function onClear()
	{
	}

});

