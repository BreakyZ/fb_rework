this.xxzzskillbook_event <- this.inherit("scripts/events/event", {
	m = {
		Bought = 0,
		HedgeKnight1 = null
	},
	function create()
	{
		this.m.ID = "event.xxzzskillbook_event";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "apage1",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Random Skill",
					function getResult( _event )
					{
						_event.m.Bought = 9999977;
						return "GG";
					}
				},
				{
					Text = "Accidental Attack",
					function getResult( _event )
					{
						_event.m.Bought = 1;
						return "GG";
					}
				},
				{
					Text = "Acid Grenade",
					function getResult( _event )
					{
						_event.m.Bought = 2;
						return "GG";
					}
				},
				{
					Text = "Backstab",
					function getResult( _event )
					{
						_event.m.Bought = 3;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage27";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage2";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "1 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage2",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Bear Trap",
					function getResult( _event )
					{
						_event.m.Bought = 4;
						return "GG";
					}
				},
				{
					Text = "Berserker Charge",
					function getResult( _event )
					{
						_event.m.Bought = 5;
						return "GG";
					}
				},
				{
					Text = "Black Magic Grenade",
					function getResult( _event )
					{
						_event.m.Bought = 6;
						return "GG";
					}
				},
				{
					Text = "Blessing",
					function getResult( _event )
					{
						_event.m.Bought = 7;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage1";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage3";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "2 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage3",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Bloodletting Therapy",
					function getResult( _event )
					{
						_event.m.Bought = 8;
						return "GG";
					}
				},
				{
					Text = "Blood Lust",
					function getResult( _event )
					{
						_event.m.Bought = 9;
						return "GG";
					}
				},
				{
					Text = "Bribe",
					function getResult( _event )
					{
						_event.m.Bought = 10;
						return "GG";
					}
				},
				{
					Text = "Cannon Barrage",
					function getResult( _event )
					{
						_event.m.Bought = 11;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage2";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage4";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "3 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage4",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Choke and Toss",
					function getResult( _event )
					{
						_event.m.Bought = 12;
						return "GG";
					}
				},
				{
					Text = "Battle Command",
					function getResult( _event )
					{
						_event.m.Bought = 13;
						return "GG";
					}
				},
				{
					Text = "Concentration",
					function getResult( _event )
					{
						_event.m.Bought = 14;
						return "GG";
					}
				},
				{
					Text = "Close Quarters Combat Throwing",
					function getResult( _event )
					{
						_event.m.Bought = 15;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage3";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage5";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "4 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage5",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Battle Cure",
					function getResult( _event )
					{
						_event.m.Bought = 16;
						return "GG";
					}
				},
				{
					Text = "Demonize",
					function getResult( _event )
					{
						_event.m.Bought = 17;
						return "GG";
					}
				},
				{
					Text = "Devastating Blow",
					function getResult( _event )
					{
						_event.m.Bought = 18;
						return "GG";
					}
				},
				{
					Text = "Drain Blood",
					function getResult( _event )
					{
						_event.m.Bought = 19;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage4";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage6";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "5 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage6",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Earthquake",
					function getResult( _event )
					{
						_event.m.Bought = 20;
						return "GG";
					}
				},
				{
					Text = "Electric Shock",
					function getResult( _event )
					{
						_event.m.Bought = 21;
						return "GG";
					}
				},
				{
					Text = "Feast",
					function getResult( _event )
					{
						_event.m.Bought = 22;
						return "GG";
					}
				},
				{
					Text = "Fire Ball",
					function getResult( _event )
					{
						_event.m.Bought = 23;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage5";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage7";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "6 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage7",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hellfire Grenade",
					function getResult( _event )
					{
						_event.m.Bought = 24;
						return "GG";
					}
				},
				{
					Text = "Flame Wave",
					function getResult( _event )
					{
						_event.m.Bought = 25;
						return "GG";
					}
				},
				{
					Text = "Fling Back",
					function getResult( _event )
					{
						_event.m.Bought = 26;
						return "GG";
					}
				},
				{
					Text = "Force of Nature",
					function getResult( _event )
					{
						_event.m.Bought = 27;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage6";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage8";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "7 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage8",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Frenzy Power",
					function getResult( _event )
					{
						_event.m.Bought = 28;
						return "GG";
					}
				},
				{
					Text = "Frost Blast",
					function getResult( _event )
					{
						_event.m.Bought = 29;
						return "GG";
					}
				},
				{
					Text = "Gale Force",
					function getResult( _event )
					{
						_event.m.Bought = 30;
						return "GG";
					}
				},
				{
					Text = "Great Awakening",
					function getResult( _event )
					{
						_event.m.Bought = 31;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage7";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage9";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "8 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage9",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Headbutt",
					function getResult( _event )
					{
						_event.m.Bought = 32;
						return "GG";
					}
				},
				{
					Text = "Magical Healing",
					function getResult( _event )
					{
						_event.m.Bought = 33;
						return "GG";
					}
				},
				{
					Text = "Hide",
					function getResult( _event )
					{
						_event.m.Bought = 34;
						return "GG";
					}
				},
				{
					Text = "Holy Spear",
					function getResult( _event )
					{
						_event.m.Bought = 35;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage8";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage10";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "9 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage10",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Judo Throw",
					function getResult( _event )
					{
						_event.m.Bought = 36;
						return "GG";
					}
				},
				{
					Text = "Kick",
					function getResult( _event )
					{
						_event.m.Bought = 37;
						return "GG";
					}
				},
				{
					Text = "Line Breaker",
					function getResult( _event )
					{
						_event.m.Bought = 38;
						return "GG";
					}
				},
				{
					Text = "Magical Lute Song",
					function getResult( _event )
					{
						_event.m.Bought = 39;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage9";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage11";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "10 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage11",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Thunderstorm",
					function getResult( _event )
					{
						_event.m.Bought = 40;
						return "GG";
					}
				},
				{
					Text = "Forced March",
					function getResult( _event )
					{
						_event.m.Bought = 41;
						return "GG";
					}
				},
				{
					Text = "Mark",
					function getResult( _event )
					{
						_event.m.Bought = 42;
						return "GG";
					}
				},
				{
					Text = "Miracle",
					function getResult( _event )
					{
						_event.m.Bought = 43;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage10";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage12";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "11 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage12",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Stealing",
					function getResult( _event )
					{
						_event.m.Bought = 44;
						return "GG";
					}
				},
				{
					Text = "Multi Shot",
					function getResult( _event )
					{
						_event.m.Bought = 45;
						return "GG";
					}
				},
				{
					Text = "Penetrating Shot",
					function getResult( _event )
					{
						_event.m.Bought = 46;
						return "GG";
					}
				},
				{
					Text = "Pincer Thrust",
					function getResult( _event )
					{
						_event.m.Bought = 47;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage11";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage13";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "12 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});




		this.m.Screens.push({
			ID = "apage13",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Telekinetic Pull",
					function getResult( _event )
					{
						_event.m.Bought = 48;
						return "GG";
					}
				},
				{
					Text = "Abyssal Grab",
					function getResult( _event )
					{
						_event.m.Bought = 49;
						return "GG";
					}
				},
				{
					Text = "Purifying Flame",
					function getResult( _event )
					{
						_event.m.Bought = 50;
						return "GG";
					}
				},
				{
					Text = "Extreme Weather",
					function getResult( _event )
					{
						_event.m.Bought = 51;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage12";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage14";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "13 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage14",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Revel",
					function getResult( _event )
					{
						_event.m.Bought = 52;
						return "GG";
					}
				},
				{
					Text = "Boulder Throw",
					function getResult( _event )
					{
						_event.m.Bought = 53;
						return "GG";
					}
				},
				{
					Text = "Throw Dirt",
					function getResult( _event )
					{
						_event.m.Bought = 54;
						return "GG";
					}
				},
				{
					Text = "Banshee Scream",
					function getResult( _event )
					{
						_event.m.Bought = 55;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage13";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage15";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "14 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage15",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Shield Guard",
					function getResult( _event )
					{
						_event.m.Bought = 56;
						return "GG";
					}
				},
				{
					Text = "Shadow Walk",
					function getResult( _event )
					{
						_event.m.Bought = 57;
						return "GG";
					}
				},
				{
					Text = "Shield Bash",
					function getResult( _event )
					{
						_event.m.Bought = 58;
						return "GG";
					}
				},
				{
					Text = "Shockwave",
					function getResult( _event )
					{
						_event.m.Bought = 59;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage14";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage16";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "15 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage16",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Slander",
					function getResult( _event )
					{
						_event.m.Bought = 60;
						return "GG";
					}
				},
				{
					Text = "Serpent Bind",
					function getResult( _event )
					{
						_event.m.Bought = 61;
						return "GG";
					}
				},
				{
					Text = "Double Edge",
					function getResult( _event )
					{
						_event.m.Bought = 62;
						return "GG";
					}
				},
				{
					Text = "Storm Fury",
					function getResult( _event )
					{
						_event.m.Bought = 63;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage15";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage17";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "16 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage17",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Martial Strike",
					function getResult( _event )
					{
						_event.m.Bought = 64;
						return "GG";
					}
				},
				{
					Text = "Summon Fiend",
					function getResult( _event )
					{
						_event.m.Bought = 65;
						return "GG";
					}
				},
				{
					Text = "Raise Dead + Unholy Bless",
					function getResult( _event )
					{
						_event.m.Bought = 66;
						return "GG";
					}
				},
				{
					Text = "Summon Spirit Wolf",
					function getResult( _event )
					{
						_event.m.Bought = 67;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage16";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage18";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "17 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage18",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Forced Swap",
					function getResult( _event )
					{
						_event.m.Bought = 68;
						return "GG";
					}
				},
				{
					Text = "Foot Sweep",
					function getResult( _event )
					{
						_event.m.Bought = 69;
						return "GG";
					}
				},
				{
					Text = "Tai Chi Weapon Form",
					function getResult( _event )
					{
						_event.m.Bought = 70;
						return "GG";
					}
				},
				{
					Text = "Tie Up",
					function getResult( _event )
					{
						_event.m.Bought = 71;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage17";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage19";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "18 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage19",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Unleash the Rage",
					function getResult( _event )
					{
						_event.m.Bought = 72;
						return "GG";
					}
				},
				{
					Text = "War Crime",
					function getResult( _event )
					{
						_event.m.Bought = 73;
						return "GG";
					}
				},
				{
					Text = "Warcry",
					function getResult( _event )
					{
						_event.m.Bought = 74;
						return "GG";
					}
				},
				{
					Text = "Flood Bomb",
					function getResult( _event )
					{
						_event.m.Bought = 75;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage18";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage20";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "19 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage20",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Whirlwind Attack",
					function getResult( _event )
					{
						_event.m.Bought = 76;
						return "GG";
					}
				},
				{
					Text = "Riding a Giant Wolf",
					function getResult( _event )
					{
						_event.m.Bought = 77;
						return "GG";
					}
				},
				{
					Text = "Point Blank Shot",
					function getResult( _event )
					{
						_event.m.Bought = 78;
						return "GG";
					}
				},
				{
					Text = "Agile Killer (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 79;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage19";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage21";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "20 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage21",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "All-rounder (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 80;
						return "GG";
					}
				},
				{
					Text = "Banner Lord (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 81;
						return "GG";
					}
				},
				{
					Text = "Battle Trance (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 82;
						return "GG";
					}
				},
				{
					Text = "Vengeance (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 83;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage20";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage22";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "21 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage22",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Mana Mastery (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 84;
						return "GG";
					}
				},
				{
					Text = "Challenger (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 85;
						return "GG";
					}
				},
				{
					Text = "Adaptive Counter (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 86;
						return "GG";
					}
				},
				{
					Text = "Desolator (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 87;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage21";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage23";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "22 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage23",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Drunken Master (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 88;
						return "GG";
					}
				},
				{
					Text = "Goblin Weaponology (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 89;
						return "GG";
					}
				},
				{
					Text = "Harden Skin (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 90;
						return "GG";
					}
				},
				{
					Text = "Head Collector (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 91;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage22";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage24";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "23 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage24",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Primitive Hunting Skills (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 92;
						return "GG";
					}
				},
				{
					Text = "Kensei (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 93;
						return "GG";
					}
				},
				{
					Text = "Last Stand (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 94;
						return "GG";
					}
				},
				{
					Text = "Lifestealer (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 95;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage23";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage25";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "24 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage25",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Masochism (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 96;
						return "GG";
					}
				},
				{
					Text = "Oddball (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 97;
						return "GG";
					}
				},
				{
					Text = "Orc Weaponology (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 98;
						return "GG";
					}
				},
				{
					Text = "Outsider (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 99;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage24";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage26";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "25 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage26",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Warm-up (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 100;
						return "GG";
					}
				},
				{
					Text = "Prudence (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 101;
						return "GG";
					}
				},
				{
					Text = "Rapid Reflexes (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 102;
						return "GG";
					}
				},
				{
					Text = "Self Care (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 103;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage25";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage27";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "26 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "apage27",
			Text = "[img]gfx/ui/events/event_15.png[/img]{Select the skill you want %hedgeknight1% to learn.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sharpshooter (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 104;
						return "GG";
					}
				},
				{
					Text = "Skull Surgery (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 105;
						return "GG";
					}
				},
				{
					Text = "Phalanx (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 106;
						return "GG";
					}
				},
				{
					Text = "Veteran (passive)",
					function getResult( _event )
					{
						_event.m.Bought = 107;
						return "GG";
					}
				},
				{
					Text = "[color=#04c949]Previous Page[/color]",
					function getResult( _event )
					{
						return "apage26";
					}

				},
				{
					Text = "[color=#04c949]Next Page[/color]",
					function getResult( _event )
					{
						return "apage1";
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "27 Page";
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
			}
		});

		this.m.Screens.push({
			ID = "GG",
			Text = "[img]gfx/ui/events/event_74.png[/img]{%hedgeknight1% learned new skills through the skill book.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				local actor = _event.m.HedgeKnight1;
				local skillname;
				local chk = actor.getSkills();
				local sk_type = [
		"sb_acciattack_skill",
		"sb_acidbomb_skill",
		"sb_backstab_skill",
		"sb_beartrap_skill",
		"sb_bkcharge_skill",
		"sb_blackbomb_skill",
		"sb_blessing_skill",
		"sb_bloodletting_skill",
		"sb_bloodlust_skill",
		"sb_bribe_skill",
		"sb_cannon_skill",
		"sb_chokentoss_skill",
		"sb_command_skill",
		"sb_concent_skill",
		"sb_cqcthrowing_skill",
		"sb_cure_skill",
		"sb_demon_skill",
		"sb_devablow_skill",
		"sb_drainblood_skill",
		"sb_earthquake_skill",
		"sb_electric_skill",
		"sb_feast_skill",
		"sb_fireball_skill",
		"sb_firebomb_skill",
		"sb_flamewave_skill",
		"sb_flingback_skill",
		"sb_fonature_skill",
		"sb_frenzy_skill",
		"sb_frostblast_skill",
		"sb_gale_skill",
		"sb_great_skill",
		"sb_headbutt_skill",
		"sb_heal_skill",
		"sb_hide_skill",
		"sb_holyspear_skill",
		"sb_judo_skill",
		"sb_kick_skill",
		"sb_linebreaker_skill",
		"sb_lute_skill",
		"sb_manaforce_skill",
		"sb_march_skill",
		"sb_mark_skill",
		"sb_miracle_skill",
		"sb_moneysteal_skill",
		"sb_multishot_skill",
		"sb_penshot_skill",
		"sb_pincer_skill",
		"sb_pull_skill",
		"sb_pull2_skill",
		"sb_puri_skill",
		"sb_rain_skill",
		"sb_revel_skill",
		"sb_rock_skill",
		"sb_sand_skill",
		"sb_scream_skill",
		"sb_sguard_skill",
		"sb_shadowwalk_skill",
		"sb_shieldbash_skill",
		"sb_shockwave_skill",
		"sb_slander_skill",
		"sb_snake_skill",
		"sb_snow_skill",
		"sb_stormfury_skill",
		"sb_strike_skill",
		"sb_sumfiend_skill",
		"sb_sumskel_skill",
		"sb_sumwolf_skill",
		"sb_swap_skill",
		"sb_sweep_skill",
		"sb_taichi_skill",
		"sb_tieup_skill",
		"sb_unlrage_skill",
		"sb_warcrime_skill",
		"sb_warcry_skill",
		"sb_waterbomb_skill",
		"sb_whirlwind_skill",
		"sb_wolfride_skill",
		"sb_zeroshot_skill",
		"sbp_agile_skill",
		"sbp_allrounder_skill",
		"sbp_banner_skill",
		"sbp_battletrance_skill",
		"sbp_beater_skill",
		"sbp_bondage_skill",
		"sbp_challenger_skill",
		"sbp_counter_skill",
		"sbp_desolator_skill",
		"sbp_drunk_skill",
		"sbp_goblin_skill",
		"sbp_hardenskin_skill",
		"sbp_headcollector_skill",
		"sbp_hunting_skill",
		"sbp_kensei_skill",
		"sbp_laststand_skill",
		"sbp_lifestealer_skill",
		"sbp_maso_skill",
		"sbp_oddball_skill",
		"sbp_orc_skill",
		"sbp_outsider_skill",
		"sbp_overwarmup_skill",
		"sbp_prudence_skill",
		"sbp_rapid_skill",
		"sbp_selfcare_skill",
		"sbp_sharpshooter_skill",
		"sbp_skullsurgery_skill",
		"sbp_spear_skill",
		"sbp_veteran_skill"
				];
				for( local i = 0; i < sk_type.len(); i = ++i )
				{
					local skname = "actives." + sk_type[i]
					if (chk.hasSkill(skname))
					{
						chk.removeByID(skname);
					}
				}
				if (_event.m.Bought == 9999977)
				{
					sk_type = sk_type[this.Math.rand(0, sk_type.len() - 1)];
				}
				else
				{
					sk_type = sk_type[_event.m.Bought - 1];
				}
				chk.add(this.new("scripts/skills/actives/" + sk_type));
				actor.getSkills().removeByID("effects.xxzzcheck_skill");
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				return 0;
			}
		});
	}

	function onDetermineStartScreen()
	{
		return "apage1";
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local rr = 1;
		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("effects.xxzzcheck_skill"))
			{
				candidates.push(bro);
			}
		}
		if (candidates.len() < rr)
		{
			foreach( bro in brothers )
			{
				candidates.push(bro);
			}
		}
		rr = this.Math.rand(0, candidates.len() - 1);
		this.m.HedgeKnight1 = candidates[rr];
		candidates.remove(rr);
		return;
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

