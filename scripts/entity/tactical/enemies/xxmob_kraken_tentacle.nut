this.xxmob_kraken_tentacle <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Name = "Abyssal Tentacle";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(15, -26);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.DeathBloodAmount = 0.0;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/lindwurm_death_01.wav",
			"sounds/enemies/lindwurm_death_02.wav",
			"sounds/enemies/lindwurm_death_03.wav",
			"sounds/enemies/lindwurm_death_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/lindwurm_hurt_01.wav",
			"sounds/enemies/lindwurm_hurt_02.wav",
			"sounds/enemies/lindwurm_hurt_03.wav",
			"sounds/enemies/lindwurm_hurt_04.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 2.0;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/xxmonster_a_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.Vision = 11;
		b.Hitpoints += this.Math.rand(250, 300);
		b.Bravery += 100;
		b.Stamina += 100;
		b.MeleeSkill += 30;
		b.RangedSkill += 1;
		b.MeleeDefense -= 10;
		b.RangedDefense -= 10;
		b.Initiative += 10;
		b.MovementAPCostAdditional += 10;
		b.DamageRegularMin += 80;
		b.DamageRegularMax += 90;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		if (this.Math.rand(1, 3) == 3)
		{
			body.setBrush("bust_kraken_tentacle_01");
		}
		else
		{
			body.setBrush("bust_kraken_tentacle_02");
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_cleaver"));
		}
		body.Color = this.createColor("#e0e6ff");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.68;
		this.setSpriteOffset("status_rooted", this.createVec(5, 25));
		this.setSpriteOffset("arrow", this.createVec(0, 25));
		this.setSpriteOffset("status_stunned", this.createVec(0, 25));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_monsterbite"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_linebreaker"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_earthmove"));
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
			local decal = _tile.spawnDetail("bust_kraken_tentacle_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false);
			decal.Color = this.createColor("#e0e6ff");
			this.spawnTerrainDropdownEffect(_tile);
			this.spawnBloodPool(_tile, 1);

			local corpse = clone this.Const.Corpse;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.IsHeadAttached = true;
			corpse.IsConsumable = true;
			corpse.IsResurrectable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onUpdateInjuryLayer()
	{
		local body = this.getSprite("body");
		local p = this.getHitpointsPct();
		if (p < 0.5)
		{
			if (this.getSkills().hasSkill("perk.mastery.cleaver"))
			{
				body.setBrush("bust_kraken_tentacle_02_injured");
			}
			else
			{
				body.setBrush("bust_kraken_tentacle_01_injured");
			}
		}
		this.setDirty(true);
	}

});

