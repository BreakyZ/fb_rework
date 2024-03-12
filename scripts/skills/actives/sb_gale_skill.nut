this.sb_gale_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_gale_skill";
		this.m.Name = "Gale Force";
		this.m.Description = "A strong wind knocks the target back 1 to 3 tiles and deals damage. On hit, staggers the target and removes shieldwall / spearwall / riposte.";
		this.m.Icon = "ui/xx56.png";
		this.m.IconDisabled = "ui/xx56_sw.png";
		this.m.Overlay = "active_rand";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + this.getMaxRange() + " tiles"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "+20% Additional hit chance, Ignores obstacles and only attacks selected target. (Ranged hit chance)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage: 100% current ranged defense + 20 (max damage: 200, 150% armor damage)"
		});
		return ret;
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);
		local left = dir - 1 < 0 ? 5 : dir - 1;
		local right = dir + 1 > 5 ? 0 : dir + 1;
		local ret = [];
		local tlvl = this.m.MaxLevelDifference;
		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);
			local nextToTile;
			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= tlvl)
			{
				ret.push(knockToTile);
			}
			if (knockToTile.hasNextTile(left))
			{
				nextToTile = knockToTile.getNextTile(left);
				if (nextToTile.IsEmpty && nextToTile.Level - _targetTile.Level <= tlvl)
				{
					ret.push(nextToTile);
					ret.push(nextToTile);
				}
			}
			if (knockToTile.hasNextTile(right))
			{
				nextToTile = knockToTile.getNextTile(right);
				if (nextToTile.IsEmpty && nextToTile.Level - _targetTile.Level <= tlvl)
				{
					ret.push(nextToTile);
					ret.push(nextToTile);
				}
			}

			knockToTile = knockToTile.getNextTile(dir);
			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= tlvl)
			{
				ret.push(knockToTile);
				ret.push(knockToTile);
				ret.push(knockToTile);
			}
			if (knockToTile.hasNextTile(left))
			{
				nextToTile = knockToTile.getNextTile(left);
				if (nextToTile.IsEmpty && nextToTile.Level - _targetTile.Level <= tlvl)
				{
					ret.push(nextToTile);
					ret.push(nextToTile);
				}
			}
			if (knockToTile.hasNextTile(right))
			{
				nextToTile = knockToTile.getNextTile(right);
				if (nextToTile.IsEmpty && nextToTile.Level - _targetTile.Level <= tlvl)
				{
					ret.push(nextToTile);
					ret.push(nextToTile);
				}
			}

			knockToTile = knockToTile.getNextTile(dir);
			if (knockToTile.IsEmpty && knockToTile.Level - _targetTile.Level <= tlvl)
			{
				ret.push(knockToTile);
				ret.push(knockToTile);
				ret.push(knockToTile);
			}
		}

		if (ret.len() > 0)
		{
			local effectT = ret[this.Math.rand(0, ret.len() - 1)];
			return effectT;
		}

		return null;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);
		local flip = !this.m.IsProjectileRotated && target.getPos().X > _user.getPos().X;
		local xfire = this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.1, 2, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.9, 1, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.9, 1, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.9, 2, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.9, 2, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.8, 3, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.8, 3, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.8, 4, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.8, 4, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.7, 5, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.7, 6, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.6, 7, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.5, 8, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.4, 9, true, flip);
		this.Tactical.spawnProjectileEffect("effect_thresh", _user.getTile(), _targetTile, 0.3, 10, true, flip);
		this.Sound.play("sounds/enemies/vampire_takeoff_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Skill * 1.5, _user.getPos());

		this.m.SoundOnHit = [
			"sounds/enemies/vampire_landing_01.wav",
			"sounds/enemies/vampire_landing_02.wav",
			"sounds/enemies/vampire_landing_03.wav"
		];
		if (!this.attackEntity(_user, target, false))
		{
			return false;
		}
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " moved " + this.Const.UI.getColorizedEntityName(target));
		}

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}
		target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		local p = _user.getCurrentProperties();
		local damage = this.Math.min(p.RangedDefense + 20, 200);
		local tag = {
			Attacker = _user,
			Skill = this,
			HitInfo = clone this.Const.Tactical.HitInfo
		};
		tag.HitInfo.DamageRegular = damage;
		tag.HitInfo.DamageArmor = damage * 1.5;
		tag.HitInfo.DamageFatigue = 5;
		tag.HitInfo.DamageDirect = 0.4;
		tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
		tag.HitInfo.BodyDamageMult = 1.0;
		tag.HitInfo.FatalityChanceMult = 0.0;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, xfire, function ( _skill )
		{
			if (target.isAlive() && !target.isDying())
			{
				if (knockToTile == null)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, target.getPos());
					target.onDamageReceived(_user, this, tag.HitInfo);
				}
				else
				{
					target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
					this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true, 1.5);
				}
			}
		}.bindenv(this), this);
		return true;
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
		}

		if (_tag.HitInfo.DamageRegular != 0)
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
		}
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
			_properties.DamageRegularMin = 0;
			_properties.DamageRegularMax = 0;
			_properties.RangedSkill += 20;
			_properties.RangedAttackBlockedChanceMult *= 0;
		}
	}

});

