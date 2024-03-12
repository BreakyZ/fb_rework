this.sb_linebreaker_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 3,
		Skillcool = 3
	},
	function create()
	{
		this.m.ID = "actives.sb_linebreaker_skill";
		this.m.Name = "Line Breaker";
		this.m.Description = "Knock the target 1 tile back, dealing damage. The caster moves to the location where the target was originally. On hit, staggers the target and removes shieldwall / spearwall / riposte.";
		this.m.Icon = "ui/xx36.png";
		this.m.IconDisabled = "ui/xx36_sw.png";
		this.m.Overlay = "active_53";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_linebreaker_01.wav",
			"sounds/enemies/orc_linebreaker_02.wav",
			"sounds/enemies/orc_linebreaker_03.wav",
			"sounds/enemies/orc_linebreaker_04.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.Delay = 100;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.HitChanceBonus = 15;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "+15% Additional hit chance. (Melee hit chance)"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage: [color=" + this.Const.UI.Color.PositiveValue + "]1 ~ 150[/color] (150% armor damage)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 3 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local target = _targetTile.getEntity();
		if (this.Math.rand(1, 99) > this.getHitchance(target))
		{
			this.Tactical.getShaker().shake(_targetTile.getEntity(), _user.getTile(), 4);
			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");
			if (overwhelm != null)
			{
				overwhelm.onTargetMissed(this, target);
			}
			return false;
		}

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
		local damage = this.Math.rand(1, 150);
		local p = _user.getCurrentProperties();
		local tag = {
			Attacker = _user,
			TargetTile = _targetTile,
			Skill = this,
			HitInfo = clone this.Const.Tactical.HitInfo
		};
		tag.HitInfo.DamageRegular = damage;
		tag.HitInfo.DamageArmor = damage * 1.5;
		tag.HitInfo.DamageFatigue = 5;
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += 15;
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
		else
		if (this.m.Skillcool < this.m.Cooldown)
		{
			return false;
		}
		else if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			return false;
		}

		return true;
	}

	function onTurnStart()
	{
		this.m.Skillcool = this.m.Skillcool + 1;
	}

	function onCombatFinished()
	{
		this.m.Skillcool = this.m.Cooldown;
	}

});

