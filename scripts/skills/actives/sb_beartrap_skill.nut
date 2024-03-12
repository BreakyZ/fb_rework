this.sb_beartrap_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 3,
		Skillcool = 3
	},
	function create()
	{
		this.m.ID = "actives.sb_beartrap_skill";
		this.m.Name = "Bear Trap";
		this.m.Description = "Place a bear trap on an empty tile. The target who steps on the trap takes 50~90 armor-ignoring damage and is stunned. This damage permanently cripples enemies instead of killing them";
		this.m.Icon = "ui/xx40.png";
		this.m.IconDisabled = "ui/xx40_sw.png";
		this.m.Overlay = "active_rand";
		this.m.SoundOnUse = [
			"sounds/combat/repel_hit_01.wav",
			"sounds/combat/repel_hit_02.wav",
			"sounds/combat/repel_hit_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hook_hit_01.wav",
			"sounds/combat/hook_hit_02.wav",
			"sounds/combat/hook_hit_03.wav"
		];
		this.m.SoundVolume = 1.1;
		this.m.SoundOnHitDelay = 0;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.Delay = 0;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = true;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Bomb1;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
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
			icon = "ui/icons/special.png",
			text = "Cooldown : 3 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return _targetTile.IsEmpty;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local p = {
			Type = "Beartrap",
			Tooltip = "Bear Trap is here, grants damage and stun effect.",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _user.isPlayerControlled(),
			Timeout = this.Time.getRound() + 999,
			Callback = onApplyMagicFire,
			function Applicable( _a )
			{
				return true;
			}

		};
		local t = _targetTile;
		if (t.Properties.Effect != null)
		{
			this.Tactical.Entities.removeTileEffect(t);
		}
		t.Properties.Effect = clone p;
		local particles = [];
		for( local i = 0; i < this.Const.Tactical.BeartrapParticles.len(); i = ++i )
		{
			particles.push(this.Tactical.spawnParticleEffect(true, this.Const.Tactical.BeartrapParticles[i].Brushes, t, this.Const.Tactical.BeartrapParticles[i].Delay, this.Const.Tactical.BeartrapParticles[i].Quantity, this.Const.Tactical.BeartrapParticles[i].LifeTimeQuantity, this.Const.Tactical.BeartrapParticles[i].SpawnRate, this.Const.Tactical.BeartrapParticles[i].Stages));
		}
		this.Tactical.Entities.addTileEffect(t, t.Properties.Effect, particles);
		t.clear(this.Const.Tactical.DetailFlag.Scorchmark);
		t.spawnDetail("xxtrap_01", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
		if (t.IsCorpseSpawned)
		{
			this.Tactical.Entities.removeCorpse(t);
			t.clear(this.Const.Tactical.DetailFlag.Corpse);
			t.Properties.remove("Corpse");
			t.Properties.remove("IsSpawningFlies");
		}
		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, t.Pos);
	}

	function onApplyMagicFire( _tile, _entity )
	{
		this.Tactical.spawnIconEffect("status_effect_119", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
		local sounds = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		];
		this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Skill * 1.9, _entity.getPos());
		if (_tile.Properties.Effect != null)
		{
			this.Tactical.Entities.removeTileEffect(_tile);
			_tile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
			_tile.spawnDetail("corpse_part_03", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
		}
		if (_entity.getCurrentProperties().DamageReceivedTotalMult > 0)
		{
			local dmg = this.Math.rand(50, 90);
			local hitInfo = clone this.Const.Tactical.HitInfo;
			if (_entity.getHitpoints() <= dmg)
			{
				_entity.getSkills().add(this.new("scripts/skills/effects/ai_stun_effect"));
				_entity.getSkills().add(this.new("scripts/skills/effects/ai_mortalwound_effect"));
			}
			else 
			if (!_entity.getSkills().hasSkill("effects.stunned") && !_entity.getCurrentProperties().IsImmuneToStun)
			{
				_entity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
			}
			hitInfo.DamageRegular = 0.00001;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_entity.onDamageReceived(_entity, null, hitInfo);
			_entity.setHitpoints(this.Math.max(_entity.getHitpoints() - dmg, 1));
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

