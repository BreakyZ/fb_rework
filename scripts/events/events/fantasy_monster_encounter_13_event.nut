this.fantasy_monster_encounter_13_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight1 = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_13_event";
		this.m.Title = "During camp...";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_39.png[/img]{The %companyname% stopped to take a short break. While building a campfire, setting up camp, and preparing meals, each member rests and spends personal time. You wonder what to do during your break.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Look at what other members are doing.",
					function getResult( _event )
					{
						switch(this.Math.rand(1, 4))
						{
							case 1:	return "B";
							case 2:	return "B";
							case 3:	return "C";
							case 4:	return "D";
						}
					}
				},
				{
					Text = "Rest alone.",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%SPEECH_ON%{So I said, mate. There\'s a radiant holy sword hidden within my trousers, it shines so brightly that it could make any female surrender. Even a she-dragon would tremble in its presence. This one lass asked to catch a glimpse of my holy sword, so I booked a room and told her to bring some booze for the occasion. | No, I really saw it with my own eyes. Two unholds tangled together, being intimate. Honestly, I don\'t know which one is the female. Hell, they might both be males for all I know. The moans they made were louder and dirtier than the sound of my poop after holding it in for a week. | If it has a chicken head and a lion body, is it a griffin? Or a cockatrice? I wonder what the meat will taste like. It\'s gotta be a taste worth risking your fucking life for, isn\'t it? | Northern barbarians are bad at drinking. After drinking a glass of basilisk ale, he vomited everything in his stomach and begged me to save him, Fuck. Southern assholes don\'t know much about alcohol or women, so it\'s not worth talking about. | Yes, yes, he was such an asshole. One time he tried to do that to a dead undead bitch. That bastard is a crazy bastard who just fuck in any hole. The reason he got sick recently is probably because he fucked a dead Unhold\'s asshole. | Wizards are untrustworthy people. Have you ever seen them sleeping with women? They say a wizard must never have sexual intercourse to maintain his mystical powers. But I think differently. To satisfy their desires, they secretly kidnap female horses every night to satisfy their dirty desires and suck out their life force. Just like a Necrosavant. Did I see it with my own eyes? Do you believe and pray to God because you have seen him with your own eyes? | Last time it was really bad. I was so fucking drunk that I slept with a fucking old hag. When I woke up that day, I thought I had woken up in a graveyard next to a skeleton. It was the worst fucking day of my life. Luckily I didn't stick my dick in a horse or a melon. If that were the case, I would have committed suicide. What? She wasn\'t even a woman? Fuck, I guess I should commit suicide. | You don\'t know anything. If you fuck a man\'s backdoor once, you\'ll never be able to fuck a woman again. What? You think I\'m going to fuck my brothers? Fuck it, I have eyes too. Don\'t even dream about it because I won\'t put it in your dirty asshole. | My first experience? It was fun to play with my hands while looking at the sexy female {horse | cow | goat | dog | cat}\'s {ass | pussy}. One time, while I was having a good time, my {mom | dad | brother | sister} saw me. Since then my life has been messed up and now I\'m making money by killing people, fuck. | A life like drinking, fuck women, and making babies is not fun. I feel alive only on the battlefield. Nothing can match the pleasure I get when I see my enemy dying at the crossroads between life and death where my life is at stake. That\'s why I can\'t stop doing this. | What does retirement mean to me, the {Lonely | Warlike | Ruthless | Invincible | Cold} {Adventurer | Gambler | Widowmaker | Hunter | Wolf | Slayer}? {Marrying a regular woman and having children with the money I\'ve saved, then dying in bed like a commoner. | Meeting a strong opponent on the battlefield and die great after a fierce battle. | Standing there with a shit eating grin as the boss who watches over us fires me, that\'s retirement.} But I\'m more curious about whether the crappy food I ate yesterday will be served again tonight than about life after retirement.}%SPEECH_OFF%%randombrother% was chatting excitedly in front of the campfire. Members laugh or jeer. You decided to listen until the meal was ready.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ha, funny",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.worsenMood(0.5, "Was feeling worse");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
					else
					{
						bro.improveMood(0.5, "Was feeling better");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%hedgeknight1% is yelling and swearing. Perhaps there was a problem with the medicine I purchased from the {merchant | alchemist} yesterday. The medicine certainly seems to be effective. However, it looked very different from the effect %hedgeknight1% boasted about yesterday. %hedgeknight1% had lost all the hair on his body and looked like an ugly Alp. The members burst out laughing when they saw %hedgeknight1%\'s misfortune. If one person is unhappy and everyone is happy, that\'s it. | When you went to the place where the members were noisily gathered, you noticed %hedgeknight1% acting like an asshole again.%SPEECH_ON%Well guys, this time I\'m absolutely certain I\'ll succeed, so make sure to bet on my success. Is everyone ready? Let\'s get started.%SPEECH_OFF%%hedgeknight1% immediately shouted, ignited several swords and started juggling them. But soon he lost his balance, dropped his sword, and a flame burned the fur on his body. Fortunately, he did not die and brought great enjoyment to the audience. It was a fantastic performance. | It seems like the members are playing a drinking game. Boastful %hedgeknight1%, full of bravado, shouted.%SPEECH_ON%Hey guys, I\'ve never been drunk in my entire life!%SPEECH_OFF%He drank hard liquor by the whole barrel then let out a thunderous roar and began emptying everything from his stomach. His resounding noise and appearance were reminiscent of a dragon. The members burst into laughter as they witnessed the \'Vomit Dragon\'. The basilisk ale he drank was so strong that if he didn't dilute it with water, his body temperature would rise so much that all the hair on his body would fall out. He no longer needs to wash his hair starting tomorrow.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ha, funny",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local actor = _event.m.HedgeKnight1;
				local hair = actor.getSprite("hair");
				hair.setBrush("");
				local beard = actor.getSprite("beard");
				beard.setBrush("");
				local beard_top = actor.getSprite("beard_top");
				beard_top.setBrush("");
				this.Characters.push(actor.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (bro == actor)
					{
						bro.worsenMood(1, "Was feeling worse");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
					else
					{
						bro.improveMood(1, "Was feeling better");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
				local injury = actor.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = actor.getName() + " suffers " + injury.getNameOnly()
				});
				actor.addLightInjury();
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%hedgeknight1% approached you with a dish.%SPEECH_ON%I prepared a special dish today. This is a special recipe from my mother. The men in my hometown also loved this dish so much that they used to visit my mom late at night every day.%SPEECH_OFF%You asked whether his mother owned a pub or tavern.%SPEECH_ON%No. My mother and I lived in a house in a remote forest away from the village. My mother was a village herbalist. My father? I\'ve never seen him. He must be a bastard who abandoned his wife and child and ran away.%SPEECH_OFF%%hedgeknight1%\'s special dish looked strange and even smelled disgusting. You were wondering whether you could eat this or not, but when you saw that other members were eating it well, you slowly tasted it. The dish was disgusting at first, but the more I ate it, the more addictive it became. You asked %hedgeknight1% if he had ever tried to find his father.%SPEECH_ON%No. In fact, in my hometown, there were many men who abandoned their children and ran away. Since everyone was in a similar situation, I didn\'t think to look for them. Even the men who came to my mother in the middle of the night and received food from them soon abandoned their families and ran away somewhere. Most of the male adults in my village were bastards.%SPEECH_OFF%You feel strange about %hedgeknight1%\'s story. A woman living in a remote village and the village men who keep disappearing. You are reminded of the story of the Hexen, a monster that takes the form of a woman and eats men. You tried to think more, but your consciousness soon became clouded by the overwhelming fatigue.....\n\n\n\n\nAfter some time, you and the members woke up. %hedgeknight1% laughed and asked if everyone was tired. You don\'t quite remember what happened, but it seems like the members were offering you strong drinks. %hedgeknight1% said he put the remaining dishes in the wagon. What dish? You don\'t remember. | %hedgeknight1% approached you with a dish.%SPEECH_ON%Boss, I prepared a special meal today. It\'s made using a secret recipe from my hometown. Give it a try.%SPEECH_OFF%The dish looked disgusting and even smelled strange. Still, you ate some, thinking of the sincerity he had made.%SPEECH_ON%In my hometown, when I was worried or tired, I just had a bowl of this and everything was solved. How about it? Does it taste good?%SPEECH_OFF%It tasted disgusting at first, but the more you ate it, the more addictive it became. While eating, you suddenly fell into a deep sleep. In your fading consciousness, you saw other members falling as well.%SPEECH_ON%You\'ll sleep well and forget everything when you wake up, boss.%SPEECH_OFF%\n\n\n\n\nAfter some time, you and the members woke up. %hedgeknight1% laughed and asked if everyone was tired. You don\'t quite remember what happened, but it seems like the members were offering you strong drinks. %hedgeknight1% said he put the remaining dishes in the wagon. What dish? You don\'t remember. | %hedgeknight1% approached you with a dish.%SPEECH_ON%I was on duty as the cook today, so I prepared a special meal. The taste will be amazing.%SPEECH_OFF%The dish looked disgusting and even smelled strange. Still, you ate some, thinking of the sincerity he had made.%SPEECH_ON%How is it? Does it taste good? There was an old grandmother selling this food in a village I visited a while ago, and it tasted good, so I found out the recipe.%SPEECH_OFF%After eating all that disgusting food, you felt uncomfortable and tired. Your eyes slowly close.\n\n\n\n\nAfter some time, you and the members woke up. %hedgeknight1% laughed and asked if everyone was tired. You don\'t quite remember what happened, but it seems like the members were offering you strong drinks. %hedgeknight1% said he put the remaining dishes in the wagon. What dish? You don\'t remember.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I\'m tired...",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local actor = _event.m.HedgeKnight1;
				this.Characters.push(actor.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					if (bro == actor)
					{
						bro.improveMood(1, "Was feeling better");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
					else
					{
						bro.worsenMood(1, "Was feeling worse");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
				if (this.Math.rand(1, 100) <= 33)
				{
					this.World.Assets.getStash().add(this.new("scripts/items/supplies/strange_meat_item"));
				}
				else
				{
					this.World.Assets.getStash().add(this.new("scripts/items/supplies/black_marsh_stew_item"));
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
		if (this.World.Flags.get("FantasyMonsterEncounter") != 1)
		{
			return;
		}
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local rr = 2;
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (!bro.getSkills().hasSkill("effects.xxzzfantasy_skill"))
			{
				candidates.push(bro);
			}
		}
		if (candidates.len() < rr)
		{
			return;
		}
		rr = this.Math.rand(0, candidates.len() - 1);
		this.m.HedgeKnight1 = candidates[rr];
		candidates.remove(rr);
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

