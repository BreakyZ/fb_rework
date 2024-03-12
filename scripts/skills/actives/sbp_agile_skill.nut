this.sbp_agile_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_agile_skill";
		this.m.Name = "Agile Killer (passive)";
		this.m.Icon = "ui/xxp28.png";
		this.m.Description = "When attacking, if you are faster than the target, your melee and ranged skills increase by +5. If you successfully hit, there is a 50% chance that the target\'s weakness will be revealed. (-7 melee and ranged defense, 2 turns, stackable)";
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && _skill.isAttack())
		{
			if (this.getContainer().getActor().getInitiative() > _targetEntity.getInitiative())
			{
				_properties.MeleeSkill += 5;
				_properties.RangedSkill += 5;
			}
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isNonCombatant() || !_skill.isAttack() || 
		_targetEntity.getSkills().hasSkill("effects.charmed") || this.getContainer().getActor().isAlliedWith(_targetEntity) || 
		_targetEntity.getFaction() == this.Const.Faction.Player)
		{
			return false;
		}

		if (this.getContainer().getActor().getInitiative() <= _targetEntity.getInitiative())
		{
			return false;
		}

		if (this.Math.rand(1, 100) > 50)
		{
			return false;
		}		

		for( local i = 0; i < 7; i = ++i )
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/ai_weak_effect"));
		}
		this.spawnIcon("status_effect_53", _targetEntity.getTile());
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = 0.00001;
		hitInfo.DamageDirect = 1;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1;
		_targetEntity.onDamageReceived(_targetEntity, this, hitInfo);
		return true;
	}

});

