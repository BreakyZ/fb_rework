this.sb_blackbomb_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 10,
		Skillcool = 10
	},
	function create()
	{
		this.m.ID = "actives.sb_blackbomb_skill";
		this.m.Name = "Black Magic Grenade";
		this.m.Description = "Throws a magic grenade that has a random negative effect on the target area. \n[color=#8f1e1e]Requires:[/color] 299 Crowns";
		this.m.Icon = "ui/xx15.png";
		this.m.IconDisabled = "ui/xx15_sw.png";
		this.m.SoundOnUse = [
			"sounds/status/insect_swarm_effect_01.wav",
			"sounds/status/insect_swarm_effect_02.wav",
			"sounds/status/insect_swarm_effect_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/acid_flask_impact_01.wav",
			"sounds/combat/acid_flask_impact_02.wav",
			"sounds/combat/acid_flask_impact_03.wav",
			"sounds/combat/acid_flask_impact_04.wav"
		];
		this.m.SoundVolume = 1.9;
		this.m.SoundOnHitDelay = 300;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
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
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
		this.m.ProjectileType = this.Const.ProjectileType.Bomb2;
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
			text = "AOE Random Debuff"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown : 10 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
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

	function onTargetSelected( _targetTile )
	{
		local affectedTiles = [];
		affectedTiles.push(_targetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);
				affectedTiles.push(tile);
			}
		}

		foreach( t in affectedTiles )
		{
			this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, t, t.Pos.X, t.Pos.Y);
		}
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

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		this.World.Assets.addMoney(-299);
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;
			if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}
		this.Time.scheduleEvent(this.TimeUnit.Real, 250, this.onApply.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	function onApply( _data )
	{
		local targets = [];
		targets.push(_data.TargetTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!_data.TargetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _data.TargetTile.getNextTile(i);
				targets.push(tile);
			}
		}

		if (_data.Skill.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(_data.Skill.m.SoundOnHit[this.Math.rand(0, _data.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 2.0, _data.TargetTile.Pos);
		}

		foreach( tile in targets )
		{
			for( local i = 0; i < this.Const.Tactical.DarkflightStartParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DarkflightStartParticles[i].Brushes, tile, this.Const.Tactical.DarkflightStartParticles[i].Delay, this.Const.Tactical.DarkflightStartParticles[i].Quantity, this.Const.Tactical.DarkflightStartParticles[i].LifeTimeQuantity, this.Const.Tactical.DarkflightStartParticles[i].SpawnRate, this.Const.Tactical.DarkflightStartParticles[i].Stages);
			}
			for( local i = 0; i < this.Const.Tactical.DazeParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DazeParticles[i].Brushes, tile, this.Const.Tactical.DazeParticles[i].Delay, this.Const.Tactical.DazeParticles[i].Quantity, this.Const.Tactical.DazeParticles[i].LifeTimeQuantity, this.Const.Tactical.DazeParticles[i].SpawnRate, this.Const.Tactical.DazeParticles[i].Stages);
			}

			if (tile.IsOccupiedByActor)
			{
				local pp = this.Math.rand(1, 15);
				local tg = tile.getEntity();
				local tss = tg.getSkills();
				if (pp == 1 && !tss.hasSkill("effects.insect_swarm"))
				{
					tss.add(this.new("scripts/skills/effects/insect_swarm_effect"));
				}
				else
				if (pp == 2 && !tss.hasSkill("effects.acid"))
				{
					tss.add(this.new("scripts/skills/effects/acid_effect"));
				}
				else
				if (pp == 3 && !tss.hasSkill("effects.goblin_poison"))
				{
					tss.add(this.new("scripts/skills/effects/goblin_poison_effect"));
				}
				else
				if (pp == 4 && !tss.hasSkill("effects.staggered"))
				{
					tss.add(this.new("scripts/skills/effects/staggered_effect"));
				}
				else
				if (pp == 5 && !tss.hasSkill("effects.dazed") && !tg.getCurrentProperties().IsImmuneToDaze)
				{
					tss.add(this.new("scripts/skills/effects/dazed_effect"));
				}
				else
				if (pp == 6 && !tss.hasSkill("effects.stunned") && !tg.getCurrentProperties().IsImmuneToStun)
				{
					tss.add(this.new("scripts/skills/effects/stunned_effect"));
				}
				else
				if (pp == 7 && !tss.hasSkill("effects.taunt"))
				{
					tss.add(this.new("scripts/skills/effects/taunt_effect"));
				}
				else
				if (pp == 8 && !tss.hasSkill("effects.distracted"))
				{
					tss.add(this.new("scripts/skills/effects/distracted_effect"));
				}
				else
				if (pp == 9 && !tss.hasSkill("effects.shellshocked") && this.Const.DLC.Desert)
				{
					tss.add(this.new("scripts/skills/effects/shellshocked_effect"));
				}
				else
				if (pp == 10 && !tss.hasSkill("effects.chilled"))
				{
					tss.add(this.new("scripts/skills/effects/chilled_effect"));
				}
				else
				if (pp == 11 && !tss.hasSkill("effects.sleeping") && !tg.getCurrentProperties().IsImmuneToStun)
				{
					tss.add(this.new("scripts/skills/effects/sleeping_effect"));
				}
				else
				if (pp == 12 && !tg.getCurrentProperties().IsImmuneToPoison && tg.getHitpoints() > 0)
				{
					local ape = this.new("scripts/skills/effects/ai_poison_effect");
					ape.setDamage(10);
					tss.add(ape);
				}
				else
				{
					if (!tss.hasSkill("effects.horrified") && !tg.getCurrentProperties().IsImmuneToStun)
					{
						tss.add(this.new("scripts/skills/effects/horrified_effect"));
					}
					else
					{
						if (tg.getCurrentProperties().DamageReceivedTotalMult > 0)
						{
							this.spawnIcon("status_effect_84", tile);
							local dmg = this.Math.rand(10, 30);
							if (tg.getHitpoints() <= dmg)
							{
								tss.add(this.new("scripts/skills/effects/ai_stun_effect"));
								tss.add(this.new("scripts/skills/effects/ai_mortalwound_effect"));
							}
							tg.setHitpoints(this.Math.max(tg.getHitpoints() - dmg, 1));
							tg.playSound(this.Const.Sound.ActorEvent.DamageReceived, 0.8);
						}
						this.Tactical.getShaker().shake(tg, tg.getTile(), 4);
					}
				}
			}
		}
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

