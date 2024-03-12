this.xxitem_mstaffaa_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function create()
	{
		this.m.ID = "actives.aoe_a";
		this.m.Name = "Lightning Strike";
		this.m.Description = "Fires multiple projectiles filled with lightning energy to attack enemies at a target location. Projectiles can be blocked by obstacles.";
		this.m.Icon = "ui/xx30.png";
		this.m.IconDisabled = "ui/xx30_sw.png";
		this.m.Overlay = "active_216";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.SoundVolume = 0.9;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 500;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsWeaponSkill = true;
		this.m.IsUsingHitchance = true;
		this.m.IsDoingForwardMove = false;
		this.m.IsTargetingActor = false;
		this.m.IsAOE = true;
		this.m.InjuriesOnBody = this.Const.Injury.BurningBody;
		this.m.InjuriesOnHead = this.Const.Injury.BurningHead;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 25;
		this.m.MinRange = 2;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.xxprojectile_04;
		this.m.ProjectileTimeScale = 1.2;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
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
			text = "Has " + (5 + this.m.AdditionalAccuracy) + "% chance to hit, and " + (-5 + this.m.AdditionalHitChance) + "% per tile of distance"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Attacks 5 times against random targets in the area. Can attack multiple times on one target"
		});
		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}
		return ret;
	}

	function isUsable()
	{
		return !this.Tactical.isActive() || !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onAfterUpdate( _properties )
	{
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			this.m.MaxRange = 6;
		}
	}

	function onUse( _user, _targetTile )
	{
		local mainh = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (this.getContainer().getActor().isPlayerControlled() && mainh.m.Condition < 3)
		{
			for( local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, this.getContainer().getActor().getTile(), this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
			}
			this.Sound.play("sounds/combat/weapon_break_01.wav", this.Const.Sound.Volume.Skill * 2.1, this.getContainer().getActor().getPos());
			this.m.Container.getActor().getSprite("arms_icon").setBrush("icon_xx_weapon_04");
			return true;
		}
		local xxtile = [];
		local ttarget;
		local effectT;
		local xxattackOK = 0;
		local xxtileE = [];
		xxtileE.push(_targetTile);
		local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;
		if (!_targetTile.IsEmpty && _targetTile.IsOccupiedByActor && _targetTile.getEntity().isAttackable())
		{
			xxtile.push(_targetTile.getEntity());
			xxattackOK = 1;
			ttarget = _targetTile.getEntity();
		}
		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				xxtileE.push(tile);
				if (!tile.IsEmpty && tile.IsOccupiedByActor && tile.getEntity().isAttackable())
				{
					xxtile.push(tile.getEntity());
					xxattackOK = 1;
				}
			}
			i = ++i;
		}
		mainh.m.IsBloodied = true;
		this.m.Container.getActor().getSprite("arms_icon").setBrush("icon_xx_weapon_04_bloodied");
		for( local i = 0; i < 9; i = ++i )
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 0 + (i * 80), function ( _skill )
			{
				effectT = xxtileE[this.Math.rand(0, xxtileE.len() - 1)];
				this.Sound.play("sounds/combat/poison_applied_0" + this.Math.rand(1, 2) + ".wav", this.Const.Sound.Volume.Skill * 0.8, this.getContainer().getActor().getPos());
				if (_user.getTile().getDistanceTo(effectT) >= this.Const.Combat.SpawnProjectileMinDist)
				{
					this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), effectT, 0.8 + (this.Math.rand(0, 5) * 0.1), this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
				}
				for( local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, effectT, this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
				}
			}.bindenv(this), this);
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, function ( _skill )
		{
			if (xxattackOK == 1)
			{
				ttarget = xxtile[this.Math.rand(0, xxtile.len() - 1)];
				if (ttarget.isAlive())
				{
					_skill.attackEntity(_user, ttarget);
				}
				ttarget = xxtile[this.Math.rand(0, xxtile.len() - 1)];
				if (ttarget.isAlive())
				{
					_skill.attackEntity(_user, ttarget);
				}
				ttarget = xxtile[this.Math.rand(0, xxtile.len() - 1)];
				if (ttarget.isAlive())
				{
					_skill.attackEntity(_user, ttarget);
				}
				ttarget = xxtile[this.Math.rand(0, xxtile.len() - 1)];
				if (ttarget.isAlive())
				{
					_skill.attackEntity(_user, ttarget);
				}
				ttarget = xxtile[this.Math.rand(0, xxtile.len() - 1)];
				if (ttarget.isAlive())
				{
					_skill.attackEntity(_user, ttarget);
				}
			}
		}.bindenv(this), this);
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 5 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -5 + this.m.AdditionalHitChance;
		}
	}

	function onTargetSelected( _targetTile )
	{
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);
		for( local i = 0; i < 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
			}
			i = ++i;
		}
	}

});

