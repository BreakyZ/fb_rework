this.sbp_beater_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_beater_skill";
		this.m.Name = "Vengeance (passive)";
		this.m.Icon = "ui/xxp25.png";
		this.m.Description = "This character has a 50% chance to expose the attacker\'s weakness when dodging a single melee attack. (-7 melee and ranged defense, 2 turn, stackable)";
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

	function onMissed( _attacker, _skill )
	{
		local actor = this.getContainer().getActor();
		if (_skill.isAttack() && !_skill.isRanged() && !_skill.isAOE() && _attacker != null && _attacker.isAlive() && actor != null && actor.isAlive() && !_attacker.isAlliedWith(actor) && this.Math.rand(1, 100) <= 50)
		{
			for( local i = 0; i < 7; i = ++i )
			{
				_attacker.getSkills().add(this.new("scripts/skills/effects/ai_weak_effect"));
			}
			this.spawnIcon("status_effect_53", _attacker.getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = 0.00001;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			_attacker.onDamageReceived(_attacker, null, hitInfo);
		}
	}

});

