this.sb_mark_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_mark_skill";
		this.m.Name = "Mark";
		this.m.Description = "Exposes the target\'s weaknesses and reduces melee and ranged defense.";
		this.m.Icon = "ui/xx25.png";
		this.m.IconDisabled = "ui/xx25_sw.png";
		this.m.SoundOnUse = [
			"sounds/enemies/horror_spell_01.wav",
			"sounds/enemies/horror_spell_02.wav",
			"sounds/enemies/horror_spell_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 9;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + this.getMaxRange() + " tiles"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Target: Expose Weakness (-15 melee and ranged defense, 3 turn)"
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local effect = this.Tactical.spawnSpriteEffect("effect_skull_03", this.createColor("#ffffff"), _targetTile, 0, 40, 1.0, 0.25, 0, 400, 300);
		local xsk = this.new("scripts/skills/effects/ai_weak_effect");
		xsk.m.TurnsBase = 3;
		for( local i = 0; i < 15; i = ++i )
		{
			target.getSkills().add(xsk);
		}
		this.spawnIcon("status_effect_53", target.getTile());
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = 0.00001;
		hitInfo.DamageDirect = 1;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1;
		target.onDamageReceived(target, this, hitInfo);
		return true;
	}

});

