this.sb_electric_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_electric_skill";
		this.m.Name = "Electric Shock";
		this.m.Description = "Shock the target with electricity, dealing damage. Deals additional damage based on the target\'s current used fatigue.";
		this.m.Icon = "ui/xx6.png";
		this.m.IconDisabled = "ui/xx6_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.SoundVolume = 1.2;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShieldRelevant = false;
		this.m.InjuriesOnBody = this.Const.Injury.BurningBody;
		this.m.InjuriesOnHead = this.Const.Injury.BurningHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 4;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 80;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + this.getMaxRange() + " tiles"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Ignores the bonus to Melee Defense granted by shields. (Melee hit chance)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage: [color=" + this.Const.UI.Color.PositiveValue + "]100% of Target\'s current used fatigue + 40 ~ 80[/color] (Max damage: 300, Melee damage type)"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "20% chance to stun for 1 turn on a hit"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local actor = this.getContainer().getActor();
		local target = _targetTile.getEntity();
		local effect = {
			Delay = 0,
			Quantity = 12,
			LifeTimeQuantity = 12,
			SpawnRate = 100,
			Brushes = [
				"bust_lich_aura_01"
			],
			Stages = [
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("ffffff5f"),
					ColorMax = this.createColor("ffffff5f"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					SpawnOffsetMin = this.createVec(-10, -10),
					SpawnOffsetMax = this.createVec(10, 10),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("ffffff2f"),
					ColorMax = this.createColor("ffffff2f"),
					ScaleMin = 0.9,
					ScaleMax = 0.9,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.1,
					ScaleMax = 0.1,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		};
		this.Tactical.spawnParticleEffect(false, effect.Brushes, _targetTile, effect.Delay, effect.Quantity * 0.5, effect.LifeTimeQuantity * 0.5, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
		for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _targetTile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages, this.createVec(0, -30));
		}
		this.Tactical.getShaker().shake(target, actor.getTile(), 4);

		actor.getCurrentProperties().DamageRegularMin = 0;
		actor.getCurrentProperties().DamageRegularMax = 0;
		this.m.SoundOnHit = [];
		if (!this.attackEntity(_user, target, false))
		{
			return false;
		}
		this.m.SoundOnHit = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];

		local xxap = actor.getActionPoints();
		actor.setActionPoints(0);
		target.storeSpriteColors();
		if ((target.getFlags().has("human") && target.getBaseProperties().Bravery <= 190) || (target.getFlags().has("undead") && target.getHitpointsMax() > 1) || target.getFlags().has("goblin"))
		{
			target.fadeTo(this.createColor("00284d4D"), 100);
			target.playSound(this.Const.Sound.ActorEvent.Death, 1.5);
			target.addSprite("permanent_injury_elec1");
			target.getSprite("permanent_injury_elec1").setHorizontalFlipping(true);
			target.getSprite("permanent_injury_elec1").setBrush("bust_skeleton_body_01");
			target.getSprite("permanent_injury_elec1").Visible = true;
			target.getSprite("permanent_injury_elec1").Scale = 0.85;
			target.getSprite("permanent_injury_elec1").Color = this.createColor("#70d4ff");
			target.addSprite("permanent_injury_elec2");
			target.getSprite("permanent_injury_elec2").setHorizontalFlipping(true);
			target.getSprite("permanent_injury_elec2").setBrush("bust_skeleton_flying_head_01");
			target.getSprite("permanent_injury_elec2").Visible = true;
			target.getSprite("permanent_injury_elec2").Scale = 0.85;
			target.getSprite("permanent_injury_elec2").Color = this.createColor("#70d4ff");
			target.setSpriteOffset("permanent_injury_elec2", this.createVec(-5, 5));
		}
		else
		{
			target.fadeTo(this.createColor("00284dff"), 100);
			target.playSound(this.Const.Sound.ActorEvent.Death, 1.1);
		}
		local time = 5;
		for( local i = 0; i < time; i = ++i )
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 0 + (i * 150), function ( _skill )
			{
				time = time - 1;
				for( local i = 0; i < this.Const.Tactical.LightningParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.LightningParticles[i].Brushes, _targetTile, this.Const.Tactical.LightningParticles[i].Delay, this.Const.Tactical.LightningParticles[i].Quantity, this.Const.Tactical.LightningParticles[i].LifeTimeQuantity, this.Const.Tactical.LightningParticles[i].SpawnRate, this.Const.Tactical.LightningParticles[i].Stages);
				}
				this.Sound.play("sounds/combat/poison_applied_0" + this.Math.rand(1, 2) + ".wav", this.Const.Sound.Volume.Skill * 0.5, _user.getPos());
				if (time == 0)
				{
					if (target.isAlive() && !target.isDying())
					{
						target.fadeToStoredColors(100);
						if (target.hasSprite("permanent_injury_elec1"))
						{
							target.getSprite("permanent_injury_elec1").Visible = false;
							target.removeSprite("permanent_injury_elec1");
						}
						if (target.hasSprite("permanent_injury_elec2"))
						{
							target.getSprite("permanent_injury_elec2").Visible = false;
							target.removeSprite("permanent_injury_elec2");
						}
					}
					this.Time.scheduleEvent(this.TimeUnit.Virtual, 150, function ( _skill )
					{
						if (actor.isAlive() && !actor.isDying() && target.isAlive() && !target.isDying() && target.isAttackable())
						{
							actor.setActionPoints(xxap);
							actor.getItems().updateAppearance();
							local sdmg = this.Math.min(this.Math.floor(target.getFatigue() * 1), 300);
							actor.getCurrentProperties().MeleeSkill = 500;
							actor.getCurrentProperties().DamageRegularMin = 40 + sdmg;
							actor.getCurrentProperties().DamageRegularMax = 80 + sdmg;
							actor.getCurrentProperties().DamageArmorMult = 1;
							this.attackEntity(_user, target, false);
						}
					}.bindenv(this), this);
				}
			}.bindenv(this), this);
		}
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1;
			_properties.DamageDirectAdd = 0;
			_properties.DamageDirectMeleeAdd = 0;
			_properties.DamageDirectRangedAdd = 0;
			_properties.DamageDirectMult = 1;
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			if (mainh != null && offh == null && mainh.isDoubleGrippable())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			if (this.Math.rand(1, 100) <= 20 && !_targetEntity.getCurrentProperties().IsImmuneToStun && !_targetEntity.getSkills().hasSkill("effects.stunned"))
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
			}
		}
	}

});

