this.fantasy_monster_encounter_6_event <- this.inherit("scripts/events/event", {
	m = {
		Champion = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_6_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_115.png[/img]{Your mercenaries stumbled upon a small shack located in a secluded area. The interior of the shack was old and dusty, strewn with cobwebs and filled with stuffed specimens of various plants and animals. While exploring the house, you found a skeleton lying on the bed. It was probably the owner of the shack. Next to it lay an unknown bottle of medicine and a piece of paper that appeared to be a note written by him.%SPEECH_ON%I have dedicated my life to finding a way to transcend the feeble human body. Through dissecting and experimenting on various plants and animals, I have finally extracted the essence that could transform a human into a being beyond. However, the potion proved to be highly toxic for human use. If it is aged for several centuries, its toxicity will diminish. I hope someone will fulfill my lifelong aspiration and witness its effects.%SPEECH_OFF%You tried to disregard the absurd contents of the note, but one of your companions had already picked up the bottle of potion, ready to consume its contents.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Allow %chosen% to drink this potion",
					function getResult( _event )
					{
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
					Text = "Stop it, %chosen%!",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Champion.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_115.png[/img]{%SPEECH_ON%Aww! I feel like my body is burning, save me!%SPEECH_OFF% %chosen% rolled in agony for a while, groaning, until he eventually lost consciousness. You thought he had died, but he was still breathing. After some time had passed, %chosen% regained consciousness. He claimed that something massive had changed in his body. In fact, his face and body had undergone a grotesque transformation, resembling that of a decaying corpse. Had he become undead?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Care to see your own face, %chosen%?",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local actor = _event.m.Champion;
				local body = actor.getSprite("body");
				body.Saturation = 0.5;
				body.varySaturation(0.2);
				body.Color = this.createColor("#c1ddaa");
				body.varyColor(0.05, 0.05, 0.05);
				local head = actor.getSprite("head");
				head.Saturation = body.Saturation;
				head.Color = body.Color;
				local tattoo_head = actor.getSprite("tattoo_head");
				tattoo_head.setBrush("zombify_0" + this.Math.rand(1, 4));
				tattoo_head.setBrightness(0.9);
				_event.m.Champion.getBaseProperties().Hitpoints += 10;
				_event.m.Champion.getBaseProperties().Stamina += 10;
				_event.m.Champion.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "A change has taken place in " + _event.m.Champion.getName() + "\'s body!"
				});
				this.Characters.push(_event.m.Champion.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_115.png[/img]{%SPEECH_ON%Aww! I feel like my body is burning, save me!%SPEECH_OFF% %chosen% rolled in agony for a while, groaning, until he eventually lost consciousness. You thought he had died, but he was still breathing. After some time had passed, %chosen% regained consciousness. He claimed that something massive had changed in his body. However, there seemed to be little noticeable change on the surface. You thought he was just putting on a show.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Thou art lucky to still be alive, %chosen%",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Champion.getImagePath());
				local rr = this.Math.rand(1, 3);
				if (rr == 1)
				{
					_event.m.Champion.getBaseProperties().MeleeSkill += 7;
					_event.m.Champion.getBaseProperties().RangedSkill += 7;
					_event.m.Champion.getBaseProperties().MeleeDefense += 7;
					_event.m.Champion.getBaseProperties().RangedDefense += 7;
					_event.m.Champion.getBaseProperties().Hitpoints += 7;
					_event.m.Champion.getBaseProperties().Stamina += 7;
					_event.m.Champion.getBaseProperties().Initiative += 7;
					_event.m.Champion.getBaseProperties().Bravery += 7;
				}
				else
				if (rr == 2)
				{
					_event.m.Champion.getBaseProperties().MeleeSkill += 50;
					_event.m.Champion.getBaseProperties().RangedSkill += 50;
					_event.m.Champion.getBaseProperties().MeleeDefense += 30;
					_event.m.Champion.getBaseProperties().RangedDefense += 30;
					_event.m.Champion.getBaseProperties().Hitpoints = 5;
				}
				else
				{
					_event.m.Champion.getBaseProperties().MeleeSkill = 5;
					_event.m.Champion.getBaseProperties().RangedSkill = 5;
					_event.m.Champion.getBaseProperties().MeleeDefense = 5;
					_event.m.Champion.getBaseProperties().RangedDefense = 5;
					_event.m.Champion.getBaseProperties().Hitpoints = 5;
					_event.m.Champion.getBaseProperties().Stamina = 5;
					_event.m.Champion.getBaseProperties().Initiative = 5;
					_event.m.Champion.getBaseProperties().Bravery = 5;
				}
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "A change has taken place in " + _event.m.Champion.getName() + "\'s body!"
				});
				_event.m.Champion.getSkills().update();
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_115.png[/img]{You successfully managed to prevent %chosen% from drinking the potion, but it slipped from his hands and shattered on the floor. The spot where the potion fell emitted fumes as if it had been dissolved in hydrochloric acid, leaving a deeply corroded indentation.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You were inches away from death just now, idiot!",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Champion.getImagePath());
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 100)
		{
			return;
		}
		if (this.World.Flags.get("FantasyMonsterEncounter") == 1)
		{
			local currentTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();
			foreach( t in towns )
			{
				if (t.getTile().getDistanceTo(currentTile) <= 3)
				{
					return;
				}
			}
		}
		else
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkill("trait.player"))
			{
				candidates.push(bro);
			}
		}
		if (candidates.len() > 0)
		{
			this.m.Champion = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
		else
		{
			return;
		}
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"chosen",
			this.m.Champion != null ? this.m.Champion.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Champion = null;
	}

});

