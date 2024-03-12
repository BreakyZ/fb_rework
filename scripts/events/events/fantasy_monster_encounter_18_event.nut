this.fantasy_monster_encounter_18_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_18_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{A {man | woman} with a shabby appearance came to visit.%SPEECH_ON%Hello, mercenaries. Don\'t you need a girl? I will sell my daughter for a good price. My daughter is smart and will do anything you tell her. Anything.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You\'re a pimp who sells your daughter. Get the hell out.",
					function getResult( _event )
					{
						return 0;
					}
				},
				{
					Text = "Cut off the neck.",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							this.World.Assets.addMoralReputation(-1);
						}
						else
						{
							this.World.Assets.addMoralReputation(1);
						}
						if (this.Math.rand(1, 100) <= 50)
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
					Text = "Buy her for 10 crowns.",
					function getResult( _event )
					{
						this.World.Assets.addMoney(-10);
						return "C";
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You cut off the head of a scum who tried to sell their daughter. Leaving the crying girl behind, you signaled the team to start. Only time will reveal whether your actions will be her salvation or a source of resentment.}",
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
			}
		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You cut off the head of a scum who tried to sell his daughter. Even though her parents died before her eyes, she remained unfazed as you cleaned the bloody blade. As you turned your back and were about to leave, she asked you a favor.%SPEECH_ON%Please take me with you. Now I have nowhere to turn. I will do whatever you ask of me.%SPEECH_OFF%You turned around with a blank expression, but she followed you recklessly. You don\'t know what she\'s thinking, but it\'s okay to have at least one person to cook and do laundry.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You will have to learn how to cook, do laundry, and use a sword.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
				{
					local roster = this.World.getPlayerRoster();
					local xxlonexx = roster.create("scripts/entity/tactical/player");
					xxlonexx.setStartValuesEx([
						"xxi_female_background"
					]);
					xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
					xxlonexx.getBackground().m.RawDescription = "You cut off the heads of the parents who tried to sell %name% right before her eyes. She followed you in killing her parents and is now a member of %companyname%.";
					xxlonexx.getBackground().buildDescription(true);
					if (xxlonexx.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
					{
						xxlonexx.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
						xxlonexx.getItems().equip(this.new("scripts/items/armor/tattered_sackcloth"));
					}
					this.Characters.push(xxlonexx.getImagePath());
				}
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You see the girl crying in despair over the fact that she was sold, and you tell her what to do from now on.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You will have to learn how to cook, do laundry, and use a sword.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
				{
					local roster = this.World.getPlayerRoster();
					local xxlonexx = roster.create("scripts/entity/tactical/player");
					xxlonexx.setStartValuesEx([
						"xxi_female_background"
					]);
					xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
					local background = this.new("scripts/skills/backgrounds/slave_background");
					xxlonexx.getSkills().removeByID("background.messenger");
					xxlonexx.getSkills().add(background);
					xxlonexx.getSkills().add(this.new("scripts/skills/actives/xxzzvoice_skill"));
					xxlonexx.getFlags().add("xxzzvoice_girl");
					xxlonexx.m.Background = background;
					xxlonexx.getBackground().m.RawDescription = "%name% cried in despair at the knowledge that her parents had sold her for a few crowns, but she soon had to adjust to %companyname%.";
					xxlonexx.getBackground().buildDescription(true);
					if (xxlonexx.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
					{
						xxlonexx.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
						xxlonexx.getItems().equip(this.new("scripts/items/armor/tattered_sackcloth"));
					}
					this.Characters.push(xxlonexx.getImagePath());
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
		if (this.World.Assets.getMoney() < 100)
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

