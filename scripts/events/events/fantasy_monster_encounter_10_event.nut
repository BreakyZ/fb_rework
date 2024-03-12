this.fantasy_monster_encounter_10_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_10_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_78.png[/img]{A man adorned in lavish attire and accompanied by armed men resembling bodyguards arrived at your mercenary company. Although there was a momentary air of tension, the man managed to calm his guards and proceeded to speak with a noble and dignified tone about the purpose of his visit. \n\nAccording to his words, he claimed to be a member of the royal family and expressed significant interest in our mercenary company, desiring to become a patron. However, as a condition, he stated that he wishes to gain diverse experiences through a mercenary\'s life and requested to be accepted as a member of our mercenary group.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to join, Your Highness.",
					function getResult( _event )
					{
						return "B";
					}
				},
				{
					Text = "I decline that proposal, Your Highness.",
					function getResult( _event )
					{
						return "C";
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_78.png[/img]{When you granted him permission to join, a figure who appeared to be the head of his bodyguard stepped forward. He sternly warned you that he would keep an eye on you, and that he would not forgive you if you harmed the man, and then left with the others.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Mercenary life won\'t be easy, Your Highness.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local roster = this.World.getPlayerRoster();
				local xxlonexx = roster.create("scripts/entity/tactical/player");
				xxlonexx.setStartValuesEx([
					"xxheroroyal_background"
				]);
				xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
				xxlonexx.m.PerkPoints = 1;
				xxlonexx.m.LevelUps = 1;
				xxlonexx.m.Level = 2;
				xxlonexx.m.Talents = [];
				xxlonexx.m.Attributes = [];
				local talents = xxlonexx.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);
				talents[this.Const.Attributes.Hitpoints] = 3;
				talents[this.Const.Attributes.Bravery] = 3;
				talents[this.Const.Attributes.Fatigue] = 3;
				talents[this.Const.Attributes.MeleeSkill] = 3;
				talents[this.Const.Attributes.RangedSkill] = 3;
				talents[this.Const.Attributes.MeleeDefense] = 3;
				talents[this.Const.Attributes.RangedDefense] = 3;
				talents[this.Const.Attributes.Initiative] = 3;
				xxlonexx.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
				this.Characters.push(xxlonexx.getImagePath());
				return 0;
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_78.png[/img]{When you rejected the man\'s offer, his guards grew indignant and placed their hands on the handles of their weapons. But the man smiled brightly, stopped his bodyguards and said goodbye to you.%SPEECH_ON%Too bad. Actually, I wanted to make you guys my people. I hope we can meet again as friends, not as enemies, my mercenary friends.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Farewell, Your Highness.",
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
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.xxheroroyal")
			{
				return;
				break;
			}
		}
		this.m.Score = 5;
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

