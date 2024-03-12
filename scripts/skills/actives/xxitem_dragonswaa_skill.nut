this.xxitem_dragonswaa_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.xx_a";
		this.m.Name = "Dragon Slash";
		this.m.Description = "Attack the target with a merciless slash.";
		this.m.Icon = "skills/active_06.png";
		this.m.IconDisabled = "skills/active_06_sw.png";
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
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.HitChanceBonus = 25;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 98;
		this.m.ChanceSmash = 97;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] chance to hit"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Melee weapons mastery effect: +5 damage"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local rr = 5;
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInDaggers)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInHammers)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInMaces)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
			{
				_properties.DamageRegularMin += rr;
				_properties.DamageRegularMax += rr;
			}
			_properties.MeleeSkill += 25;
		}
	}

});

