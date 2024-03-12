this.xxitem_heavylancebb_skill <- this.inherit("scripts/skills/skill", {
	m = {
		SoundOnCharge = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		],
		TilesUsed = []
	},
	function create()
	{
		this.m.ID = "actives.xxitem_heavylancebb_skill";
		this.m.Name = "Lance Charge";
		this.m.Description = "Charges to a target location, dealing damage to 1 nearby enemy.";
		this.m.Icon = "skills/active_07.png";
		this.m.IconDisabled = "skills/active_07_sw.png";
		this.m.Overlay = "active_07";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_takeoff_01.wav",
			"sounds/enemies/vampire_takeoff_02.wav",
			"sounds/enemies/vampire_takeoff_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/split_hit_01.wav",
			"sounds/combat/split_hit_02.wav",
			"sounds/combat/split_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.IsUsingActorPitch = true;
		this.m.IsSpearwallRelevant = false;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 2;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 77;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+70[/color] Damage"
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
		local actor = this.getContainer().getActor();
		return actor.isAlive() && this.skill.isUsable() && !actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions()) && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function isHidden()
	{
		if (this.getContainer().getActor().getSkills().hasSkill("effects.sb_wolfride_effect"))
		{
			return false;
		}
		if (this.getContainer().getActor().getSkills().hasSkill("effects.xxitem_horse_skill"))
		{
			return false;
		}
		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		if (this.Math.abs(_targetTile.Level - _originTile.Level) > 2)
		{
			return false;
		}

		local myPos = _originTile.Pos;
		local targetPos = _targetTile.Pos;
		local distance = _originTile.getDistanceTo(_targetTile);
		local Dx = (targetPos.X - myPos.X) / distance;
		local Dy = (targetPos.Y - myPos.Y) / distance;

		for( local i = 0; i < distance; i = ++i )
		{
			local x = myPos.X + Dx * i;
			local y = myPos.Y + Dy * i;
			local tileCoords = this.Tactical.worldToTile(this.createVec(x, y));
			local tile = this.Tactical.getTile(tileCoords);
			if (!tile.IsOccupiedByActor && !tile.IsEmpty)
			{
				return false;
			}
			if (this.Math.abs(tile.Level - _originTile.Level) > 2)
			{
				return false;
			}
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.TilesUsed = [];
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile
		};
		if (this.m.SoundOnCharge.len() != 0)
		{
			this.Sound.play(this.m.SoundOnCharge[this.Math.rand(0, this.m.SoundOnCharge.len() - 1)], this.Const.Sound.Volume.Skill * 0.8, this.getContainer().getActor().getPos());
		}
		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer)
		{
			local myPos = _user.getPos();
			local targetPos = _targetTile.Pos;
			local distance = tag.OldTile.getDistanceTo(_targetTile);
			local Dx = (targetPos.X - myPos.X) / distance;
			local Dy = (targetPos.Y - myPos.Y) / distance;

			for( local i = 0; i < distance; i = ++i )
			{
				local x = myPos.X + Dx * i;
				local y = myPos.Y + Dy * i;
				local tile = this.Tactical.worldToTile(this.createVec(x, y));

				if (this.Tactical.isValidTile(tile.X, tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
				{
					for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, this.Tactical.getTile(tile), this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
					}
				}
			}
		}
		this.Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);
		return true;
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local betterThanNothing;
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);
		local ZOC = [];
		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);
				if (!tile.IsOccupiedByActor)
				{
				}
				else
				{
					local actor = tile.getEntity();
					if (actor.isAlliedWith(_entity))
					{
					}
					else
					{
						ZOC.push(actor);
						if (betterThanNothing == null)
						{
							betterThanNothing = actor;
						}
						potentialVictims.push(actor);
					}
				}
			}
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true))
			{
				continue;
			}
			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " charges and is repelled");
				}
				if (!_entity.isAlive() || _entity.isDying())
				{
					return;
				}
				local dir = myTile.getDirectionTo(_tag.OldTile);
				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);

					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}
				for( local i = 0; i != 6; i = ++i )
				{
					if (!myTile.hasNextTile(i))
					{
					}
					else
					{
						local tile = myTile.getNextTile(i);

						if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1)
						{
							if (tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) != 0)
							{
							}
							else
							{
								_tag.TargetTile = tile;
								this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
								return;
							}
						}
					}
				}
				_tag.TargetTile = _tag.OldTile;
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
				return;
			}
		}

		if (potentialVictims.len() == 0 && betterThanNothing != null)
		{
			potentialVictims.push(betterThanNothing);
		}

		local victim = potentialVictims[this.Math.rand(0, potentialVictims.len() - 1)];
		if (_tag.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, victim.getPos());
		}
		this.spawnAttackEffect(victim.getTile(), this.Const.Tactical.AttackEffectSplit);
		this.attackEntity(_entity, victim);
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 70;
			_properties.DamageRegularMax += 70;
		}
	}

	function addResources()
	{
		foreach( r in this.m.SoundOnCharge )
		{
			this.Tactical.addResource(r);
		}
	}

});

