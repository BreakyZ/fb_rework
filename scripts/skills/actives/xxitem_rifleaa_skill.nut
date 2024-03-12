this.xxitem_rifleaa_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function onItemSet()
	{
		this.m.MaxRange = this.m.Item.getRangeMax();
	}

	function create()
	{
		this.m.ID = "actives.xxitem_rifleaa_skill";
		this.m.Name = "Shoot";
		this.m.Description = "Shoot enemy from a distance. Must be reloaded after each shot to be able to fire again. Can not be used while engaged in melee.";
		this.m.KilledString = "Shot";
		this.m.Icon = "skills/active_203.png";
		this.m.IconDisabled = "skills/active_203_sw.png";
		this.m.Overlay = "active_203";
		this.m.SoundOnHit = [
			"sounds/combat/bash_hit_01.wav",
			"sounds/combat/bash_hit_02.wav",
			"sounds/combat/bash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 100;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 3;
		this.m.MaxRange = 7;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + this.getMaxRange() + " tiles"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + (10 + this.m.AdditionalAccuracy) + "% chance to hit, and " + (-2 + this.m.AdditionalHitChance) + "% per tile of distance"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When hitting the head: 77 Piercing damage"
		});

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] shots left"
			});
		}
		else
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty powder bag equipped[/color]"
			});
		}

		if (!this.getItem().isLoaded())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Must be reloaded before firing again[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Can not be used because this character is engaged in melee[/color]"
			});
		}
		return ret;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return actor.isAlive() && this.skill.isUsable() && this.getItem().isLoaded() && !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions());
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Powder)
		{
			return item.getAmmo();
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.MaxRange = this.m.Item.getRangeMax() + (_properties.IsSpecializedInBows ? 1 : 0) + (_properties.IsSpecializedInCrossbows ? 1 : 0) + (_properties.IsSpecializedInThrowing ? 1 : 0);
		this.m.AdditionalAccuracy = this.m.Item.getAdditionalAccuracy();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			if (_bodyPart == this.Const.BodyPart.Head)
			{
				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = 77;
				hitInfo.DamageDirect = 1.0;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;
				_targetEntity.onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}
		}
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local ret = this.attackEntity(_user, _targetTile.getEntity());
		this.getItem().setLoaded(false);
		local skillToAdd = this.new("scripts/skills/actives/xxitem_riflebb_skill");
		skillToAdd.setItem(this.getItem());
		this.getContainer().add(skillToAdd);
		this.Sound.play("sounds/combat/strike_down_hit_01.wav", this.Const.Sound.Volume.Skill * 2.2, myTile.Pos);
		this.Sound.play("sounds/combat/crush_armor_hit_03.wav", this.Const.Sound.Volume.Skill * 1.2, _targetTile.Pos);
		if (myTile.IsVisibleForPlayer)
		{
			if (_user.isAlliedWithPlayer())
			{
				for( local i = 0; i < this.Const.Tactical.HandgonneRightParticles.len(); i = ++i )
				{
					local effect = this.Const.Tactical.HandgonneRightParticles[i];
					this.Tactical.spawnParticleEffect(false, effect.Brushes, myTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
				}
			}
			else
			{
				for( local i = 0; i < this.Const.Tactical.HandgonneLeftParticles.len(); i = ++i )
				{
					local effect = this.Const.Tactical.HandgonneLeftParticles[i];
					this.Tactical.spawnParticleEffect(false, effect.Brushes, myTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
				}
			}
		}

		if (myTile.Pos.X <= _targetTile.Pos.X)
		{
			for( local i = 0; i < this.Const.Tactical.ShrapnelLeftParticles.len(); i = ++i )
			{
				local effect = this.Const.Tactical.ShrapnelLeftParticles[i];
				this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
			}
		}
		else
		{
			for( local i = 0; i < this.Const.Tactical.ShrapnelRightParticles.len(); i = ++i )
			{
				local effect = this.Const.Tactical.ShrapnelRightParticles[i];
				this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
			}
		}
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 10 + this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -2 + this.m.AdditionalHitChance;
		}
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.xxitem_riflebb_skill");
	}

});

