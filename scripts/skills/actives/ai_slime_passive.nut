this.ai_slime_passive <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ai_slime_passive";
		this.m.Name = "Slime Passive";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}
		if (this.Math.rand(1, 100) <= 50)
		{
			if (!_targetEntity.getSkills().hasSkill("effects.stunned") && !_targetEntity.getCurrentProperties().IsImmuneToStun)
			{
				local stun = this.new("scripts/skills/effects/stunned_effect");
				_targetEntity.getSkills().add(stun);
				stun.setTurns(2);
			}
			if (!_targetEntity.getCurrentProperties().IsImmuneToDaze)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			}
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}
		if (this.Math.rand(1, 100) <= 50)
		{
			if (!_targetEntity.getSkills().hasSkill("effects.stunned") && !_targetEntity.getCurrentProperties().IsImmuneToStun)
			{
				local stun = this.new("scripts/skills/effects/stunned_effect");
				_targetEntity.getSkills().add(stun);
				stun.setTurns(2);
			}
			if (!_targetEntity.getCurrentProperties().IsImmuneToDaze)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.ai_punch")
		{
			if (_targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.dazed"))
			{
				_properties.MeleeSkill += 20;
			}
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill == null)
		{
			return;
		}
		if (_skill.getID() == "actives.bash" || _skill.getID() == "actives.knock_out" || _skill.getID() == "actives.cudgel" || _skill.getID() == "actives.strike_down" || _skill.getID() == "actives.crumble" || _skill.getID() == "actives.knock_over")
		{
			_properties.DamageReceivedRegularMult *= 3;
		}
		else if (_skill.getID() == "actives.flail" || _skill.getID() == "actives.lash" || _skill.getID() == "actives.cascade" || _skill.getID() == "actives.hail" || _skill.getID() == "actives.pound" || _skill.getID() == "actives.thresh")
		{
			_properties.DamageReceivedRegularMult *= 2;
		}
		else if (_skill.getID() == "actives.hammer" || _skill.getID() == "actives.crush_armor" || _skill.getID() == "actives.smite" || _skill.getID() == "actives.shatter" || _skill.getID() == "actives.batter" || _skill.getID() == "actives.demolish_armor")
		{
			_properties.DamageReceivedRegularMult *= 3;
		}
	}

});

