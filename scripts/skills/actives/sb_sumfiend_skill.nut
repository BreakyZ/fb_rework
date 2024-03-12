this.sb_sumfiend_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 15,
		Skillcool = 15
	},
	function create()
	{
		this.m.ID = "actives.sb_sumfiend_skill";
		this.m.Name = "Summon Fiend";
		this.m.Description = "Summons a slow but powerful creature for a limited time. \n[color=" + this.Const.UI.Color.NegativeValue + "]When summoned, the caster loses 50% of current Health[/color]";
		this.m.Icon = "ui/xx16.png";
		this.m.IconDisabled = "ui/xx16_sw.png";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_charge_01.wav",
			"sounds/enemies/orc_charge_02.wav",
			"sounds/enemies/orc_charge_03.wav",
			"sounds/enemies/orc_charge_04.wav"
		];
		this.m.SoundVolume = 0.9;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Cooldown : 15 turn (The summoned creature lasts for 8 turns) \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When caster level is 10 or higher: +10 Damage, +10 Melee skill, +100 Health"
			}
		];
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local actor = this.getContainer().getActor();
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		_user.setHitpoints(this.Math.max(2, _user.getHitpoints() / 2));
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = 0.00001;
		hitInfo.DamageDirect = 1;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1;
		_user.onDamageReceived(_user, null, hitInfo);
		local entity = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/xxsum_fiend", _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.getFlags().add("undead");
		entity.riseFromGround(0.7);
		local selfkill = this.new("scripts/skills/effects/ai_selfkill_effect");
		entity.m.Skills.add(selfkill);
		selfkill.setTurns(8);
		if (_user.getLevel() >= 10)
		{
			entity.getBaseProperties().DamageRegularMin += 10;
			entity.getBaseProperties().DamageRegularMax += 10;
			entity.getBaseProperties().MeleeSkill += 10;
			entity.getBaseProperties().Hitpoints += 100;
			entity.getSprite("body").setBrush("bust_eyemon_02");
			entity.setName("Abyssal Fiend");
		}
		for( local i = 0; i < this.Const.Tactical.RaiseUndeadParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(true, this.Const.Tactical.RaiseUndeadParticles[i].Brushes, _user.getTile(), this.Const.Tactical.RaiseUndeadParticles[i].Delay, this.Const.Tactical.RaiseUndeadParticles[i].Quantity, this.Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseUndeadParticles[i].SpawnRate, this.Const.Tactical.RaiseUndeadParticles[i].Stages);
		}
		for( local i = 0; i < this.Const.Tactical.KrakenDevourParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.KrakenDevourParticles[i].Brushes, _targetTile, this.Const.Tactical.KrakenDevourParticles[i].Delay, this.Const.Tactical.KrakenDevourParticles[i].Quantity, this.Const.Tactical.KrakenDevourParticles[i].LifeTimeQuantity, this.Const.Tactical.KrakenDevourParticles[i].SpawnRate, this.Const.Tactical.KrakenDevourParticles[i].Stages);
		}
		for( local i = 0; i < this.Const.Tactical.KrakenDevourVictimParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.KrakenDevourVictimParticles[i].Brushes, _targetTile, this.Const.Tactical.KrakenDevourVictimParticles[i].Delay, this.Const.Tactical.KrakenDevourVictimParticles[i].Quantity, this.Const.Tactical.KrakenDevourVictimParticles[i].LifeTimeQuantity, this.Const.Tactical.KrakenDevourVictimParticles[i].SpawnRate, this.Const.Tactical.KrakenDevourVictimParticles[i].Stages);
		}
		return true;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else if (this.m.Skillcool < this.m.Cooldown)
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

