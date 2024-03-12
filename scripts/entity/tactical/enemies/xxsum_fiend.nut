this.xxsum_fiend <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Name = "Fiend";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Direwolf.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-10, -25);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.ExcludedInjuries = [
			"injury.fractured_hand",
			"injury.crushed_finger",
			"injury.fractured_elbow",
			"injury.smashed_hand",
			"injury.broken_arm",
			"injury.cut_arm_sinew",
			"injury.cut_arm",
			"injury.split_hand",
			"injury.pierced_hand",
			"injury.pierced_arm_muscles",
			"injury.burnt_hands"
		];
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/unhold_death_01.wav",
			"sounds/enemies/unhold_death_02.wav",
			"sounds/enemies/unhold_death_03.wav",
			"sounds/enemies/unhold_death_04.wav",
			"sounds/enemies/unhold_death_05.wav",
			"sounds/enemies/unhold_death_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/unhold_flee_01.wav",
			"sounds/enemies/unhold_flee_02.wav",
			"sounds/enemies/unhold_flee_03.wav",
			"sounds/enemies/unhold_flee_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/unhold_hurt_01.wav",
			"sounds/enemies/unhold_hurt_02.wav",
			"sounds/enemies/unhold_hurt_03.wav",
			"sounds/enemies/unhold_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/unhold_idle_01.wav",
			"sounds/enemies/unhold_idle_02.wav",
			"sounds/enemies/unhold_idle_03.wav",
			"sounds/enemies/unhold_idle_04.wav",
			"sounds/enemies/unhold_idle_05.wav",
			"sounds/enemies/unhold_idle_06.wav",
			"sounds/enemies/unhold_idle_07.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle]
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.8;
		this.m.SoundPitch = this.Math.rand(0.9, 1.1);
		this.m.SoundVolumeOverall = 1.25;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/xxmonster_a_agent");
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		this.m.AIAgent.setActor(this);
		this.m.IsActingImmediately = true;
		this.getFlags().add("fiend_minion");
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
		{
			return;
		}
		this.actor.playSound(_type, _volume, _pitch);
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
			this.spawnBloodPool(_tile, 1);
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		b.IsImmuneToDisarm = true;
		b.IsAffectedByLosingHitpoints = false;
		b.IsAffectedByFleeingAllies = false;
		b.IsAffectedByDyingAllies = false;
		b.IsAffectedByFreshInjuries = false;
		b.IsAffectedByInjuries = false;
		b.IsAffectedByNight = false;
		b.DamageRegularMin += 50;
		b.DamageRegularMax += 80;
		b.Bravery += 30;
		b.Hitpoints += 145;
		b.MeleeSkill += this.Math.rand(10, 15);
		b.MeleeDefense += this.Math.rand(5, 10);
		b.RangedDefense += 1;
		b.ActionPoints += 1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_eyemon_01");

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.25);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.11, 0.11, 0.11);
		}

		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_direwolf_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		local skilla = this.new("scripts/skills/actives/ai_punch");
		skilla.m.Overlay = "active_112";
		skilla.m.SoundOnUse = [
			"sounds/combat/shatter_01.wav",
			"sounds/combat/shatter_02.wav",
			"sounds/combat/shatter_03.wav"
		];
		skilla.m.SoundOnHit = [
			"sounds/enemies/unhold_swipe_hit_01.wav",
			"sounds/enemies/unhold_swipe_hit_02.wav",
			"sounds/enemies/unhold_swipe_hit_04.wav",
			"sounds/enemies/unhold_swipe_hit_05.wav"
		];
		skilla.m.ActionPointCost = 6;
		skilla.m.DirectDamageMult = 0.4;
		this.m.Skills.add(skilla);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
	}

});

