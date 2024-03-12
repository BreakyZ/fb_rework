this.xxmob_clone <- this.inherit("scripts/entity/tactical/human", {
	m = {
		Info = 0
	},
	function create()
	{
		this.m.Info = this.Math.rand(0, this.World.getPlayerRoster().getAll().len() - 1);
		local brothers = this.World.getPlayerRoster().getAll();
		local curbro = brothers[this.m.Info];
		this.m.Type = this.Const.EntityType.BountyHunter;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BountyHunter.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		if (curbro.hasRangedWeapon())
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
			this.m.AIAgent.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_handgonne"));
		}
		else
		{
			this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		}
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/vampire_hurt_01.wav",
			"sounds/enemies/vampire_hurt_02.wav",
			"sounds/enemies/vampire_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/vampire_death_01.wav",
			"sounds/enemies/vampire_death_02.wav",
			"sounds/enemies/vampire_death_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/vampire_idle_01.wav",
			"sounds/enemies/vampire_idle_02.wav",
			"sounds/enemies/vampire_idle_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		this.getFlags().add("clone");
	}

	function onInit()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local curbro = brothers[this.m.Info];
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(curbro.m.BaseProperties);
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 155)
		{
			b.DamageTotalMult += 0.2;
			b.Hitpoints += this.Math.rand(150, 200);
			b.MeleeDefense += 10;

		}
		else
		{
			b.DamageTotalMult += 0.1;
			b.Hitpoints += this.Math.rand(100, 150);
			b.MeleeDefense += 5;
		}
		b.Stamina += 20;
		if (b.MeleeSkill < 70)
		{
			b.MeleeSkill = 70
		}
		if (b.RangedSkill < 70)
		{
			b.RangedSkill = 70
		}
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Name = curbro.m.Name + "(Doppelganger)";
		local sprites = [
			"body",
			"head",
			"beard",
			"hair",
			"tattoo_body",
			"tattoo_head",
			"beard_top"
		];
		for( local i = 0; i < sprites.len(); i = ++i )
		{
			if (curbro.getSprite(sprites[i]).HasBrush)
			{
				this.getSprite(sprites[i]).setBrush(curbro.getSprite(sprites[i]).getBrush().Name);
				this.getSprite(sprites[i]).Color = curbro.getSprite(sprites[i]).Color;
				this.getSprite(sprites[i]).Saturation = curbro.getSprite(sprites[i]).Saturation;
				this.getSprite(sprites[i]).Scale = curbro.getSprite(sprites[i]).Scale;
			}
			else
			{
				this.getSprite(sprites[i]).resetBrush();
				continue;
			}
		}
		this.addSprite("permanent_injury_5").setHorizontalFlipping(true);
		this.getSprite("permanent_injury_5").setBrush("zombie_rage_eyes");
		this.getSprite("permanent_injury_5").Visible = true;
		this.getSprite("permanent_injury_5").Color = this.createColor("#212121");
		this.getSprite("permanent_injury_5").Saturation = 0.1;
		foreach( skill in curbro.getSkills().m.Skills )
		{
			if (skill.isType(this.Const.SkillType.Perk) && skill.m.ID != "perk.gifted")
			{
				this.m.Skills.add(this.new(this.IO.scriptFilenameByHash(skill.ClassNameHash)));
			}
		}
		local skilla = this.new("scripts/skills/actives/ai_hand_upg");
		skilla.setDamage(10);
		this.m.Skills.add(skilla);
	}

	function assignRandomEquipment()
	{
		this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		local brothers = this.World.getPlayerRoster().getAll();
		local curbro = brothers[this.m.Info];
		local itemz = curbro.m.Items;
		for( local i = 0; i < this.Const.ItemSlot.COUNT; i = ++i )
		{
			for( local j = 0; j < this.Const.ItemSlotSpaces[i]; j = ++j )
			{
				local curitem = itemz.m.Items[i][j];
				if (curitem != null && curitem != -1 && !curitem.isItemType(this.Const.Items.ItemType.Usable) && !curitem.isItemType(this.Const.Items.ItemType.Misc) && 
				curitem.getID() != "accessory.cursed_crystal_skull" && curitem.getID() != "weapon.lute")
				{
					local newitem = this.new(this.IO.scriptFilenameByHash(curitem.ClassNameHash));
					if(curitem.isItemType(this.Const.Items.ItemType.Armor))
					{
						if (curitem.m.Upgrade != null)
						{
							newitem.setUpgrade(this.new(this.IO.scriptFilenameByHash(curitem.m.Upgrade.ClassNameHash)));
						}
					}
					if (curitem.m.Variant != null && curitem.m.Variant != 0)
					{
						newitem.m.Variant = curitem.m.Variant;
						newitem.updateVariant();
					}
					if (this.Const.ItemSlotSpaces[i] == 1)
					{
						this.m.Items.equip(newitem);
					}
					else
					{
						this.m.Items.addToBag(newitem);
					}
					newitem.m.IsDroppedAsLoot = false
				}
			}
		}
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Accessory) != null)
		{
			if (this.m.Skills.hasSkill("actives.unleash_wardog") || this.m.Skills.hasSkill("actives.unleash_wolf"))
			{
				this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Accessory));
			}
		}
		this.getSkills().update();
	}

	function onTurnStart()
	{
		this.actor.setMoraleState(this.Const.MoraleState.Steady);
		//
		this.actor.onTurnStart();
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			this.m.IsCorpseFlipped = flip;
			local decal = _tile.spawnDetail("desert_bones_01", this.Const.Tactical.DetailFlag.Corpse, flip, false);
			decal.Scale = 0.7;
			decal.setBrightness(0.8);
			decal.Saturation = 0.5;
			this.spawnTerrainDropdownEffect(_tile);
		}
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local loot;
			if (this.Math.rand(1, 100) <= 30)
			{
				loot = this.new("scripts/items/loot/soul_splinter_item");
				loot.drop(_tile);
			}
			if (this.Math.rand(1, 100) <= 5)
			{
				loot = this.new("scripts/items/loot/ancient_gold_coins_item");
				loot.drop(_tile);
			}
		}
		this.m.BloodType = this.Const.BloodType.Ash;
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});

