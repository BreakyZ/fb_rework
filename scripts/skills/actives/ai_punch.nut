this.ai_punch <- this.inherit("scripts/skills/skill", {
	//used demon9 sholin9 spider9 fungalzombie9
	m = {},
	function create()
	{
		this.m.ID = "actives.ai_punch";
		this.m.Name = "Attack";
		this.m.Overlay = "active_06";
		this.m.SoundOnUse = [
			"sounds/combat/overhead_strike_01.wav",
			"sounds/combat/overhead_strike_02.wav",
			"sounds/combat/overhead_strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/overhead_strike_hit_01.wav",
			"sounds/combat/overhead_strike_hit_02.wav",
			"sounds/combat/overhead_strike_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 33;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 33;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (this.m.Container.hasSkill("perk.brawny"))
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
		}

		if (success && target.isAlive() && !target.isDying())
		{
			if (_user.getFlags().has("fiend_minion") && !target.getCurrentProperties().IsImmuneToDaze && this.Math.rand(1, 100) <= 50)
			{
				target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			}
		}

		return success;
	}

});

