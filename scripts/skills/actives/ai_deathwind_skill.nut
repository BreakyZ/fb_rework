this.ai_deathwind_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0,
		AffectedTiles = []
	},
	function create()
	{
		this.m.ID = "actives.ai_punch";
		this.m.Name = "Death Wind";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_takeoff_01.wav",
			"sounds/enemies/vampire_takeoff_02.wav",
			"sounds/enemies/vampire_takeoff_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsTargetingActor = false;
		this.m.InjuriesOnBody = this.Const.Injury.BurningBody;
		this.m.InjuriesOnHead = this.Const.Injury.BurningHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.AffectedTiles.len() == 0 && this.m.Cooldown == 0;
	}

	function isWaitingOnImpact()
	{
		return this.m.AffectedTiles.len() != 0;
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [
			_targetTile
		];
		local myTile = this.m.Container.getActor().getTile();

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				ret.push(myTile.getNextTile(i));
			}
		}

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				ret.push(_targetTile.getNextTile(i));
			}
		}

		return ret;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
		if (this.m.AffectedTiles.len() != 0)
		{
			this.getContainer().getActor().setActionPoints(0);
			this.Time.scheduleEvent(this.TimeUnit.Real, 400, this.onImpact.bindenv(this), this);
			this.Sound.play("sounds/enemies/lindwurm_gorge_01.wav", 1.5, this.m.AffectedTiles[0].Pos);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, function ( _skill ){}.bindenv(this), this);
		}
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		this.m.AffectedTiles = this.getAffectedTiles(_targetTile);
		for( local i = 0; i < this.Const.Tactical.RaiseUndeadParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(true, this.Const.Tactical.RaiseUndeadParticles[i].Brushes, _user.getTile(), this.Const.Tactical.RaiseUndeadParticles[i].Delay, this.Const.Tactical.RaiseUndeadParticles[i].Quantity, this.Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseUndeadParticles[i].SpawnRate, this.Const.Tactical.RaiseUndeadParticles[i].Stages);
		}
		foreach( tile in this.m.AffectedTiles )
		{
			tile.Properties.IsMarkedForImpact = true;
			tile.spawnDetail("mortar_target_02", this.Const.Tactical.DetailFlag.SpecialOverlay, false, true);
		}
		return true;
	}

	function onImpact( _tag )
	{
		local actor = this.getContainer().getActor();
		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _tag.m.AffectedTiles[0].Pos);
		this.Tactical.getCamera().quake(this.createVec(0, -1.0), 36.0, 0.16, 0.35);
		foreach( i, t in _tag.m.AffectedTiles )
		{
			this.Time.scheduleEvent(this.TimeUnit.Real, i * 30, function ( _data )
			{
				local tile = _data.Tile;
				for( local i = 0; i < this.Const.Tactical.RaiseUndeadParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.RaiseUndeadParticles[i].Brushes, tile, this.Const.Tactical.RaiseUndeadParticles[i].Delay, this.Const.Tactical.RaiseUndeadParticles[i].Quantity, this.Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseUndeadParticles[i].SpawnRate, this.Const.Tactical.RaiseUndeadParticles[i].Stages);
				}
				_data.Skill.spawnAttackEffect(tile, this.Const.Tactical.AttackEffectSlash);
				_data.Skill.spawnAttackEffect(tile, this.Const.Tactical.AttackEffectChop);
				_data.Skill.spawnAttackEffect(tile, this.Const.Tactical.AttackEffectSplit);
				_data.Skill.spawnAttackEffect(tile, this.Const.Tactical.AttackEffectThrust);
				_data.Skill.spawnAttackEffect(tile, this.Const.Tactical.AttackEffectBash);
				_data.Skill.spawnAttackEffect(tile, this.Const.Tactical.AttackEffectSwing);

				tile.clear(this.Const.Tactical.DetailFlag.SpecialOverlay);
				tile.Properties.IsMarkedForImpact = false;
				if ((tile.IsEmpty || tile.IsOccupiedByActor) && tile.Type != this.Const.Tactical.TerrainType.ShallowWater && tile.Type != this.Const.Tactical.TerrainType.DeepWater)
				{
					tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
				if (tile.IsOccupiedByActor && !_data.User.isAlliedWith(tile.getEntity()))
				{
					local target = tile.getEntity();
					local hitInfo = clone this.Const.Tactical.HitInfo;
					hitInfo.DamageRegular = this.Math.rand(200, 220);
					hitInfo.DamageArmor = hitInfo.DamageRegular * 1.5;
					hitInfo.DamageDirect = 0.5;
					hitInfo.BodyPart = 0;
					hitInfo.FatalityChanceMult = 0.0;
					hitInfo.Injuries = this.Const.Injury.Burning;
					target.onDamageReceived(_data.User, _data.Skill, hitInfo);
				}
			}, {
				Tile = t,
				Skill = this,
				User = actor
			});
		}
		_tag.m.AffectedTiles = [];
	}

});

