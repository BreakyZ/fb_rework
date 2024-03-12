this.ai_wendigo_passive <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ai_wendigo_passive";
		this.m.Name = "Wendigo Attack";
		this.m.Description = "TODO";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}

		local xacid = _targetEntity.getSkills().getSkillByID("effects.chilled");
		if (xacid == null)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
		}
		else
		{
			xacid.resetTime();
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			return;
		}

		local xacid = _targetEntity.getSkills().getSkillByID("effects.chilled");
		if (xacid == null)
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
		}
		else
		{
			xacid.resetTime();
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints <= 10)
		{
			return;
		}
		if (_attacker == null || !_attacker.isAlive())
		{
			return;
		}
		if (_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) > 1)
		{
			return;
		}

		local poison = _attacker.getSkills().getSkillByID("effects.chilled");
		if (poison == null)
		{
			_attacker.getSkills().add(this.new("scripts/skills/effects/chilled_effect"));
		}
		else
		{
			poison.resetTime();
		}
	}

});

