this.sb_scream_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 5,
		Skillcool = 5
	},
	function create()
	{
		this.m.ID = "actives.sb_scream_skill";
		this.m.Name = "Banshee Scream";
		this.m.Description = "Inflicts damage and negative effects on targets in a wide area in front.";
		this.m.Icon = "ui/xx46.png";
		this.m.IconDisabled = "ui/xx46_sw.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/horrific_scream_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 35;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "10~50 Armor Ignoring Damage (60% chance)"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Negative effects applied to targets: Horrified or Swarm of Insects (50% chance)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 5 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [
			_targetTile
		];
		local ownTile = this.m.Container.getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		local left = dir - 1 < 0 ? 5 : dir - 1;
		local right = dir + 1 > 5 ? 0 : dir + 1;
		local t_targetTile;
		if (_targetTile.hasNextTile(dir))
		{
			t_targetTile = _targetTile.getNextTile(dir);
			if (this.Math.abs(t_targetTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(t_targetTile);
			}
		}
		else
		{
			return ret;
		}

		if (t_targetTile.hasNextTile(dir))
		{
			local forwardTile = t_targetTile.getNextTile(dir);
			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}

			if (forwardTile.hasNextTile(dir))
			{
				local FforwardTile = forwardTile.getNextTile(dir);
				if (this.Math.abs(FforwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(FforwardTile);
				}
			}

			left = dir - 1 < 0 ? 5 : dir - 1;
			if (forwardTile.hasNextTile(left))
			{
				local LforwardTile = forwardTile.getNextTile(left);
				if (this.Math.abs(LforwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(LforwardTile);
				}
			}

			right = dir + 1 > 5 ? 0 : dir + 1;
			if (forwardTile.hasNextTile(right))
			{
				local RforwardTile = forwardTile.getNextTile(right);
				if (this.Math.abs(RforwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(RforwardTile);
				}
			}
		}

		left = dir - 1 < 0 ? 5 : dir - 1;
		if (t_targetTile.hasNextTile(left))
		{
			local forwardTile = t_targetTile.getNextTile(left);
			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}
			if (forwardTile.hasNextTile(left))
			{
				forwardTile = forwardTile.getNextTile(left);
				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
		}
		if (_targetTile.hasNextTile(left))
		{
			local forwardTile = _targetTile.getNextTile(left);
			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}
			if (forwardTile.hasNextTile(left))
			{
				forwardTile = forwardTile.getNextTile(left);
				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
			if (forwardTile.hasNextTile(left))
			{
				forwardTile = forwardTile.getNextTile(left);
				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
		}

		right = dir + 1 > 5 ? 0 : dir + 1;
		if (t_targetTile.hasNextTile(right))
		{
			local forwardTile = t_targetTile.getNextTile(right);
			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}
			if (forwardTile.hasNextTile(right))
			{
				forwardTile = forwardTile.getNextTile(right);
				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
		}
		if (_targetTile.hasNextTile(right))
		{
			local forwardTile = _targetTile.getNextTile(right);
			if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
			{
				ret.push(forwardTile);
			}
			if (forwardTile.hasNextTile(right))
			{
				forwardTile = forwardTile.getNextTile(right);
				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
			if (forwardTile.hasNextTile(right))
			{
				forwardTile = forwardTile.getNextTile(right);
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
		this.m.Skillcool = 0;
		local user = _user;
		local targetTile = _targetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local targets = this.getAffectedTiles(targetTile);
		this.Tactical.spawnSpriteEffect("effect_skull_02", this.createColor("#ffffff"), myTile, 0, 20, 0.9, 0.9, 1, 200, 100);
		this.Tactical.spawnSpriteEffect("effect_skull_02", this.createColor("#ffffff"), myTile, 0, 20, 0.9, 0.7, 1, 400, 300);
		this.Tactical.spawnSpriteEffect("effect_skull_02", this.createColor("#ffffff"), myTile, 0, 20, 0.7, 0.9, 1, 400, 300);
		this.spawnAttackEffect(targetTile, this.Const.Tactical.AttackEffectSlash);
		this.spawnAttackEffect(targetTile, this.Const.Tactical.AttackEffectChop);
		this.spawnAttackEffect(targetTile, this.Const.Tactical.AttackEffectSplit);
		this.spawnAttackEffect(targetTile, this.Const.Tactical.AttackEffectThrust);
		this.spawnAttackEffect(targetTile, this.Const.Tactical.AttackEffectBash);
		this.spawnAttackEffect(targetTile, this.Const.Tactical.AttackEffectSwing);
		this.spawnAttackEffect(targetTile, this.Const.Tactical.AttackEffectClaws);

		foreach( t in targets )
		{
			this.spawnAttackEffect(t, this.Const.Tactical.AttackEffectSlash);
			this.spawnAttackEffect(t, this.Const.Tactical.AttackEffectChop);
			this.spawnAttackEffect(t, this.Const.Tactical.AttackEffectThrust);
			this.spawnAttackEffect(t, this.Const.Tactical.AttackEffectBash);

			if (!t.IsOccupiedByActor || !t.getEntity().isAttackable())
			{
				continue;
			}

			local target = t.getEntity();
			if ( this.Math.rand(1, 99) <= 50)
			{
				if (this.Math.rand(1, 2) == 1 && !target.getSkills().hasSkill("effects.horrified") && !target.getCurrentProperties().IsImmuneToStun)
				{
					target.getSkills().add(this.new("scripts/skills/effects/horrified_effect"));
				}
				else
				{
					local effect = target.getSkills().getSkillByID("effects.insect_swarm");
					if (effect != null)
					{
						effect.resetTime();
					}
					else
					{
						target.getSkills().add(this.new("scripts/skills/effects/insect_swarm_effect"));
					}
				}
			}
			if ( this.Math.rand(1, 99) <= 60)
			{
				this.Tactical.getShaker().shake(target, user.getTile(), 1);
				target.playSound(this.Const.Sound.ActorEvent.DamageReceived, 0.5);
			}
			else
			{
				onApplyMagicDamage(t, target, user);
			}
		}
		return true;
	}

	function onApplyMagicDamage( _tile, _entity, _user )
	{
		local damage = this.Math.rand(10, 50);
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = damage;
		hitInfo.DamageArmor = damage;
		hitInfo.DamageDirect = 1;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1;
		hitInfo.FatalityChanceMult = 0;
		if (_user.isAlive())
		{
			_entity.onDamageReceived(_user, null, hitInfo);
		}
		else
		{
			_entity.onDamageReceived(_entity, null, hitInfo);
		}
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

