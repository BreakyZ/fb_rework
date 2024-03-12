this.sb_multishot_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function create()
	{
		this.m.ID = "actives.sb_multishot_skill";
		this.m.Name = "Multi Shot";
		this.m.Description = "Shoot arrows at multiple targets. Can not be used while engaged in melee. \n[color=#8f1e1e]Requires:[/color] Bow";
		this.m.KilledString = "Shot";
		this.m.Icon = "ui/xx11.png";
		this.m.IconDisabled = "ui/xx11_sw.png";
		this.m.Overlay = "active_rand";
		this.m.SoundOnUse = [
			"sounds/combat/quick_shot_01.wav",
			"sounds/combat/quick_shot_02.wav",
			"sounds/combat/quick_shot_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/arrow_hit_01.wav",
			"sounds/combat/arrow_hit_02.wav",
			"sounds/combat/arrow_hit_03.wav"
		];
		this.m.SoundOnHitShield = [
			"sounds/combat/shield_hit_arrow_01.wav",
			"sounds/combat/shield_hit_arrow_02.wav",
			"sounds/combat/shield_hit_arrow_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/arrow_miss_01.wav",
			"sounds/combat/arrow_miss_02.wav",
			"sounds/combat/arrow_miss_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.Delay = 1000;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsWeaponSkill = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = false;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 2;
		this.m.MaxRange = 5;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.ProjectileType = this.Const.ProjectileType.Arrow;
		this.m.ProjectileTimeScale = 1.2;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + (this.m.AdditionalAccuracy) + "% chance to hit, and " + (-4 + this.m.AdditionalHitChance) + "% per tile of distance"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]-30%[/color] Damage, Up to 3 multi-targets"
		});
		local ammo = this.getAmmo();
		if (ammo > 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] arrows left"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Needs a non-empty quiver of arrows equipped[/color]"
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
		local ret = false;
		local myTile = _user.getTile();
		local myTile = this.m.Container.getActor().getTile();
		local d = myTile.getDistanceTo(_targetTile);
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		this.Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
		local tiles = [];

		for( local i = 0; i != result.Tiles.len(); i = ++i )
		{
			if (result.Tiles[i].ID == _targetTile.ID)
			{
				tiles.push(result.Tiles[i]);
				local idx = i - 1;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				idx = i - 2;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				break;
			}
		}

		foreach( t in tiles )
		{
			if (!t.IsVisibleForEntity)
			{
				continue;
			}

			if (this.Math.abs(t.Level - myTile.Level) > this.m.MaxLevelDifference || this.Math.abs(t.Level - _targetTile.Level) > this.m.MaxLevelDifference)
			{
				continue;
			}

			if (!t.IsEmpty && t.getEntity().isAttackable())
			{
				ret = this.attackEntity(_user, t.getEntity()) || ret;
			}

			if (!_user.isAlive() || _user.isDying())
			{
				break;
			}
		}

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
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += -4 + this.m.AdditionalHitChance;
			_properties.DamageRegularMult *= 0.7;
		}
	}

	function onQueryTilesHit( _tile, _result )
	{
		_result.Tiles.push(_tile);
	}

	function onTargetSelected( _targetTile )
	{
		local myTile = this.m.Container.getActor().getTile();
		local d = myTile.getDistanceTo(_targetTile);
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		this.Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
		local tiles = [];

		for( local i = 0; i != result.Tiles.len(); i = ++i )
		{
			if (result.Tiles[i].ID == _targetTile.ID)
			{
				tiles.push(result.Tiles[i]);
				local idx = i - 1;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				idx = i - 2;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				break;
			}
		}

		foreach( t in tiles )
		{
			if (!t.IsVisibleForEntity)
			{
				continue;
			}

			if (this.Math.abs(t.Level - myTile.Level) > this.m.MaxLevelDifference || this.Math.abs(t.Level - _targetTile.Level) > this.m.MaxLevelDifference)
			{
				continue;
			}

			this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Ammo);

		if (item == null)
		{
			return 0;
		}

		if (item.getAmmoType() == this.Const.Items.AmmoType.Arrows)
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
			local actorsk = this.getContainer();
			if (!actorsk.hasSkill("actives.quick_shot") && !actorsk.hasSkill("actives.aimed_shot"))
			{
				return true;
			}
			return false;
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
		if (!actor.isAlive())
		{
			return false;
		}
		else if (actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()))
		{
			return false;
		}
		else if (this.getContainer().hasSkill("actives.quick_shot"))
		{
			return true;
		}
		else if (this.getContainer().hasSkill("actives.aimed_shot"))
		{
			return true;
		}

		return false;
	}

});

