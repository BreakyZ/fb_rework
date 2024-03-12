this.ai_damaged_move <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = 0
	},
	function create()
	{
		this.m.ID = "effects.ai_damaged_move";
		this.m.Name = "Emergency Evasion";
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
		if (!this.getContainer().getActor().isAlive() || this.getContainer().getActor().isDying())
		{
			return;
		}

		if (_damageHitpoints <= 5)
		{
			return;
		}

		if (_damageHitpoints >= this.getContainer().getActor().getHitpoints())
		{
			return;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			return;
		}

		if (this.m.IsSpent == 1)
		{
			return;
		}

		this.m.IsSpent = 1;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();

		if (!actor.isAlive() || actor.isDying() || !actor.getSkills().hasSkill("effects.xxitem_horse_skill"))
		{
			return;
		}

		if (this.m.IsSpent == 0)
		{
			return;
		}

		this.m.IsSpent = 0;
		local attempts = 0;
		local nn = 0;
		local targetTile = actor.getTile();
		local nono = 0;
		for( local i = 5; i >= 0; i = --i )
		{
			if (!targetTile.hasNextTile(i))
			{
			}
			else
			{
				local ptile = targetTile.getNextTile(i);
				if (ptile.IsOccupiedByActor && ptile.getEntity().isAttackable() && this.Math.abs(ptile.Level - targetTile.Level) <= 1 && !ptile.getEntity().isAlliedWith(actor))
				{
					nono = 1;
					if (nono == 1)
					{
						break;
					}
				}
			}
		}

		if (nono == 0)
		{
			return;
		}

		this.spawnIcon("perk_25_active", targetTile);
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill);
		for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, targetTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
		}
		while (attempts++ < 800)
		{
			local x = this.Math.rand(targetTile.SquareCoords.X - 10, targetTile.SquareCoords.X + 10);
			local y = this.Math.rand(targetTile.SquareCoords.Y - 10, targetTile.SquareCoords.Y + 10);
			if (!this.Tactical.isValidTileSquare(x, y))
			{
				continue;
			}
			local tile = this.Tactical.getTileSquare(x, y);
			if (tile.IsEmpty && tile.Type != this.Const.Tactical.TerrainType.Impassable && targetTile.getDistanceTo(tile) > 3 && targetTile.getDistanceTo(tile) < 6)
			{
				this.Tactical.getNavigator().teleport(actor, tile, null, null, false, 1.5);
				for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, tile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
				}
				nn = 1
			}
			if (nn == 1)
			{
				break;
			}
		}
	}

	function onCombatFinished()
	{
		this.m.IsSpent = 0;
	}

});

