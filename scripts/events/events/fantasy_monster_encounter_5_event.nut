this.fantasy_monster_encounter_5_event <- this.inherit("scripts/events/event", {
	m = {
		Xprice = null,
		Xitem = null
	},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_5_event";
		this.m.Title = "At town...";
		this.m.Cooldown = 100 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_174.png[/img]{Upon arrival at the nearby town, you encountered a wandering mage who was selling mysterious items. Mages are a rare presence in this world, so out of curiosity, you approached him to take a look at the goods he was selling.%SPEECH_ON%Greetings. I have brought with me a collection of rare and exotic items. Please, allow me to show them to you.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Show me what you sell?",
					function getResult( _event )
					{
						if (this.World.Flags.get("AngryMage") == 1)
						{
							return "Fight2";
						}
						else
						{
							return "B1";
						}
					}
				},
				{
					Text = "Not interesting",
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
			ID = "B1",
			Text = "[img]gfx/ui/events/event_174.png[/img]{The mage takes out his items.%SPEECH_ON%These items are not easily found elsewhere%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Potion of Knowledge : 650 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/misc/potion_of_knowledge_item");
						_event.m.Xprice = -650;
						return "C";
					}
				},
				{
					Text = "Happy Powder : 300 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/misc/happy_powder_item");
						_event.m.Xprice = -300;
						return "C";
					}
				},
				{
					Text = "Night Owl Elixir : 250 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/accessory/night_vision_elixir_item");
						_event.m.Xprice = -250;
						return "C";
					}
				},
				{
					Text = "Second Wind Potion : 250 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/accessory/recovery_potion_item");
						_event.m.Xprice = -250;
						return "C";
					}
				},
				{
					Text = "See other items",
					function getResult( _event )
					{
						return "B2";
					}
				},
				{
					Text = "Not interesting",
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
			Text = "[img]gfx/ui/events/event_174.png[/img]{The mage takes out his items.%SPEECH_ON%These items are not easily found elsewhere%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Lionheart Potion : 200 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/accessory/lionheart_potion_item");
						_event.m.Xprice = -200;
						return "C";
					}
				},
				{
					Text = "Cat Potion : 250 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/accessory/cat_potion_item");
						_event.m.Xprice = -250;
						return "C";
					}
				},
				{
					Text = "Iron Will Potion : 200 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/accessory/iron_will_potion_item");
						_event.m.Xprice = -200;
						return "C";
					}
				},
				{
					Text = "Tamed Wolf : 500 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/accessory/wolf_item");
						_event.m.Xprice = -500;
						return "C";
					}
				},
				{
					Text = "See other items",
					function getResult( _event )
					{
						return "B3";
					}
				},
				{
					Text = "Not interesting",
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
			ID = "B3",
			Text = "[img]gfx/ui/events/event_174.png[/img]{The mage takes out his items.%SPEECH_ON%These items are not easily found elsewhere%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Reinforced Throwing Net : 100 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/tools/reinforced_throwing_net");
						_event.m.Xprice = -100;
						return "C";
					}
				},
				{
					Text = "Flask of Blessed Water : 300 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/tools/holy_water_item");
						_event.m.Xprice = -300;
						return "C";
					}
				},
				{
					Text = "Acid Bottle : 300 crowns",
					function getResult( _event )
					{
						_event.m.Xitem = this.new("scripts/items/tools/acid_flask_item");
						_event.m.Xprice = -300;
						return "C";
					}
				},
				{
					Text = "If you don\'t wanna die, drop everything you got and fuck off!",
					function getResult( _event )
					{
						return "Fight1";
					}
				},
				{
					Text = "See other items",
					function getResult( _event )
					{
						return "B1";
					}
				},
				{
					Text = "Not interesting",
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_174.png[/img]{You and the mage come to an agreement on the items. After you exchange coins and goods, you leave your seat for the next guests.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It was a good deal",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().add(_event.m.Xitem);
				this.World.Assets.addMoney(_event.m.Xprice);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Xitem.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(_event.m.Xitem.getName()) + _event.m.Xitem.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend " + (_event.m.Xprice * -1) + " Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Fight1",
			Text = "[img]gfx/ui/events/event_50.png[/img]{The mage\'s expression crumples at your intimidation.%SPEECH_ON%How dare you threaten the mage? You picked the wrong opponent!%SPEECH_OFF%When the mage casts a spell, a group of monsters are summoned and people run away screaming in surprise.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						this.World.Flags.set("AngryMage", 1);
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.Music = this.Const.Music.NobleTracks;
						pp.Entities = [];
						local moba;
						local mobv;
						if (this.Math.rand(1, 100) <= 50)
						{
							moba = [
								"scripts/entity/tactical/enemies/wolf",
								"scripts/entity/tactical/enemies/direwolf",
								"scripts/entity/tactical/enemies/direwolf_high",
								"scripts/entity/tactical/warwolf",
								"scripts/entity/tactical/wardog",
								"scripts/entity/tactical/warhound",
								"scripts/entity/tactical/armored_wardog",
								"scripts/entity/tactical/armored_warhound"
							];
							mobv = 7;
						}
						else
						{
							moba = [
								"scripts/entity/tactical/enemies/zombie",
								"scripts/entity/tactical/enemies/zombie_yeoman",
								"scripts/entity/tactical/enemies/xxmob_fungal_a"
							];
							mobv = 8;
						}
						for( local i = 0; i < mobv; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 2,
								Script = moba[this.Math.rand(0, moba.len() - 1)],
								Faction = this.Const.Faction.Enemy
							});
						}
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 3,
							Script = "scripts/entity/tactical/enemies/xxmob_mage",
							Faction = this.Const.Faction.Enemy
						});
						pp.BeforeDeploymentCallback = function ()
						{
							local size = this.Tactical.getMapSize();

							for( local x = 0; x < size.X; x = ++x )
							{
								for( local y = 0; y < size.Y; y = ++y )
								{
									local tile = this.Tactical.getTileSquare(x, y);
									tile.Level = this.Math.min(1, tile.Level);
									if (this.Math.rand(0, 3) != 1)
									{
										tile.removeObject();
										tile.clear();
									}
								}
							}
						};
						pp.IsFleeingProhibited = true;
						pp.IsLootingProhibited = true;
						pp.IsWithoutAmbience = true;
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "Fight2",
			Text = "[img]gfx/ui/events/event_50.png[/img]{The mage looked at your face carefully and his expression turned bad.%SPEECH_ON%Oh I know you! That\'s the person the mage guild was looking for with a bounty!%SPEECH_OFF%As the wizard cast his spell, his allies were instantly summoned.%SPEECH_ON%There is a bounty on their heads. Capture or Kill!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "To arms!",
					function getResult( _event )
					{
						local pp = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						pp.Music = this.Const.Music.NobleTracks;
						pp.Entities = [];
						for( local i = 0; i < 4; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/humans/bounty_hunter",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 0,
								Script = "scripts/entity/tactical/humans/mercenary",
								Faction = this.Const.Faction.Enemy
							});
						}
						for( local i = 0; i < 2; i = ++i )
						{
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/enemies/xxmob_subzero",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/humans/bounty_hunter_ranged",
								Faction = this.Const.Faction.Enemy
							});
							pp.Entities.push({
								ID = this.Const.EntityType.SkeletonBoss,
								Variant = 0,
								Row = 1,
								Script = "scripts/entity/tactical/humans/mercenary_ranged",
								Faction = this.Const.Faction.Enemy
							});
						}
						pp.Entities.push({
							ID = this.Const.EntityType.SkeletonBoss,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/xxmob_mage",
							Faction = this.Const.Faction.Enemy
						});
						pp.BeforeDeploymentCallback = function ()
						{
							local size = this.Tactical.getMapSize();

							for( local x = 0; x < size.X; x = ++x )
							{
								for( local y = 0; y < size.Y; y = ++y )
								{
									local tile = this.Tactical.getTileSquare(x, y);
									tile.Level = this.Math.min(1, tile.Level);
									if (this.Math.rand(0, 3) != 1)
									{
										tile.removeObject();
										tile.clear();
									}
								}
							}
						};
						pp.IsFleeingProhibited = true;
						pp.IsLootingProhibited = true;
						pp.IsWithoutAmbience = true;
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(pp, false, false, true);
						return 0;
					}
				}
			],
			function start( _event )
			{
			}
		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_60.png[/img]{The fierce battle is over. You and your companions have scoured the area for valuables. After collecting all the valuables, the party decided to leave.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s take what can be money and leave this place",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";
				local xxmoney = this.Math.rand(2000, 3000);
				this.World.Assets.addMoney(xxmoney);
				this.List.push({
					id = 11,
					icon = "ui/items/supplies/money.png",
					text = "You gain " + xxmoney + " gold"
				});
			}
		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_88.png[/img]{Your party was defeated and managed to escape.}",
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

		if (this.World.Assets.getMoney() < 3000)
		{
			return;
		}

		if (this.World.Assets.getStash().getNumberOfEmptySlots() < 1)
		{
			return;
		}

		if (this.World.Flags.get("FantasyMonsterEncounter") == 1)
		{
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
	}

	function onClear()
	{
	}

});

