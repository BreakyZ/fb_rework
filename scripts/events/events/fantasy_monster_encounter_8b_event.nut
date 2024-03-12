this.fantasy_monster_encounter_8b_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight1 = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_8b_event";
		this.m.Title = "At town...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{%hedgeknight1% walks up to you.%SPEECH_ON%I have an important story to tell you, even though it\'s personal. I heard a rumor that my {sister | childhood friend} who was lost a long time ago is in this village. When we were young, a group of thieves came to our village and I think they kidnapped her and sold her here. I would appreciate it if you could help me find her.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sure. Let\'s find her together.",
					function getResult( _event )
					{
						return "Fight";
					}
				},
				{
					Text = "Don\'t be swayed by rumors",
					function getResult( _event )
					{
						_event.m.HedgeKnight1.worsenMood(1.0, "Disappointed with the recent decision.");
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "Fight",
			Text = "[img]gfx/ui/events/event_80.png[/img]{While investigating in the village, %hedgeknight1% ran towards you in a hurry.%SPEECH_ON%I found those sons of bitches. Their faces I can never forget even after all these years. They\'re still trafficking people and some of the women they kidnapped are being used as prostitutes here in this village. It\'s time to get revenge on those fucking bastards.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.Music = this.Const.Music.BanditTracks;
						this.Const.World.Common.addUnitsToCombat(pp.Entities, this.Const.World.Spawn.Mercenaries, 300, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_91.png[/img]{After a fierce battle, %hedgeknight1% interrogates one of the survivors, but it appears that the woman he was looking for has already passed away. %hedgeknight1% became enraged, killing all remaining survivors and freeing the women who had been forcibly brought here. This bloodshed in the village made people fearful. One of the liberated women wants to join a mercenary group, saying she has nowhere else to go.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to join. (Need an empty slot in your mercenary roster)",
					function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							local roster = this.World.getPlayerRoster();
							local xxlonexx = roster.create("scripts/entity/tactical/player");
							xxlonexx.setStartValuesEx([
								"xxi_female_background"
							]);
							xxlonexx.m.HireTime = this.Time.getVirtualTimeF();
							xxlonexx.getBackground().m.RawDescription = "When you first meet %name%, she has been kidnapped. The kidnappers set fire to her house and brutally murdered her entire family. With your help, she avenged her family, but she had nowhere to turn. She joined %companyname%, saying she had nowhere else to go.";
							xxlonexx.getBackground().buildDescription(true);
							return 0;
						}
						else
						{
							return 0;
						}
					}
				},
				{
					Text = "No, I don\'t want strangers in our group.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local xxmoney = this.Math.rand(800, 900);
				this.World.Assets.addMoney(xxmoney);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + xxmoney + " gold"
				});
				_event.m.Title = "After the battle...";
			}
		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_88.png[/img]{Your party was defeated and managed to escape. This bloodshed in the village made people fearful.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Damn it!",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 50)
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
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}
			candidates.push(bro);
		}
		if (candidates.len() < 1)
		{
			return;
		}
		this.m.HedgeKnight1 = candidates[this.Math.rand(0, candidates.len() - 1)];

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

