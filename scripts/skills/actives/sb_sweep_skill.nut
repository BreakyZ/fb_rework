this.sb_sweep_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 1,
		Skillcool = 1
	},
	function create()
	{
		this.m.ID = "actives.sb_sweep_skill";
		this.m.Name = "Foot Sweep";
		this.m.Description = "Kick the target\'s feet, knocking it down and dealing damage. \n[color=#8f1e1e]The target need the following effects:[/color] Stunned / Dazed / Overwhelmed / Distracted / Staggered / Taunting / Swarm of Insects";
		this.m.Icon = "ui/xx55.png";
		this.m.IconDisabled = "ui/xx55_sw.png";
		this.m.Overlay = "active_06";
		this.m.SoundOnHit = [
			"sounds/combat/repel_hit_01.wav",
			"sounds/combat/repel_hit_02.wav",
			"sounds/combat/repel_hit_03.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/combat/impale_01.wav",
			"sounds/combat/impale_02.wav",
			"sounds/combat/impale_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = 20;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] chance to hit"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 1 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1;
			_properties.DamageDirectAdd = 0;
			_properties.DamageDirectMeleeAdd = 0;
			_properties.DamageDirectRangedAdd = 0;
			_properties.DamageDirectMult = 1;
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			if (mainh != null && offh == null && mainh.isDoubleGrippable())
			{
				_properties.DamageTotalMult /= 1.25;
			}			
			_properties.DamageRegularMin = 20;
			_properties.DamageRegularMax = 40;
			_properties.DamageArmorMult = 0.8;
			_properties.MeleeSkill += 30;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local targetsk = _targetTile.getEntity().getSkills();
		if (targetsk.hasSkill("effects.stunned"))
		{
			return true;
		}

		if (targetsk.hasSkill("effects.dazed"))
		{
			return true;
		}

		if (targetsk.hasSkill("effects.overwhelmed"))
		{
			return true;
		}

		if (targetsk.hasSkill("effects.distracted"))
		{
			return true;
		}

		if (targetsk.hasSkill("effects.staggered"))
		{
			return true;
		}

		if (targetsk.hasSkill("effects.taunt"))
		{
			return true;
		}

		if (targetsk.hasSkill("effects.insect_swarm"))
		{
			return true;
		}
		return false;
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

