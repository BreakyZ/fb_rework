this.xxitem_meteoraa_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.xx_a";
		this.m.Name = "Meteor Whip";
		this.m.Description = "Whip your opponent. Has a range of 3 tiles.";
		this.m.KilledString = "Smashed";
		this.m.Icon = "skills/active_39.png";
		this.m.IconDisabled = "skills/active_39_sw.png";
		this.m.Overlay = "active_39";
		this.m.SoundOnUse = [
			"sounds/combat/pound_01.wav",
			"sounds/combat/pound_02.wav",
			"sounds/combat/pound_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/pound_hit_01.wav",
			"sounds/combat/pound_hit_02.wav",
			"sounds/combat/pound_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsShieldRelevant = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 55;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + this.getMaxRange() + " tiles"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When hitting the head: 10 Piercing damage, expose weakness (-10 melee and ranged defense, 2 turn, stackable)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Flail mastery effect: Ignores the bonus to Melee Defense granted by shields"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.IsShieldRelevant = !_properties.IsSpecializedInFlails;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			if (_bodyPart == this.Const.BodyPart.Head)
			{
				for( local i = 0; i < 10; i = ++i )
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
		}
	}

});

