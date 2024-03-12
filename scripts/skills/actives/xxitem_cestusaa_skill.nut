this.xxitem_cestusaa_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.xx_a";
		this.m.Name = "Improved Unarmed Strike";
		this.m.Description = "Attack the enemy with a powerful unarmed attack.";
		this.m.KilledString = "Pummeled to death";
		this.m.Icon = "skills/active_08.png";
		this.m.IconDisabled = "skills/active_08_sw.png";
		this.m.Overlay = "active_08";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "When attacking the head : Daze, Stun"
			}
		]);
		return ret;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local targetTile = _targetEntity.getTile();
			local user = this.getContainer().getActor();
			if (_bodyPart == this.Const.BodyPart.Head)
			{
				if (!_targetEntity.getCurrentProperties().IsImmuneToDaze)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " struck a hit that leaves " + this.Const.UI.getColorizedEntityName(_targetEntity) + " dazed");
					}
				}
				if (!_targetEntity.getSkills().hasSkill("effects.stunned") && !_targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
					if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(user) + " has stunned " + this.Const.UI.getColorizedEntityName(_targetEntity) + " for one turn");
					}
				}
			}
		}
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

