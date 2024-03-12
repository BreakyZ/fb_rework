this.fantasy_monster_encounter_8_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight1 = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_8_event";
		this.m.Title = "At town...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_80.png[/img]{When your mercenary group entered a nearby village, a girl came running to us, crying.%SPEECH_ON%Please help me, sir. I have been kidnapped. If they catch me again, I might die. Please save me!%SPEECH_OFF%Soon, a group of armed men come after her and confront you.%SPEECH_ON%{Hey, I don\'t know what you heard from that bitch, but it\'s all lies. We\'re doing business in town legally and that bitch is our property. Just go away! | Sir, don\'t be fooled by her lies! She is an evil witch. We are just doing our job at the request of the villagers. Please go away!}%SPEECH_OFF%The woman cried and shouted.%SPEECH_ON%Those evil bastards killed my family and burned my house. I\'d rather commit suicide here than be dragged away by those bastards!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Must save this woman. Prepare for battle!",
					function getResult( _event )
					{
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.Music = this.Const.Music.BanditTracks;
						this.Const.World.Common.addUnitsToCombat(pp.Entities, this.Const.World.Spawn.BanditBoss, 200, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				},
				{
					Text = "It\'s none of our business.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.HedgeKnight1 = null;
						return 0;
					}
				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.HedgeKnight1 = roster.create("scripts/entity/tactical/player");
				_event.m.HedgeKnight1.setStartValuesEx([
					"xxi_female_background"
				]);
				_event.m.HedgeKnight1.getBackground().m.RawDescription = "When you first meet %name%, she has been kidnapped. The kidnappers set fire to her house and brutally murdered her entire family. With your help, she avenged her family, but she had nowhere to turn. She joined %companyname%, saying she had nowhere else to go.";
				_event.m.HedgeKnight1.getBackground().buildDescription(true);
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_91.png[/img]{After a fierce battle, all kidnappers were killed. This bloodshed in the village made people fearful. The rescued woman is grateful and wants to join %companyname%, saying she has nowhere else to go.}",
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
							this.World.getPlayerRoster().add(_event.m.HedgeKnight1);
							this.World.getTemporaryRoster().clear();
							_event.m.HedgeKnight1.onHired();
							_event.m.HedgeKnight1.m.MoodChanges = [];
							_event.m.HedgeKnight1.improveMood(1.0, "Has become a mercenary");
							_event.m.HedgeKnight1 = null;
							return 0;
						}
						else
						{
							this.World.getTemporaryRoster().clear();
							_event.m.HedgeKnight1 = null;
							return 0;
						}
					}
				},
				{
					Text = "No, I don\'t want strangers in our group.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.HedgeKnight1 = null;
						return 0;
					}
				}
			],
			function start( _event )
			{
				local xxmoney = this.Math.rand(500, 700);
				this.World.Assets.addMoney(xxmoney);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + xxmoney + " gold"
				});
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
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
						this.World.getTemporaryRoster().clear();
						_event.m.HedgeKnight1 = null;
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
		this.m.Score = 5;
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

