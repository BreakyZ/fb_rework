this.ai_goblinkingaxe <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.ai_punch";
		this.m.Name = "Throw Axe";
		this.m.Overlay = "active_87";
		this.m.SoundOnUse = [
			"sounds/combat/throw_axe_01.wav",
			"sounds/combat/throw_axe_02.wav",
			"sounds/combat/throw_axe_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/throw_axe_hit_01.wav",
			"sounds/combat/throw_axe_hit_02.wav",
			"sounds/combat/throw_axe_hit_03.wav"
		];
		this.m.SoundOnHitDelay = -150;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 1;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Axe;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsRanged = true;
		this.attackEntity(_user, _targetTile.getEntity(), false);
		this.m.IsRanged = false;
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = 50;
			_properties.DamageRegularMax = 55;
			_properties.DamageArmorMult = 0.7;
			_properties.RangedAttackBlockedChanceMult *= 0;
		}
	}

});

