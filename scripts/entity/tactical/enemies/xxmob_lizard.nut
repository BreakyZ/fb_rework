this.xxmob_lizard <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Name = "Lizardman";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.XP = this.Const.Tactical.Actor.GoblinFighter.XP;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.BloodSplatterOffset = this.createVec(-10, 15);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/goblin_death_00.wav",
			"sounds/enemies/goblin_death_01.wav",
			"sounds/enemies/goblin_death_02.wav",
			"sounds/enemies/goblin_death_03.wav",
			"sounds/enemies/goblin_death_04.wav",
			"sounds/enemies/goblin_death_05.wav",
			"sounds/enemies/goblin_death_06.wav",
			"sounds/enemies/goblin_death_07.wav",
			"sounds/enemies/goblin_death_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/goblin_flee_00.wav",
			"sounds/enemies/goblin_flee_01.wav",
			"sounds/enemies/goblin_flee_02.wav",
			"sounds/enemies/goblin_flee_03.wav",
			"sounds/enemies/goblin_flee_04.wav",
			"sounds/enemies/goblin_flee_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/goblin_hurt_00.wav",
			"sounds/enemies/goblin_hurt_01.wav",
			"sounds/enemies/goblin_hurt_02.wav",
			"sounds/enemies/goblin_hurt_03.wav",
			"sounds/enemies/goblin_hurt_04.wav",
			"sounds/enemies/goblin_hurt_05.wav",
			"sounds/enemies/goblin_hurt_06.wav",
			"sounds/enemies/goblin_hurt_07.wav",
			"sounds/enemies/goblin_hurt_08.wav",
			"sounds/enemies/goblin_hurt_09.wav",
			"sounds/enemies/goblin_hurt_10.wav",
			"sounds/enemies/goblin_hurt_11.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/goblin_idle_00.wav",
			"sounds/enemies/goblin_idle_01.wav",
			"sounds/enemies/goblin_idle_02.wav",
			"sounds/enemies/goblin_idle_03.wav",
			"sounds/enemies/goblin_idle_04.wav",
			"sounds/enemies/goblin_idle_05.wav",
			"sounds/enemies/goblin_idle_06.wav",
			"sounds/enemies/goblin_idle_07.wav",
			"sounds/enemies/goblin_idle_08.wav",
			"sounds/enemies/goblin_idle_09.wav",
			"sounds/enemies/goblin_idle_10.wav",
			"sounds/enemies/goblin_idle_11.wav",
			"sounds/enemies/goblin_idle_12.wav",
			"sounds/enemies/goblin_idle_13.wav",
			"sounds/enemies/goblin_idle_14.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Flee] = 1.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 0.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.SoundPitch = this.Math.rand(95, 110) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 155)
		{
			b.DamageTotalMult *= 2;
			b.MeleeSkill += 10;
			b.Hitpoints += 170;
			b.Bravery += 50;
			b.MeleeDefense += this.Math.rand(20, 25);
		}
		else
		{
			b.DamageTotalMult *= 1.5;
			b.MeleeSkill += 5;
			b.Hitpoints += 80;
			b.Bravery += 30;
			b.MeleeDefense += this.Math.rand(15, 20);
		}
		b.DamageReceivedRangedMult *= 0.5;
		b.Stamina += 100;
		b.Initiative += this.Math.rand(1, 20);
		b.MovementAPCostAdditional += 1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_lizard_0" + this.Math.rand(1, 2));
		body.varySaturation(0.2);
		body.varyColor(0.06, 0.06, 0.06);
		local injury_body = this.addSprite("injury_body");
		injury_body.setBrush("bust_orc_02_body_bloodied_03");
		injury_body.Scale = 0.8;
		injury_body.Visible = false;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_alp_01_injured");
		injury.Scale = 0.8;
		injury.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 10));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
	}

	function assignRandomEquipment()
	{
		local shields = [
			"shields/greenskins/goblin_light_shield",
			"shields/greenskins/goblin_heavy_shield",
			"shields/greenskins/orc_light_shield"
		];
		this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		shields = [
			"weapons/ancient/ancient_spear",
			"weapons/greenskins/goblin_spear",
			"weapons/militia_spear",
			"weapons/shortsword",
			"weapons/hatchet"
		];
		this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
	}

	function onTurnStart()
	{
		if (this.actor.getHitpoints() < this.actor.getHitpointsMax() * 0.9)
		{
			local b = this.m.BaseProperties;
			if (b.MeleeDefense >= 4)
			{
				b.MeleeDefense -= 4;
				this.actor.getSkills().removeByType(this.Const.SkillType.TemporaryInjury);
			}
			if (this.getTile().IsVisibleForPlayer)
			{
				this.Tactical.spawnIconEffect("status_effect_79", this.getTile(), this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			}
			this.Sound.play("sounds/enemies/unhold_regenerate_01.wav", 1.5, this.getTile().Pos);
			this.actor.setHitpoints(this.actor.getHitpointsMax());
		}
		this.actor.onTurnStart();
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
				loot = this.new("scripts/items/supplies/strange_meat_item");
				loot.randomizeAmount()
				loot.drop(_tile);
			}
			if (this.Math.rand(1, 100) <= 20)
			{
				loot = this.new("scripts/items/loot/growth_pearls_item");
				loot.drop(_tile);
			}
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});

