this.sb_penshot_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function create()
	{
		this.m.ID = "actives.sb_penshot_skill";
		this.m.Name = "Penetrating Shot";
		this.m.Description = "Penetrates the target with a powerful shot. Attacks up to 2 additional targets in a line behind the target. \n[color=#8f1e1e]Requires:[/color] Crossbow";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_85.png";
		this.m.IconDisabled = "ui/active_85_sw.png";
		this.m.Overlay = "active_85";
		this.m.SoundOnUse = [
			"sounds/combat/bolt_shot_01.wav",
			"sounds/combat/bolt_shot_02.wav",
			"sounds/combat/bolt_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bolt_shot_hit_01.wav",
			"sounds/combat/bolt_shot_hit_02.wav",
			"sounds/combat/bolt_shot_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/shield_hit_arrow_01.wav",
			"sounds/combat/shield_hit_arrow_02.wav",
			"sounds/combat/shield_hit_arrow_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/bolt_shot_miss_01.wav",
			"sounds/combat/bolt_shot_miss_02.wav",
			"sounds/combat/bolt_shot_miss_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.Delay = 1000;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsAOE = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 20;
		this.m.MinRange = 2;
		this.m.MaxRange = 5;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Arrow;
		this.m.ProjectileTimeScale = 0.8;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + (5 + this.m.AdditionalAccuracy) + "% chance to hit, and " + (-3 + this.m.AdditionalHitChance) + "% per tile of distance"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]-20%[/color] Damage, Up to 3 multi-targets"
		});
		local ammo = this.getAmmo();
		if (ammo > 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] bolts left"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of bolts equipped[/color]"
			});
		}
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

	function onUse( _user, _targetTile )
	{
		this.consumeAmmo();
		local myTile = _user.getTile();
		local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 0, function ( _skill )
		{
			if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.1, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}.bindenv(this), this);

		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, this.onDelayedEffect.bindenv(this), tag);
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local mainh = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (mainh != null)
			{
				this.m.DirectDamageMult = mainh.m.DirectDamageMult;
			}
			_properties.RangedSkill += 5 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile -= 3 + this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 0.8;
		}
	}

	function onDelayedEffect( _tag )
	{
		local user = _tag.User;
		local targetTile = _tag.TargetTile;
		local myTile = user.getTile();
		local dir = myTile.getDirectionTo(targetTile);
		local targets = this.getAffectedTiles(targetTile);
		_tag.Skill.spawnAttackEffect(_tag.TargetTile, this.Const.Tactical.AttackEffectSplit);
		if (targetTile.hasNextTile(dir))
		{
			local forwardTile = targetTile.getNextTile(dir);
			if (this.Math.abs(forwardTile.Level - myTile.Level) <= this.m.MaxLevelDifference)
			{
				_tag.Skill.spawnAttackEffect(forwardTile, this.Const.Tactical.AttackEffectSplit);
			}
			if (forwardTile.hasNextTile(dir))
			{
				forwardTile = forwardTile.getNextTile(dir);
				if (this.Math.abs(forwardTile.Level - myTile.Level) <= this.m.MaxLevelDifference)
				{
					_tag.Skill.spawnAttackEffect(forwardTile, this.Const.Tactical.AttackEffectSplit);
				}
			}
		}
		foreach( t in targets )
		{
			if (!t.IsOccupiedByActor || !t.getEntity().isAttackable())
			{
				continue;
			}
			local target = t.getEntity();
			local success = this.attackEntity(user, target, false);
		}
		return true;
	}

	function onTargetSelected( _targetTile )
	{
		local affectedTiles = this.getAffectedTiles(_targetTile);

		foreach( t in affectedTiles )
		{
			this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
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

		return ret;
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Bolts)
		{
			return item.getAmmo();
		}
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function isHidden()
	{
		if (this.m.Container.getActor().isPlacedOnMap())
		{
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (mainh != null)
			{
				if (mainh.getID() == "weapon.goblin_crossbow" || mainh.getID() == "weapon.light_crossbow" || mainh.getID() == "weapon.crossbow" || mainh.getID() == "weapon.heavy_crossbow" || mainh.getID() == "weapon.named_crossbow")
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}

		if (this.getAmmo() <= 0)
		{
			return false;
		}

		local actor = this.getContainer().getActor();
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (!actor.isAlive())
		{
			return false;
		}
		else if (actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()))
		{
			return false;
		}
		else if (item != null)
		{
			if (item.getID() == "weapon.goblin_crossbow" || item.getID() == "weapon.light_crossbow" || item.getID() == "weapon.crossbow" || item.getID() == "weapon.heavy_crossbow" || item.getID() == "weapon.named_crossbow")
			{
				return true;
			}
		}

		return false;
	}

});

