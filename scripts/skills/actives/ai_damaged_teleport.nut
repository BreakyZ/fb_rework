this.ai_damaged_teleport <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = 0
	},
	function create()
	{
		this.m.ID = "effects.ai_damaged_teleport";
		this.m.Name = "Emergency Teleport";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_takeoff_01.wav",
			"sounds/enemies/vampire_takeoff_02.wav",
			"sounds/enemies/vampire_takeoff_03.wav"
		];
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.IsSpent == 1)
		{
			return;
		}

		if (_damageHitpoints <= 5)
		{
			return;
		}

		this.m.IsSpent = 1;
		local attempts = 0;
		local nn = 0;
		local actor = this.getContainer().getActor();
		local targetTile = actor.getTile();
		while (attempts++ < 800)
		{
			local x = this.Math.rand(targetTile.SquareCoords.X - 10, targetTile.SquareCoords.X + 10);
			local y = this.Math.rand(targetTile.SquareCoords.Y - 10, targetTile.SquareCoords.Y + 10);
			if (!this.Tactical.isValidTileSquare(x, y))
			{
				continue;
			}
			local tile = this.Tactical.getTileSquare(x, y);
			if (tile.IsEmpty && tile.Type != this.Const.Tactical.TerrainType.Impassable && targetTile.getDistanceTo(tile) > 4 && targetTile.getDistanceTo(tile) < 8)
			{
				nn = 1
				local tag = {
					Actor = actor,
					Tile = tile,
					ActorTile = actor.getTile(),
					Skill = this
				};
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 1, this.onTeleportStart, tag);
			}
			if (nn == 1)
			{
				break;
			}
		}
	}

	function onTeleportStart( _tag )
	{
		if (_tag.Actor.isAlive())
		{
			local actor = _tag.Actor;
			local tile = _tag.Tile;
			local targetTile = _tag.ActorTile;
			local xskill = _tag.Skill;
			for( local i = 0; i < this.Const.Tactical.DarkflightStartParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DarkflightStartParticles[i].Brushes, targetTile, this.Const.Tactical.DarkflightStartParticles[i].Delay, this.Const.Tactical.DarkflightStartParticles[i].Quantity, this.Const.Tactical.DarkflightStartParticles[i].LifeTimeQuantity, this.Const.Tactical.DarkflightStartParticles[i].SpawnRate, this.Const.Tactical.DarkflightStartParticles[i].Stages);
			}
			for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, targetTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
			}
			for( local i = 0; i < this.Const.Tactical.DarkflightEndParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DarkflightEndParticles[i].Brushes, tile, this.Const.Tactical.DarkflightEndParticles[i].Delay, this.Const.Tactical.DarkflightEndParticles[i].Quantity, this.Const.Tactical.DarkflightEndParticles[i].LifeTimeQuantity, this.Const.Tactical.DarkflightEndParticles[i].SpawnRate, this.Const.Tactical.DarkflightEndParticles[i].Stages);
			}
			for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, tile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
			}
			this.Tactical.getNavigator().teleport(actor, tile, null, null, false, 0);
			xskill.spawnIcon("perk_25_active", targetTile);
			this.Sound.play(xskill.m.SoundOnUse[this.Math.rand(0, xskill.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill);
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = 0;
	}

	function onCombatFinished()
	{
		this.m.IsSpent = 0;
	}

});

