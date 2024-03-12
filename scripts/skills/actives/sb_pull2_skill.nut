this.sb_pull2_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Skillcharge = 1
	},
	function create()
	{
		this.m.ID = "actives.sb_pull2_skill";
		this.m.Name = "Abyssal Grab";
		this.m.Description = "Pulls a distant enemy target towards you and binds it with tentacles.";
		this.m.Icon = "ui/xx72.png";
		this.m.IconDisabled = "ui/xx72_sw.png";
		this.m.Overlay = "active_149";
		this.m.SoundOnUse = [
			"sounds/enemies/lindwurm_gorge_hit_01.wav",
			"sounds/enemies/lindwurm_gorge_hit_02.wav",
			"sounds/enemies/lindwurm_gorge_hit_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/break_free_roots_00.wav",
			"sounds/combat/break_free_roots_01.wav",
			"sounds/combat/break_free_roots_02.wav",
			"sounds/combat/break_free_roots_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 35;
		this.m.MinRange = 2;
		this.m.MaxRange = 5;
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
			text = "Effect on target: Unable to move. Removes shieldwall / spearwall / riposte. -50% Melee and Ranged Defense. -70% Hit chance against enemies. Takes 10 ~ 15 damage per turn. (This damage permanently cripples enemies instead of killing them)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can be used [color=#8f1e1e]" + this.m.Skillcharge + "[/color] more times in this battle."
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcharge = this.m.Skillcharge - 1;
		local target = _targetTile.getEntity();
		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);
		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");
		this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, target.getPos());
		for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _targetTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity, this.Const.Tactical.DustParticles[i].LifeTimeQuantity, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
		}

		local scaleBackup1 = target.getSprite("status_rooted").Scale;
		local scaleBackup2 = target.getSprite("status_rooted_back").Scale;
		local rooted = target.getSprite("status_rooted");
		rooted.setBrush("");
		rooted.Scale = 1.0;
		rooted.Visible = true;
		local rooted_back = target.getSprite("status_rooted_back");
		rooted_back.setBrush("");
		rooted_back.Scale = 1.0;
		rooted_back.Visible = true;
		target.raiseRootsFromGround(this.Math.rand(1, 2) > 1 ? "kraken_ensnare_front" : "kraken_ensnare_front_injured", this.Math.rand(1, 2) > 1 ? "kraken_ensnare_back" : "kraken_ensnare_back_2");
		target.sinkIntoGround(0.7);

		local breakFree = this.new("scripts/skills/actives/break_free_skill");
		breakFree.m.Icon = "skills/active_148.png";
		breakFree.m.IconDisabled = "skills/active_148_sw.png";
		breakFree.m.Overlay = "active_148";
		if (Math.rand(1, 2) == 1)
		{
			breakFree.setDecal(this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)]);
		}
		else
		{
			breakFree.setDecal("bust_kraken_tentacle_body_dead");
		}
		breakFree.m.SoundOnUse = this.m.SoundOnHit;
		breakFree.m.SoundVolume = 0.9;
		breakFree.setChanceBonus(-10);
		target.getSkills().add(breakFree);

		if (knockToTile == null)
		{
			knockToTile = _targetTile;
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1000, this.onDone, {
			User = _user,
			Target = target,
			TargetTile = _targetTile,
			KnockToTile = knockToTile,
			ScaleBackup1 = scaleBackup1,
			ScaleBackup2 = scaleBackup2,
			Skill = this
		});
	}

	function onDone( _data )
	{
		local ensnare = this.new("scripts/skills/effects/sb_snake_target_effect");
		ensnare.setOnRemoveCallback(function ( _data )
		{
			local targetTile = _data.Target.getTile();
			local tile;
			local n = this.Const.BloodType.Red;
			for( local i = 0; i < this.Const.Tactical.BloodEffects[n].len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.BloodEffects[n][i].Brushes, targetTile, this.Const.Tactical.BloodEffects[n][i].Delay, this.Const.Tactical.BloodEffects[n][i].Quantity, this.Const.Tactical.BloodEffects[n][i].LifeTimeQuantity, this.Const.Tactical.BloodEffects[n][i].SpawnRate, this.Const.Tactical.BloodEffects[n][i].Stages);
			}
			local rooted = _data.Target.getSprite("status_rooted");
			rooted.Scale = _data.ScaleBackup1;
			rooted.setBrush("");
			rooted.Visible = false;
			local rooted_back = _data.Target.getSprite("status_rooted_back");
			rooted_back.Scale = _data.ScaleBackup2;
			rooted_back.setBrush("");
			rooted_back.Visible = false;
		}, _data);
		ensnare.m.Icon = "skills/status_effect_95.png";
		ensnare.m.IconMini = "status_effect_95_mini";
		ensnare.m.Overlay = "status_effect_95";
		_data.Target.getSkills().add(ensnare);
		_data.Target.riseFromGround(0.3);
		this.Tactical.getNavigator().teleport(_data.Target, _data.KnockToTile, null, null, true, 5);
		for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _data.KnockToTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity, this.Const.Tactical.DustParticles[i].LifeTimeQuantity, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
		}
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _userTile.getDirectionTo(_targetTile);
		if (_userTile.hasNextTile(dir))
		{
			local tile = _userTile.getNextTile(dir);
			if (tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = dir - 1 >= 0 ? dir - 1 : 5;
		if (_userTile.hasNextTile(dir))
		{
			local tile = _userTile.getNextTile(dir);
			if (tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		dir = _targetTile.getDirectionTo(_userTile);
		dir = dir + 1 <= 5 ? dir + 1 : 0;
		if (_userTile.hasNextTile(dir))
		{
			local tile = _userTile.getNextTile(dir);
			if (tile.Level <= _userTile.Level && tile.IsEmpty)
			{
				return tile;
			}
		}

		return null;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab || _targetTile.getEntity().getCurrentProperties().IsRooted || _targetTile.getEntity().getCurrentProperties().IsImmuneToRoot)
		{
			return false;
		}

		local MoveTo = this.findTileToKnockBackTo(_originTile, _targetTile);
		if (MoveTo == null)
		{
			return false;
		}

		return true;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else if (this.m.Skillcharge <= 0)
		{
			return false;
		}

		return true;
	}

	function isHidden()
	{
		if (this.m.Skillcharge > 0)
		{
			return false;
		}

		return true;
	}

	function onCombatFinished()
	{
		this.m.Skillcharge = 1;
	}

});

