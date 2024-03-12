this.sbp_headcollector_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_headcollector_skill";
		this.m.Name = "Head Collector (passive)";
		this.m.Icon = "ui/xxp13.png";
		this.m.Description = "+10% Chance to hit head. When attacking, hitting the head restores 5 fatigue.";
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

	function onUpdate( _properties )
	{
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}
		if (_bodyPart == this.Const.BodyPart.Head)
		{
			local actor = this.getContainer().getActor();
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - 5));
			actor.setDirty(true);
		}
	}

});

