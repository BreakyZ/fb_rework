this.sb_waterbomb_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 7,
		Skillcool = 7
	},
	function create()
	{
		this.m.ID = "actives.sb_waterbomb_skill";
		this.m.Name = "Flood Bomb";
		this.m.Description = "Fills the 7 tiles containing the spot with a large amount of water, dealing damage and turning the terrain into a swamp. \n[color=#8f1e1e]Requires:[/color] 299 Crowns";
		this.m.Icon = "ui/xx74.png";
		this.m.IconDisabled = "ui/xx74_sw.png";
		this.m.Overlay = "active_97";
		this.m.SoundOnUse = [
			"sounds/combat/throw_ball_01.wav",
			"sounds/combat/throw_ball_02.wav",
			"sounds/combat/throw_ball_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/acid_flask_impact_01.wav",
			"sounds/combat/acid_flask_impact_02.wav",
			"sounds/combat/acid_flask_impact_03.wav",
			"sounds/combat/acid_flask_impact_04.wav"
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
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
		this.m.MaxLevelDifference = 3;
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
			text = "10~30 Armor ignoring damage. (This damage permanently cripples enemies instead of killing them)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown : 7 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		if (this.Tactical.isActive())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Own [color=#e6b71e]" + this.World.Assets.getMoney() + "[/color] crowns"
			});
		}
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_originTile.Level + 1 < _targetTile.Level)
		{
			return false;
		}

		return true;
	}

	function onTargetSelected( _targetTile )
	{
		local tiles = this.getAffectedTiles(_targetTile);
		this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, _targetTile, _targetTile.Pos.X, _targetTile.Pos.Y);

		if (tiles.len() != 0)
		{
			foreach( t in tiles )
			{
				this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
			}
		}
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [
			_targetTile
		];
		local ownTile = this.m.Container.getActor().getTile();
		for( local i = 0; i != 6; i = ++i )
		{
			if (_targetTile.hasNextTile(i))
			{
				local forwardTile = _targetTile.getNextTile(i);
				if (this.Math.abs(forwardTile.Level - ownTile.Level) <= this.m.MaxLevelDifference)
				{
					ret.push(forwardTile);
				}
			}
		}
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		this.World.Assets.addMoney(-299);
		local time = 250;
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;
			if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				time = this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}
		local tiles = this.getAffectedTiles(_targetTile);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, time, function ( _skill )
		{
			foreach( t in tiles )
			{
				t.clear();
				t.Type = 0;
				this.MapGen.get("tactical.tile.swampx1").onFirstPass({
					X = t.SquareCoords.X,
					Y = t.SquareCoords.Y,
					W = 1,
					H = 1,
					IsEmpty = true,
					SpawnObjects = false
				});
				if (this.Math.rand(1, 100) <= 20)
				{
					local tiletype = [
						"swamp_grass_10_reflect",
						"desert_grass_03_water",
						"desert_grass_04_water",
						"desert_grass_05_water",
						"autumn_moss_01",
						"autumn_moss_02",
						"autumn_moss_03",
						"swamp_moss_01"
					];
					t.clear(this.Const.Tactical.DetailFlag.Scorchmark);
					t.spawnDetail(tiletype[this.Math.rand(0, tiletype.len() - 1)], this.Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
				if (t.IsOccupiedByActor && t.getEntity().getHitpointsMax() > 1)
				{
					local target = t.getEntity();
					t.getEntity().sinkIntoGround(0.3);
					for( local i = 0; i < this.Const.Tactical.AcidParticles.len(); i = ++i )
					{
						this.Tactical.spawnParticleEffect(true, this.Const.Tactical.AcidParticles[i].Brushes, t, this.Const.Tactical.AcidParticles[i].Delay, this.Const.Tactical.AcidParticles[i].Quantity, this.Const.Tactical.AcidParticles[i].LifeTimeQuantity, this.Const.Tactical.AcidParticles[i].SpawnRate, this.Const.Tactical.AcidParticles[i].Stages);
					}
					this.Tactical.spawnIconEffect("status_effect_50", t, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
					this.Sound.play("sounds/vomit_01.wav", this.Const.Sound.Volume.Skill * 1.0, target.getPos());
					this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
					{
						target.riseFromGround(0.7);
						if (target.getCurrentProperties().DamageReceivedTotalMult > 0)
						{	
							local dmg = this.Math.rand(10, 15);
							local hitInfo = clone this.Const.Tactical.HitInfo;
							if (target.getHitpoints() <= dmg)
							{
								target.getSkills().add(this.new("scripts/skills/effects/ai_stun_effect"));
								target.getSkills().add(this.new("scripts/skills/effects/ai_mortalwound_effect"));
							}
							hitInfo.DamageRegular = 0.00001;
							hitInfo.DamageDirect = 1.0;
							hitInfo.BodyPart = this.Const.BodyPart.Body;
							hitInfo.BodyDamageMult = 1.0;
							hitInfo.FatalityChanceMult = 0.0;
							target.onDamageReceived(target, null, hitInfo);
							target.setHitpoints(this.Math.max(target.getHitpoints() - dmg, 1));
						}
					}.bindenv(this), this);
				}
			}
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, _targetTile.Pos);
		}.bindenv(this), this);
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		if (this.World.Assets.getMoney() < 299)
		{
			return false;
		}
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

