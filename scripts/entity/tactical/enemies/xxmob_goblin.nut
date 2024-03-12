this.xxmob_goblin <- this.inherit("scripts/entity/tactical/goblin", {
	m = {},
	function create()
	{
		this.m.Name = "Goblin Berserker";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.XP = this.Const.Tactical.Actor.GoblinFighter.XP;
		this.goblin.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/xxmonster_a_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		b.IsSpecializedInCleavers = true;
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 155)
		{
			b.DamageTotalMult += 0.2;
			b.MeleeSkill += 20;
		}
		b.Hitpoints += 95;
		b.MeleeDefense += 30;
		b.RangedDefense += 25;
		b.Bravery += 50;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("body").setBrush("");
		this.getSprite("head").setBrush("");
		this.addSprite("bodyb").setBrush("bust_goblin_01_body");
		this.getSprite("bodyb").Color = this.createColor("#fffb85");
		this.addSprite("tattoo_body").setBrush("bust_orc_02_armor_0" + this.Math.rand(1, 2));
		this.getSprite("tattoo_body").Scale = 0.7;
		this.getSprite("tattoo_body").Saturation = 1.2;
		this.addSprite("headb").setBrush("bust_goblin_0" + this.Math.rand(1, 3) + "_head_01");
		this.getSprite("headb").Color = this.createColor("#fffb85");
		this.addSprite("hair").setBrush("zombie_rage_eyes");
		this.getSprite("hair").setHorizontalFlipping(true);
		this.getSprite("hair").Color = this.createColor("#ffa3a3");
		this.getSprite("hair").Saturation = 1.5;
		this.setSpriteOffset("hair", this.createVec(2, -11));
		this.addSprite("beard").setBrush("bust_goblin_04_helmet_0" + this.Math.rand(1, 2));
		this.addSprite("beard_top").setBrush("bust_goblin_04_helmet_03");
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_goblinbuff"));
		this.setAlwaysApplySpriteOffset(true);
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/named/named_warbrand"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			for( local i = 0; i < this.Const.Tactical.KrakenDevourVictimParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.KrakenDevourVictimParticles[i].Brushes, _tile, this.Const.Tactical.KrakenDevourVictimParticles[i].Delay, this.Const.Tactical.KrakenDevourVictimParticles[i].Quantity, this.Const.Tactical.KrakenDevourVictimParticles[i].LifeTimeQuantity, this.Const.Tactical.KrakenDevourVictimParticles[i].SpawnRate, this.Const.Tactical.KrakenDevourVictimParticles[i].Stages);
			}
			for( local i = 0; i < this.Const.Tactical.GruesomeFeastParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.GruesomeFeastParticles[i].Brushes, _tile, this.Const.Tactical.GruesomeFeastParticles[i].Delay, this.Const.Tactical.GruesomeFeastParticles[i].Quantity, this.Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, this.Const.Tactical.GruesomeFeastParticles[i].SpawnRate, this.Const.Tactical.GruesomeFeastParticles[i].Stages);
			}
			local flip = this.Math.rand(0, 100) < 50;
			this.m.IsCorpseFlipped = flip;
			local decal;
			for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
			{
				decal = _tile.spawnDetail(this.Const.CorpsePart[i]);
				decal.Scale = 1.15;
			}
			this.spawnTerrainDropdownEffect(_tile);
			this.spawnBloodPool(_tile, 1);
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
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onTurnEnd()
	{
		this.actor.onTurnEnd();
		if (this.Tactical.Entities.isEnemyRetreating() || this.Tactical.State.isAutoRetreat() || !this.m.IsAlive || this.m.IsDying)
		{
			return;
		}
		if (!this.m.Skills.hasSkill("effects.ai_goblinbuff"))
		{
			return;
		}
		if (this.Time.getRound() >= 6 && this.Math.rand(1, 100) <= 15)
		{
			this.m.Skills.removeByID("effects.ai_goblinbuff");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
			local b = this.m.BaseProperties;
			b.DamageTotalMult *= 2;
			b.MeleeSkill += 50;
			b.MeleeDefense -= 50;
			b.RangedDefense -= 50;
			this.actor.setMoraleState(this.Const.MoraleState.Confident);
			this.actor.setHitpoints(this.actor.getHitpointsMax());
			for( local i = 0; i < this.Const.Tactical.KrakenDevourParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.KrakenDevourParticles[i].Brushes, this.getTile(), this.Const.Tactical.KrakenDevourParticles[i].Delay, this.Const.Tactical.KrakenDevourParticles[i].Quantity, this.Const.Tactical.KrakenDevourParticles[i].LifeTimeQuantity, this.Const.Tactical.KrakenDevourParticles[i].SpawnRate, this.Const.Tactical.KrakenDevourParticles[i].Stages);
			}
			for( local i = 0; i < this.Const.Tactical.KrakenDevourVictimParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.KrakenDevourVictimParticles[i].Brushes, this.getTile(), this.Const.Tactical.KrakenDevourVictimParticles[i].Delay, this.Const.Tactical.KrakenDevourVictimParticles[i].Quantity, this.Const.Tactical.KrakenDevourVictimParticles[i].LifeTimeQuantity, this.Const.Tactical.KrakenDevourVictimParticles[i].SpawnRate, this.Const.Tactical.KrakenDevourVictimParticles[i].Stages);
			}
			if (this.getTile().IsVisibleForPlayer)
			{
				this.Tactical.spawnIconEffect("status_effect_34", this.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);			
			}
			this.Sound.play("sounds/enemies/goblin_flee_0" + this.Math.rand(1, 2) + ".wav", 1.5, this.getTile().Pos);
			this.actor.getSprite("headb").Color = this.createColor("#ff9999");
			this.actor.getSprite("bodyb").Color = this.createColor("#ff9999");
			this.actor.getSprite("headb").Scale = 1.15;
			this.actor.getSprite("bodyb").Scale = 1.15;
			this.actor.getSprite("headb").Saturation = 0.5;
			this.actor.getSprite("bodyb").Saturation = 0.5;
			this.actor.setSpriteOffset("hair", this.createVec(2, -12));
			this.actor.getSprite("hair").Scale = 1.15;
			this.actor.getSprite("tattoo_body").setBrush("");
			this.actor.getSprite("beard").setBrush("");
			this.actor.getSprite("beard_top").setBrush("");
		}
	}

	function onUpdateInjuryLayer()
	{
		local p = this.m.Hitpoints / this.getHitpointsMax();
		if (p < 0.4)
		{
			if (this.hasSprite("injuryb"))
			{
				this.removeSprite("injuryb");
			}
			this.addSprite("injuryb").setBrush("bust_orc_02_body_bloodied_04");
			this.getSprite("injuryb").Scale = 0.7;
		}
		else
		{
			if (this.hasSprite("injuryb"))
			{
				this.removeSprite("injuryb");
			}
		}
	}

});

