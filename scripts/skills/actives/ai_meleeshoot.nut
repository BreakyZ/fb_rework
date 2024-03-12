this.ai_meleeshoot <- this.inherit("scripts/skills/skill", {
	//spiderhag9 fungalgiant9
	m = {},
	function create()
	{
		this.m.ID = "actives.ai_punch";
		this.m.Name = "Attack";
		this.m.Overlay = "active_101";
		this.m.SoundOnUse = [
			"sounds/enemies/goblin_attack_00.wav",
			"sounds/enemies/goblin_attack_01.wav",
			"sounds/enemies/goblin_attack_02.wav",
			"sounds/enemies/goblin_attack_03.wav",
			"sounds/enemies/goblin_attack_04.wav",
			"sounds/enemies/goblin_attack_05.wav",
			"sounds/enemies/goblin_attack_06.wav",
			"sounds/enemies/goblin_attack_07.wav",
			"sounds/enemies/goblin_attack_08.wav",
			"sounds/enemies/goblin_attack_09.wav",
			"sounds/enemies/goblin_attack_10.wav",
			"sounds/enemies/goblin_attack_11.wav",
			"sounds/enemies/goblin_attack_12.wav",
			"sounds/enemies/goblin_attack_13.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 100;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.xxgreenspear;
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsRanged = true;
		if (_user.getTile().getDistanceTo(_targetTile) > 1)
		{
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;
			if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.5, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, function ( _skill )
			{
				if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
				{
					this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 0.7 + (this.Math.rand(0, 2) * 0.1), this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}
			}.bindenv(this), this);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 150, function ( _skill )
			{
				if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
				{
					this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 0.3 + (this.Math.rand(0, 2) * 0.1), this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}
			}.bindenv(this), this);
		}
		this.attackEntity(_user, _targetTile.getEntity(), false);
		this.m.IsRanged = false;
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedAttackBlockedChanceMult *= 0;
			_properties.HitChanceAdditionalWithEachTile += -1;
		}
	}

});

