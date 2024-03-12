this.sb_blessing_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 5,
		Skillcool = 5
	},
	function create()
	{
		this.m.ID = "actives.sb_blessing_skill";
		this.m.Name = "Blessing";
		this.m.Description = "Gives various beneficial effects to the target";
		this.m.Icon = "ui/xx9.png";
		this.m.IconDisabled = "ui/xx9_sw.png";
		this.m.SoundOnUse = [
			"sounds/ambience/terrain/dark_forest_owl_05.wav"
		];
		this.m.SoundVolume = 1.9;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "+2 AP, -30% Next damage taken, +30% Next attack damage. (If multiple targets are hit, only the first one will receive increased damage. If the attack misses, the effect is wasted)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 5 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function getCursorForTile( _tile )
	{
		return this.Const.UI.Cursor.Drink;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local target = _targetTile.getEntity();
		local effect = {
				Delay = 0,
				Quantity = 10,
				LifeTimeQuantity = 10,
				SpawnRate = 150,
				Brushes = [
					"sparkleflare_1"
				],
				Stages = [
					{
						LifeTimeMin = 0.2,
						LifeTimeMax = 0.5,
						ColorMin = this.createColor("ffff00cc"),
						ColorMax = this.createColor("ffff00ff"),
						ScaleMin = 0.2,
						ScaleMax = 0.5,
						RotationMin = -20,
						RotationMax = 20,
						VelocityMin = 70,
						VelocityMax = 100,
						DirectionMin = this.createVec(-0.5, -0.2),
						DirectionMax = this.createVec(0.5, 0.5),
						SpawnOffsetMin = this.createVec(-25, -30),
						SpawnOffsetMax = this.createVec(25, 30)
					},
					{
						LifeTimeMin = 0.2,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffff8080"),
						ColorMax = this.createColor("ffff80ff"),
						ScaleMin = 0.2,
						ScaleMax = 0.4,
						RotationMin = -20,
						RotationMax = 20,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = this.createVec(50, 70),
						ForceMax = this.createVec(100, 100)
					},
					{
						LifeTimeMin = 0.2,
						LifeTimeMax = 0.3,
						ColorMin = this.createColor("ffff3b80"),
						ColorMax = this.createColor("ffff3bff"),
						ScaleMin = 0.2,
						ScaleMax = 0.3,
						RotationMin = -20,
						RotationMax = 20,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = this.createVec(-100, 70),
						ForceMax = this.createVec(-150, 100)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.2,
						ColorMin = this.createColor("ffff3bcc"),
						ColorMax = this.createColor("ffff3bff"),
						ScaleMin = 0.1,
						ScaleMax = 0.2,
						RotationMin = -20,
						RotationMax = 20,
						VelocityMin = 0,
						VelocityMax = 0,
						ForceMin = this.createVec(0, 50),
						ForceMax = this.createVec(50, 80)
					}
				]
		};
		this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity * 0.5, effect.LifeTimeQuantity * 0.5, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
		effect = this.Tactical.spawnSpriteEffect("sparkleflare_1", this.createColor("#ffff00"), _targetTile, 0, 40, 2, 1.5, -10, 400, 300);
		if (target.getSkills().hasSkill("effects.sb_blessing_effect_a"))
		{
			target.getSkills().removeByID("effects.sb_blessing_effect_a");
		}
		target.getSkills().add(this.new("scripts/skills/effects/sb_blessing_effect_a"));
		target.getSkills().add(this.new("scripts/skills/effects/sb_blessing_effect_b"));
		target.setActionPoints(target.getActionPoints() + 2);
		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}
		if (!this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}
		return true;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else
		if (this.m.Skillcool < this.m.Cooldown)
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

