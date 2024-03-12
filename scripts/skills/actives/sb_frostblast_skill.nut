this.sb_frostblast_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SnowTiles = []
	},
	function create()
	{
		this.m.ID = "actives.sb_frostblast_skill";
		this.m.Name = "Frost Blast";
		this.m.Description = "Casts a powerful cold spell. The area affected by the skill turns into a snow tile, and units located at that point become cold.";
		this.m.Icon = "ui/xx7.png";
		this.m.IconDisabled = "ui/xx7_sw.png";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_takeoff_01.wav",
			"sounds/enemies/vampire_takeoff_02.wav",
			"sounds/enemies/vampire_takeoff_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.SoundOnHitDelay = 0;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsWeaponSkill = false;
		this.m.IsUsingHitchance = true;
		this.m.IsDoingForwardMove = false;
		this.m.IsTargetingActor = false;
		this.m.IsAOE = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;

		for( local i = 1; i <= 3; i = ++i )
		{
			this.m.SnowTiles.push(this.MapGen.get("tactical.tile.snow" + i));
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "+5% Hit chance, Ranged attack type, Ignores obstacles and only attacks selected targets, Can hit up to 7 targets"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "+2 Max damage per level"
		});
		return ret;
	}

	function applyEffectToTargets( _tag )
	{
		local user = _tag.User;
		local targets = _tag.Targets;

		foreach( t in targets )
		{
			for( local i = 0; i < this.Const.Tactical.SpiritWalkEndParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SpiritWalkEndParticles[i].Brushes, t, this.Const.Tactical.SpiritWalkEndParticles[i].Delay, this.Const.Tactical.SpiritWalkEndParticles[i].Quantity, this.Const.Tactical.SpiritWalkEndParticles[i].LifeTimeQuantity, this.Const.Tactical.SpiritWalkEndParticles[i].SpawnRate, this.Const.Tactical.SpiritWalkEndParticles[i].Stages);
			}

			if (t.Subtype != this.Const.Tactical.TerrainSubtype.Snow && t.Subtype != this.Const.Tactical.TerrainSubtype.LightSnow)
			{
				t.clear();
				t.Type = 0;
				_tag.Skill.m.SnowTiles[this.Math.rand(0, _tag.Skill.m.SnowTiles.len() - 1)].onFirstPass({
					X = t.SquareCoords.X,
					Y = t.SquareCoords.Y,
					W = 1,
					H = 1,
					IsEmpty = true,
					SpawnObjects = false
				});
			}

			if (!t.IsOccupiedByActor || !t.getEntity().isAttackable())
			{
				continue;
			}

			local target = t.getEntity();
			this.attackEntity(user, target, false);
			target.getSkills().add(this.new("scripts/skills/effects/sb_frostblast_effect"));
		}
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [
			_targetTile
		];
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local forwardTile = _targetTile.getNextTile(dir);

			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}

			if (forwardTile.hasNextTile(dir))
			{
				forwardTile = forwardTile.getNextTile(dir);

				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
		}

		local left = dir - 1 < 0 ? 5 : dir - 1;

		if (_targetTile.hasNextTile(left))
		{
			local forwardTile = _targetTile.getNextTile(left);

			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}

			if (forwardTile.hasNextTile(dir))
			{
				forwardTile = forwardTile.getNextTile(dir);

				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
		}

		local right = dir + 1 > 5 ? 0 : dir + 1;

		if (_targetTile.hasNextTile(right))
		{
			local forwardTile = _targetTile.getNextTile(right);

			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}

			if (forwardTile.hasNextTile(dir))
			{
				forwardTile = forwardTile.getNextTile(dir);

				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
		}

		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local affectedTiles = this.getAffectedTiles(_targetTile);

		foreach( t in affectedTiles )
		{
			this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};
		for( local i = 0; i < this.Const.Tactical.SpiritWalkStartParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SpiritWalkStartParticles[i].Brushes, _user.getTile(), this.Const.Tactical.SpiritWalkStartParticles[i].Delay, this.Const.Tactical.SpiritWalkStartParticles[i].Quantity, this.Const.Tactical.SpiritWalkStartParticles[i].LifeTimeQuantity, this.Const.Tactical.SpiritWalkStartParticles[i].SpawnRate, this.Const.Tactical.SpiritWalkStartParticles[i].Stages);
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onDelayedEffect.bindenv(this), tag);
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local user = _tag.User;
		local targetTile = _tag.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local affectedTiles = this.getAffectedTiles(targetTile);
		local tag = {
			Skill = _tag.Skill,
			User = user,
			Targets = affectedTiles
		};
		this.Sound.play("sounds/enemies/vampire_landing_02.wav", 1.0, user.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, this.applyEffectToTargets.bindenv(this), tag);
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1;
			_properties.DamageDirectAdd = 0;
			_properties.DamageDirectMeleeAdd = 0;
			_properties.DamageDirectRangedAdd = 0;
			_properties.DamageDirectMult = 1;
			local actor = this.getContainer().getActor();
			_properties.DamageRegularMin = 40;
			_properties.DamageRegularMax = actor.getLevel() * 2 + 80;
			_properties.DamageArmorMult = 1.0;
			_properties.RangedSkill += 5;
			_properties.RangedAttackBlockedChanceMult *= 0;
		}
	}

});

