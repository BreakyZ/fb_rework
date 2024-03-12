this.fantasy_monster_encounter_16_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_16_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_158.png[/img]{You come across a group of {refugees | mercenaries | militias | merchants | peasants | soldiers | people}. Both sides were tense for a moment, but soon confirmed that there was no hostility between them.%SPEECH_ON%{Hey, mercenaries. Is your income okay these days? Let\'s share a little about each of our lives. | Greetings. We come from the {east | west | north | south}. The {Barbarians | Orcs | Goblins | Bandits} have been raiding recently and we have been fleeing from their attacks. How have things been on your end? Any good news to share?}%SPEECH_OFF%You talked to them for a while, sharing information. After the conversation, they said they found your information useful and gave you some food.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Farewell",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local food = [
					"scripts/items/supplies/beer_item",
					"scripts/items/supplies/bread_item",
					"scripts/items/supplies/black_marsh_stew_item",
					"scripts/items/supplies/cured_rations_item",
					"scripts/items/supplies/cured_venison_item",
					"scripts/items/supplies/dates_item",
					"scripts/items/supplies/dried_fish_item",
					"scripts/items/supplies/dried_fruits_item",
					"scripts/items/supplies/dried_lamb_item",
					"scripts/items/supplies/fermented_unhold_heart_item",
					"scripts/items/supplies/goat_cheese_item",
					"scripts/items/supplies/ground_grains_item",
					"scripts/items/supplies/mead_item",
					"scripts/items/supplies/pickled_mushrooms_item",
					"scripts/items/supplies/preserved_mead_item",
					"scripts/items/supplies/rice_item",
					"scripts/items/supplies/roots_and_berries_item",
					"scripts/items/supplies/smoked_ham_item",
					"scripts/items/supplies/strange_meat_item",
					"scripts/items/supplies/wine_item",
					"scripts/items/supplies/ground_grains_item",
					"scripts/items/supplies/ground_grains_item",
					"scripts/items/supplies/ground_grains_item",
					"scripts/items/supplies/strange_meat_item",
					"scripts/items/supplies/strange_meat_item"
				];
				food = this.new(food[this.Math.rand(0, food.len() - 1)]);
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "You gain " + food.getName()
				});
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 10)
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

