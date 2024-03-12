this.sbp_rapid_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_rapid_skill";
		this.m.Name = "Rapid Reflexes (passive)";
		this.m.Icon = "ui/xxp12.png";
		this.m.Description = "If the attacker is slower than you, your melee and ranged defense increases by +5 and damage taken is reduced by 20%.";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsSerialized = true;
		this.m.IsHidden = false;
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
			}
		];
		return ret;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (this.getContainer().getActor().getInitiative() > _attacker.getInitiative())
		{
			_properties.MeleeDefense += 5;
			_properties.RangedDefense += 5;
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null || _attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		if (this.getContainer().getActor().getInitiative() > _attacker.getInitiative())
		{
			_properties.DamageReceivedTotalMult *= 0.8;
		}
	}

});

