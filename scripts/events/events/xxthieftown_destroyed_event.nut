this.xxthieftown_destroyed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.xxthieftown_destroyed_event";
		this.m.Title = "After the battle";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_68.png[/img]The bloody battle is over. You and your companions have scoured the town for valuables. After collecting all the valuables, your party decided to leave this place.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We will use these well. Rest in peace",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(2);
				local weapons = [
						"weapons/named/named_axe",
						"weapons/named/named_billhook",
						"weapons/named/named_cleaver",
						"weapons/named/named_flail",
						"weapons/named/named_greataxe",
						"weapons/named/named_greatsword",
						"weapons/named/named_longaxe",
						"weapons/named/named_mace",
						"weapons/named/named_orc_axe",
						"weapons/named/named_orc_cleaver",
						"weapons/named/named_pike",
						"weapons/named/named_spear",
						"weapons/named/named_sword",
						"weapons/named/named_warhammer"
				];
				if (this.Const.DLC.Unhold && this.Const.DLC.Wildmen && this.Const.DLC.Desert)
				{
					weapons = [
						"weapons/named/named_axe",
						"weapons/named/named_bardiche",
						"weapons/named/named_battle_whip",
						"weapons/named/named_billhook",
						"weapons/named/named_bladed_pike",
						"weapons/named/named_cleaver",
						"weapons/named/named_crossbow",
						"weapons/named/named_crypt_cleaver",
						"weapons/named/named_dagger",
						"weapons/named/named_fencing_sword",
						"weapons/named/named_flail",
						"weapons/named/named_goblin_falchion",
						"weapons/named/named_goblin_heavy_bow",
						"weapons/named/named_goblin_pike",
						"weapons/named/named_goblin_spear",
						"weapons/named/named_greataxe",
						"weapons/named/named_greatsword",
						"weapons/named/named_handgonne",
						"weapons/named/named_heavy_rusty_axe",
						"weapons/named/named_javelin",
						"weapons/named/named_khopesh",
						"weapons/named/named_longaxe",
						"weapons/named/named_mace",
						"weapons/named/named_orc_axe",
						"weapons/named/named_orc_cleaver",
						"weapons/named/named_pike",
						"weapons/named/named_polehammer",
						"weapons/named/named_polemace",
						"weapons/named/named_qatal_dagger",
						"weapons/named/named_rusty_warblade",
						"weapons/named/named_shamshir",
						"weapons/named/named_skullhammer",
						"weapons/named/named_spear",
						"weapons/named/named_spetum",
						"weapons/named/named_sword",
						"weapons/named/named_swordlance",
						"weapons/named/named_three_headed_flail",
						"weapons/named/named_throwing_axe",
						"weapons/named/named_two_handed_flail",
						"weapons/named/named_two_handed_hammer",
						"weapons/named/named_two_handed_mace",
						"weapons/named/named_two_handed_scimitar",
						"weapons/named/named_two_handed_spiked_mace",
						"weapons/named/named_warbow",
						"weapons/named/named_warbrand",
						"weapons/named/named_warhammer",
						"weapons/named/named_warscythe"
					];
				}
				local item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/named/xxcrosslance");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 11,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				this.World.Assets.addMoney(5000);
				this.List.push({
					id = 12,
					icon = "ui/items/supplies/money.png",
					text = "You gain 5000 gold"
				});
			}
		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A"
	}

	function onClear()
	{
	}

});

