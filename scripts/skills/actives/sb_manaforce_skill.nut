this.sb_manaforce_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 3,
		Skillcool = 3
	},
	function create()
	{
		this.m.ID = "actives.sb_manaforce_skill";
		this.m.Name = "Thunderstorm";
		this.m.Description = "Inflicts ranged damage to random enemies within 2 tiles around you for 10 times. The caster cannot act for 2 turns.";
		this.m.Icon = "ui/xx41.png";
		this.m.IconDisabled = "ui/xx41_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.SoundVolume = 1.2;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsWeaponSkill = false;
		this.m.IsUsingHitchance = true;
		this.m.IsAOE = true;
		this.m.InjuriesOnBody = this.Const.Injury.BurningBody;
		this.m.InjuriesOnHead = this.Const.Injury.BurningHead;
		this.m.DirectDamageMult = 0.999;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 35;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "+5% Hit chance, Ranged attack type, Ignores obstacles"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "+0.3 Max damage per level"
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
		local myTile = _user.getTile();
		local xxtile = [];
		local ttarget;
		local effectT;
		local xxattackOK = 0;
		local xxtileE = [];
		local size = this.Tactical.getMapSize();
		for( local x = 0; x < size.X; x = ++x )
		{
			for( local y = 0; y < size.Y; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);
				if (myTile.getDistanceTo(tile) <= 2 && tile != myTile)
				{
					xxtileE.push(tile);
					if (!tile.IsEmpty && tile.IsOccupiedByActor && tile.getEntity().isAttackable() && !tile.getEntity().isAlliedWith(_user))
					{
						xxtile.push(tile.getEntity());
						xxattackOK = 1;
					}
				}
			}
		}
		_user.getSkills().setBusy(true);
		if (this.Const.DLC.Unhold && this.Const.DLC.Wildmen && this.Const.DLC.Desert)
		{
			this.Sound.play("sounds/enemies/dlc6/cast_lightning_0" + this.Math.rand(1, 4) + ".wav", 1.5, myTile.Pos);
			this.Sound.play("sounds/enemies/dlc6/lightning_impact_0" + this.Math.rand(1, 4) + ".wav", 1.5, myTile.Pos);
			this.Sound.play("sounds/combat/dlc2/legendary_lightning_0" + this.Math.rand(1, 2) + ".wav", 1.5, myTile.Pos);
		}
		if (_user.hasSprite("xlightning_eye"))
		{
			_user.getSprite("xlightning_eye").Visible = false;
			_user.removeSprite("xlightning_eye");
		}
		_user.addSprite("xlightning_eye");
		_user.getSprite("xlightning_eye").setBrush("zombie_rage_eyes");
		_user.getSprite("xlightning_eye").Visible = true;
		_user.getSprite("xlightning_eye").Color = this.createColor("#008cff");
		if (_user.hasSprite("arms_icon"))
		{
			_user.removeSprite("arms_icon");
			_user.addSprite("arms_icon")
			_user.getItems().updateAppearance();
		}
		local stun = this.new("scripts/skills/effects/ai_stun_effect");
		_user.getSkills().add(stun);
		stun.setTurns(2);
		for( local i = 0; i < 20; i = ++i )
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 0 + (i * 100), function ( _skill )
			{
				effectT = xxtileE[this.Math.rand(0, xxtileE.len() - 1)];
				for( local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, effectT, this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
				}
				if (this.Math.rand(1, 100) <= 50)
				{
					effectT.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					effectT.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}.bindenv(this), this);
		}
		if (xxattackOK == 1)
		{
			for( local i = 0; i < 10; i = ++i )
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 0 + (i * 200), function ( _skill )
				{
					ttarget = xxtile[this.Math.rand(0, xxtile.len() - 1)];
					if (ttarget.isAlive())
					{
						this.Sound.play("sounds/combat/poison_applied_0" + this.Math.rand(1, 2) + ".wav", 0.5, ttarget.getPos());
						for( local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = ++i )
						{
							this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, ttarget.getTile(), this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
						}
						_skill.attackEntity(_user, ttarget, false);
					}
				}.bindenv(this), this);
			}
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 2000, function ( _skill )
		{
			_user.getSkills().setBusy(false);
			if (_user.hasSprite("xlightning_eye"))
			{
				_user.getSprite("xlightning_eye").Visible = false;
				_user.removeSprite("xlightning_eye");
			}
		}.bindenv(this), this);
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
			_properties.DamageRegularMin = 1;
			_properties.DamageRegularMax = actor.getLevel() * 0.3 + 20;
			_properties.DamageArmorMult = 2.0;
			_properties.RangedSkill += 5;
			_properties.RangedAttackBlockedChanceMult *= 0;
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

