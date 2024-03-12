this.fantasy_monster_encounter_14_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight1 = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_14_event";
		this.m.Title = "At town...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]{In a recently visited village, there were tragic incidents where {village people | girls | women | children} were brutally murdered. Some people seem to believe that this was done by outsiders, your mercenaries. You didn\'t feel the need to explain things to people. Such misunderstanding and notoriety is a fate that any mercenary company must willingly endure. But you\'ve had something on your mind lately. You thought of a few members who had been acting suspiciously recently, but quickly shook your head.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We march on.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				_event.m.HedgeKnight1.improveMood(10, "Was feeling better");
				this.List.push({
					id = 10,
					icon = "ui/icons/chance_to_hit_head.png",
					text = _event.m.HedgeKnight1.getName() + "'s headshot chance increases by +5%"
				});
				if (_event.m.HedgeKnight1.getBaseProperties().HitChance[this.Const.BodyPart.Head] < 100)
				{
					_event.m.HedgeKnight1.getBaseProperties().HitChance[this.Const.BodyPart.Head] += 5;
					_event.m.HedgeKnight1.getSkills().update();
				}
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
		local candidates = [];
		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkill("trait.player") && bro.getBackground().getID() == "background.killer_on_the_run")
			{
				candidates.push(bro);
			}
		}
		if (candidates.len() < 1)
		{
			return;
		}
		this.m.HedgeKnight1 = candidates[this.Math.rand(0, candidates.len() - 1)];
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

