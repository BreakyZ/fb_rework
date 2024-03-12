this.ai_linebreaker <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.line_breaker";
		this.m.Name = "Power Charge";
		this.m.Description = "";
		this.m.Overlay = "active_111";
		this.m.SoundOnUse = [
			"sounds/combat/knockback_01.wav",
			"sounds/combat/knockback_02.wav",
			"sounds/combat/knockback_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/knockback_hit_01.wav",
			"sounds/combat/knockback_hit_02.wav",
			"sounds/combat/knockback_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 1;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function onUse( _user, _targetTile )
	{
		this.getContainer().setBusy(true);
		local target = _targetTile.getEntity();
		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);

		if (knockToTile == null)
		{
			return false;
		}

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

		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
		}

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");
		if (overwhelm != null)
		{
			overwhelm.onTargetHit(this, target, this.Const.BodyPart.Body, 0, 0);
		}
		local damage = this.Math.rand(30, 50);
		local p = _user.getCurrentProperties();
		local tag = {
			Attacker = _user,
			TargetTile = _targetTile,
			Skill = this,
			HitInfo = clone this.Const.Tactical.HitInfo
		};
		tag.HitInfo.DamageRegular = damage;
		tag.HitInfo.DamageArmor = damage * 1.5;
		tag.HitInfo.DamageFatigue = 20;
		tag.HitInfo.DamageDirect = 0.5;
		tag.HitInfo.BodyPart = this.Const.BodyPart.Body;
		tag.HitInfo.BodyDamageMult = 1.0;
		tag.HitInfo.FatalityChanceMult = 0.0;
		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true, 1.2);
		return true;
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.Attacker.isAlive() && !_tag.Attacker.isDying() && _entity.isAlive() && !_entity.isDying() && _entity.isAttackable())
		{
			_entity.onDamageReceived(_tag.Attacker, _tag.Skill, _tag.HitInfo);
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
		}
		if (_tag.Attacker.isAlive() && _tag.TargetTile.IsEmpty)
		{
			_tag.Attacker.setCurrentMovementType(this.Const.Tactical.MovementType.Default);
			this.Tactical.getNavigator().teleport(_tag.Attacker, _tag.TargetTile, null, null, false, 3);
		}
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);

		if (_targetTile.hasNextTile(dir))
		{
			local knockToTile = _targetTile.getNextTile(dir);

			if (knockToTile.IsEmpty && this.Math.abs(knockToTile.Level - _userTile.Level) <= 1)
			{
				return knockToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && this.Math.abs(knockToTile.Level - _userTile.Level) <= 1)
			{
				return knockToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_targetTile.hasNextTile(altdir))
		{
			local knockToTile = _targetTile.getNextTile(altdir);

			if (knockToTile.IsEmpty && this.Math.abs(knockToTile.Level - _userTile.Level) <= 1)
			{
				return knockToTile;
			}
		}

		return null;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsRooted && !_targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab && this.findTileToKnockBackTo(_originTile, _targetTile) != null;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			return false;
		}
		return true;
	}

});

