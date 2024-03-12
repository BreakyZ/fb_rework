this.fantasy_monster_encounter_19_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_19_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_76.png[/img]{A man wearing a black hood appears in front of you. His face was invisible and he was like a shadow. Soon he spoke in a voice that seemed not of this world.%SPEECH_ON%Your reputation has reached its peak and this is your reward.%SPEECH_OFF%The man disappeared like smoke, leaving behind the medicine. This is truly strange.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What was that just now?",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/misc/xxreputation");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 12,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoralReputation() < 90.0 && this.World.Assets.getMoralReputation() > 9.0)
		{
			return;
		}
		if (this.World.Flags.get("FantasyMonsterEncounter") != 1)
		{
			return;
		}
		this.m.Score = 500;
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

