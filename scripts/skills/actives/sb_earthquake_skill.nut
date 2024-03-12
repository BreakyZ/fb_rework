this.sb_earthquake_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 9,
		Skillcool = 9
	},
	function create()
	{
		this.m.ID = "actives.sb_earthquake_skill";
		this.m.Name = "Earthquake";
		this.m.Description = "Shakes the ground with magic, inflicting negative effects on targets in the area. Has no effect on caster himself. This skill is available 2 turns after the start of the battle";
		this.m.Icon = "ui/xx48.png";
		this.m.IconDisabled = "ui/xx48_sw.png";
		this.m.SoundOnUse = [
			"sounds/enemies/lindwurm_tail_slam_hit_01.wav",
			"sounds/enemies/lindwurm_tail_slam_hit_02.wav",
			"sounds/enemies/lindwurm_tail_slam_hit_03.wav",
			"sounds/enemies/lindwurm_tail_slam_hit_04.wav"
		];
		this.m.SoundVolume = 1.5;
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
		this.m.MaxRange = 4;
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
			text = "Negative effects: Staggered (-50% initiative), Expose Weakness (-10 defense), Morale Check (50% chance)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 9 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
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

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}
		return true;
	}

	function getAffectedTiles( _targetTile )
	{
		local ret = [
			_targetTile
		];
		local size = this.Tactical.getMapSize();
		for( local x = 0; x < size.X; x = ++x )
		{
			for( local y = 0; y < size.Y; y = ++y )
			{
				if (_targetTile.getDistanceTo(this.Tactical.getTileSquare(x, y)) <= 2 && this.Tactical.getTileSquare(x, y) != _targetTile)
				{
					ret.push(this.Tactical.getTileSquare(x, y));
				}
			}
		}
		return ret;
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

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local tiles = this.getAffectedTiles(_targetTile);
		foreach( t in tiles )
		{
			t.clear();
			t.Type = 0;
			this.MapGen.get("tactical.tile.earth1").onFirstPass({
				X = t.SquareCoords.X,
				Y = t.SquareCoords.Y,
				W = 1,
				H = 1,
				IsEmpty = true,
				SpawnObjects = false
			});
			if (this.Math.rand(1, 5) == 1)
			{
				t.setBrush("tile_desert_05");
			}
			else
			{
				t.setBrush("tile_desert_03");
			}
			if (this.Math.rand(1, 100) <= 70)
			{
				for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, t, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages, this.createVec(0, -30));
				}
			}
			if (t.IsOccupiedByActor && t.getEntity().isAttackable() && _user.getTile().getDistanceTo(t) > 0)
			{
				local e = t.getEntity();
				for( local i = 0; i < 10; i = ++i )
				{
					e.getSkills().add(this.new("scripts/skills/effects/ai_weak_effect"));
				}
				this.spawnIcon("status_effect_53", e.getTile());
				e.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
				if (this.Math.rand(1, 100) <= 50)
				{
					e.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
				}
				e.playSound(this.Const.Sound.ActorEvent.DamageReceived, 0.8);
				this.Tactical.getShaker().shake(e, t, 2);
			}
		}
		for( local i = 0; i < 5; i = ++i )
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 0 + (i * 100), function ( _skill )
			{
				this.Sound.play("sounds/enemies/lindwurm_tail_slam_hit_0" + this.Math.rand(1, 4) + ".wav", this.Const.Sound.Volume.Skill * 1, this.getContainer().getActor().getPos());
			}.bindenv(this), this);
		}
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else
		if (this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			return false;
		}
		else
		if (this.Time.getRound() < 2)
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

