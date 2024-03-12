this.xxarena_n_contract <- this.inherit("scripts/contracts/contract", {
	m = {},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.xxarena_n";
		this.m.Name = "Adventurer\'s Guild Mission";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1.0;
	}

	function start()
	{
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.setScreen("Start");
			}
		});
	}

	function createScreens()
	{
		this.m.Screens.push({
			ID = "Start",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_85.png[/img]{The life of adventurers is unstable and the future cannot be guaranteed. Therefore, when they have money, there are many people who spend it happily rather than collecting it. The Night of the Adventurers Guild provides them with various entertainment. Of course, it\'s not free.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Treat to the %companyname% (Requires 1000 crowns)",
					function getResult()
					{
						if (this.World.Assets.getMoney() >= 1000)
						{
							this.World.Assets.addMoney(-1000);
							return "Go1";
						}
						else
						{
							return "Getout";
						}
					}
				},
				{
					Text = "Gamble (Requires 1000 crowns)",
					function getResult()
					{
						if (this.World.Assets.getMoney() >= 1000)
						{
							this.World.Assets.addMoney(-1000);
							return "Go2";
						}
						else
						{
							return "Getout";
						}
					}
				},
				{
					Text = "I\'ll come next time.",
					function getResult()
					{
						return 0;
					}
				}
			]
		});
		this.m.Screens.push({
			ID = "Go1",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_24.png[/img]{Members of the %companyname% ate and drank with your money and had a fun and hot time.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Have fun.",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				foreach( bro in brothers )
				{
					local rr = this.Math.rand(1, 25)
					if (rr == 1)
					{
						bro.improveMood(10, "Celebrated with the company");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
					else
					if (rr == 2)
					{
						bro.improveMood(this.Math.rand(1, 5), "Celebrated with the company");
						local effect = this.new("scripts/skills/effects_world/drunk_effect");
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName()  + " is now drunk."
						});
					}
					else
					if (rr == 3)
					{
						bro.improveMood(this.Math.rand(1, 5), "Celebrated with the company");
						local effect = this.new("scripts/skills/effects_world/exhausted_effect");
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName() + " is exhausted"
						});
					}
					else
					if (rr == 4)
					{
						bro.improveMood(this.Math.rand(1, 5), "Celebrated with the company");
						bro.getSkills().removeByType(this.Const.SkillType.TemporaryInjury);
						bro.getSkills().removeByID("effects.hangover");
						bro.getSkills().removeByID("effects.exhausted");
						bro.setHitpoints(bro.getHitpointsMax());
						bro.getSkills().update();
						this.List.push({
							id = 10,
							icon = "ui/icons/asset_business_reputation.png",
							text = bro.getName()  + " is fully recovered!"
						});
					}
					else
					if (rr == 5 && bro.getBaseProperties().Stamina < 170)
					{
						bro.improveMood(this.Math.rand(1, 5), "Celebrated with the company");
						local stamina = this.Math.rand(1, 3);
						bro.getBaseProperties().Stamina += stamina;
						bro.getSkills().update();
						this.List.push({
							id = 10,
							icon = "ui/icons/fatigue.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] Max Fatigue"
						});
					}
					else
					{
						bro.improveMood(this.Math.rand(1, 5), "Celebrated with the company");
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
				this.List.push({
					id = 11,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + 1000 + "[/color] Crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "Go2",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_62.png[/img]{You gambled without knowing the passing of time.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Gambling is like life. Lose or Gain...",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local gmoney;
				if (this.Math.rand(1, 100) <= 20)
				{
					gmoney = this.Math.rand(0, 3000);
				}
				else
				{
					gmoney = this.Math.rand(0, 1500);
				}
				this.World.Assets.addMoney(gmoney);
				this.List.push({
					id = 10,
					icon = "ui/items/supplies/money.png",
					text = "You used 1000 crowns and now have [color=#56e64c]" + gmoney + "[/color] crowns"
				});
			}
		});
		this.m.Screens.push({
			ID = "Getout",
			Title = "At the Town",
			Text = "[img]gfx/ui/events/event_70.png[/img]{Without money you can\'t do anything. You walk away with a bitter feeling.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Feel like shit",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
	}

	function setScreenForArena()
	{
		if (!this.m.IsActive)
		{
			return;
		}
		this.setScreen("Start");
	}

	function onClear()
	{
	}

	function onSerialize( _out )
	{
	}

	function onDeserialize( _in )
	{
	}

});

