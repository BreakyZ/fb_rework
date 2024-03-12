this.fantasy_monster_encounter_9_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.fantasy_monster_encounter_9_event";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_36.png[/img]{You halted your steps in front of a small but well-tended tomb. Judging by the flowers left by people, it seemed to be the grave of someone quite respected. On the gravestone, the following inscription was written.%SPEECH_ON%A nameless warrior, who sacrificed themselves to save many, rests here.%SPEECH_OFF%You recalled hearing about this tomb before. It was said to be the resting place of a valiant warrior who sacrificed his life fighting against evil to safeguard the lives of others. A sorcerer, who had been his companion, cast a spell on the tomb, ensuring that grave robbers couldn\'t recklessly disturb it.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Dig into the tomb in search of the item",
					function getResult( _event )
					{
						return "B";
					}
				},
				{
					Text = "Leave the tomb undisturbed",
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
			Text = "[img]gfx/ui/events/event_12.png[/img]{At the end of digging through the tomb, you discovered the artifact once wielded by the warrior. However, as you unearthed it, a unsettling mist enveloped you. Could it be that there is truly a curse lingering within the tomb?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I have a bad feeling...",
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
					if (this.Math.rand(1, 100) <= 20)
					{
						if (!bro.getFlags().get("IsPlayerCharacter") && !bro.getSkills().hasSkill("trait.player") && this.Math.rand(1, 100) <= 9)
						{
							local fallen = {
								Name = bro.getName(),
								Time = this.World.getTime().Days,
								TimeWithCompany = this.Math.max(1, bro.getDaysWithCompany()),
								Kills = bro.getLifetimeStats().Kills,
								Battles = bro.getLifetimeStats().Battles,
								KilledBy = "Died suddenly",
								Expendable = false
							};
							this.World.Statistics.addFallen(fallen);
							this.List.push({
								id = 10,
								icon = "ui/icons/kills.png",
								text = bro.getName() + " has died"
							});
							bro.getItems().transferToStash(this.World.Assets.getStash());
							bro.getSkills().onDeath(this.Const.FatalityType.None);
							this.World.getPlayerRoster().remove(bro);
						}
						else
						{
							local injury = bro.addInjury(this.Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " suffers " + injury.getNameOnly()
							});
							bro.addLightInjury();
						}
					}
				}

				local items = this.World.Assets.getStash().getItems();
				local noitem = true;
				local candidates = [];
				foreach( item in items )
				{
					if (item == null)
					{
						continue;
					}
					if (item.isItemType(this.Const.Items.ItemType.Legendary) || item.isIndestructible())
					{
						continue;
					}
					if (item.isItemType(this.Const.Items.ItemType.Weapon) || item.isItemType(this.Const.Items.ItemType.Shield) || item.isItemType(this.Const.Items.ItemType.Armor) || item.isItemType(this.Const.Items.ItemType.Helmet))
					{
						candidates.push(item);
						noitem = false;
					}
				}
				if (!noitem && this.Math.rand(1, 100) <= 20)
				{
					local iitem = candidates[this.Math.rand(0, candidates.len() - 1)];
					this.World.Assets.getStash().remove(iitem);
					this.List.push({
						id = 11,
						icon = "ui/items/" + iitem.getIcon(),
						text = "You lose " + this.Const.Strings.getArticle(iitem.getName()) + iitem.getName()
					});
				}

				if (this.World.Assets.getMoney() >= 100 && this.Math.rand(1, 100) <= 20)
				{
					local rr = this.Math.floor(this.World.Assets.getMoney() / 2);
					if (rr >= 10000)
					{
						rr = 10000;
					}
					this.World.Assets.addMoney(-rr);
					this.List.push({
						id = 12,
						icon = "ui/items/supplies/money.png",
						text = "You lost " + rr + " gold"
					});
				}

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
						"helmets/named/gold_and_black_turban",
						"helmets/named/golden_feathers_helmet",
						"helmets/named/heraldic_mail_helmet",
						"helmets/named/lindwurm_helmet",
						"helmets/named/named_conic_helmet_with_faceguard",
						"helmets/named/named_metal_bull_helmet",
						"helmets/named/named_metal_nose_horn_helmet",
						"helmets/named/named_metal_skull_helmet",
						"helmets/named/named_nordic_helmet_with_closed_mail",
						"helmets/named/named_steppe_helmet_with_mail",
						"helmets/named/nasal_feather_helmet",
						"helmets/named/norse_helmet",
						"helmets/named/red_and_gold_band_helmet",
						"helmets/named/sallet_green_helmet",
						"helmets/named/red_and_gold_band_helmet",
						"helmets/named/wolf_helmet",
						"armor/named/black_and_gold_armor",
						"armor/named/black_leather_armor",
						"armor/named/blue_studded_mail_armor",
						"armor/named/brown_coat_of_plates_armor",
						"armor/named/golden_scale_armor",
						"armor/named/green_coat_of_plates_armor",
						"armor/named/heraldic_mail_armor",
						"armor/named/leopard_armor",
						"armor/named/lindwurm_armor",
						"armor/named/named_bronze_armor",
						"armor/named/named_golden_lamellar_armor",
						"armor/named/named_noble_mail_armor",
						"armor/named/named_plated_fur_armor",
						"armor/named/named_sellswords_armor",
						"armor/named/named_skull_and_chain_armor",
						"shields/named/named_bandit_heater_shield",
						"shields/named/named_bandit_kite_shield",
						"shields/named/named_dragon_shield",
						"shields/named/named_full_metal_heater_shield",
						"shields/named/named_golden_round_shield",
						"shields/named/named_lindwurm_shield",
						"shields/named/named_orc_heavy_shield",
						"shields/named/named_red_white_shield",
						"shields/named/named_rider_on_horse_shield",
						"shields/named/named_sipar_shield",
						"shields/named/named_undead_heater_shield",
						"shields/named/named_undead_kite_shield",
						"shields/named/named_wing_shield",
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
					id = 15,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain "  + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
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

