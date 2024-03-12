this.fantasy_monster_encounter_7_event <- this.inherit("scripts/events/event", {
	m = {
		SwornBroA = null,
		SwornBroB = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_7_event";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You witness the intimate conversation between %swornbroa% and %swornbrob%, who have been comrades in arms for a long time. Contrary to their veteran mercenary image, they exchange affectionate words, accompanied by shy smiles and an elusive atmosphere. Curiosity about their secret conversation fills your mind, yet you find yourself pondering whether intruding upon their privacy would be the right course of action}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Eavesdrop on their conversation.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Respect their privacy.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.SwornBroA.getImagePath());
				this.Characters.push(_event.m.SwornBroB.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_172.png[/img]{%SPEECH_ON%We\'ve been fightin\' side by side for a damn long time, buddy. If it weren\'t for ya, I\'d be pushin\' up daisies in the cold earth by now. You\'re like my real family, no doubt \'bout it. When you\'re in danger, I\'ll put everything on the line to get you out.%SPEECH_OFF%The two shared a warm friendship and became sworn brothers.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It's really heating up in here, huh?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.SwornBroA.getImagePath());
				this.Characters.push(_event.m.SwornBroB.getImagePath());
				_event.m.SwornBroA.improveMood(10, "Has gained a sworn brother");
				_event.m.SwornBroB.improveMood(10, "Has gained a sworn brother");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.SwornBroA.getMoodState()],
					text = _event.m.SwornBroA.getName() + " has gained a sworn brother (+5 all stats)"
				});
				this.List.push({
					id = 11,
					icon = this.Const.MoodStateIcon[_event.m.SwornBroB.getMoodState()],
					text = _event.m.SwornBroB.getName() + " has gained a sworn brother (+5 all stats)"
				});
				local r = 5;
				_event.m.SwornBroA.getBaseProperties().MeleeSkill += r;
				_event.m.SwornBroA.getBaseProperties().RangedSkill += r;
				_event.m.SwornBroA.getBaseProperties().MeleeDefense += r;
				_event.m.SwornBroA.getBaseProperties().RangedDefense += r;
				_event.m.SwornBroA.getBaseProperties().Hitpoints += r;
				_event.m.SwornBroA.getBaseProperties().Stamina += r;
				_event.m.SwornBroA.getBaseProperties().Initiative += r;
				_event.m.SwornBroA.getBaseProperties().Bravery += r;
				_event.m.SwornBroA.getSkills().update();
				_event.m.SwornBroB.getBaseProperties().MeleeSkill += r;
				_event.m.SwornBroB.getBaseProperties().RangedSkill += r;
				_event.m.SwornBroB.getBaseProperties().MeleeDefense += r;
				_event.m.SwornBroB.getBaseProperties().RangedDefense += r;
				_event.m.SwornBroB.getBaseProperties().Hitpoints += r;
				_event.m.SwornBroB.getBaseProperties().Stamina += r;
				_event.m.SwornBroB.getBaseProperties().Initiative += r;
				_event.m.SwornBroB.getBaseProperties().Bravery += r;
				_event.m.SwornBroB.getSkills().update();
				_event.m.SwornBroA.getFlags().add("SwornBrotherS");
				_event.m.SwornBroB.getFlags().add("SwornBrotherS");
				_event.m.SwornBroA.setTitle("the Sworn Brother");
				_event.m.SwornBroB.setTitle("the Sworn Brother");
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
		local candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkill("trait.player") && !bro.getFlags().has("SwornBrotherS") && bro.getLevel() >= 10)
			{
				candidates.push(bro);
			}
		}
		if (candidates.len() < 2)
		{
			return;
		}

		this.m.SwornBroA = candidates.remove(this.Math.rand(0, candidates.len() - 1));
		this.m.SwornBroB = candidates.remove(this.Math.rand(0, candidates.len() - 1));
		this.m.Score = 5;
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
		_vars.push([
			"swornbrob",
			this.m.SwornBroB.getName()
		]);
	}

	function onClear()
	{
		this.m.SwornBroA = null;
		this.m.SwornBroB = null;
	}

});

