this.sb_warcrime_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Skillcharge = 1
	},
	function create()
	{
		this.m.ID = "actives.sb_warcrime_skill";
		this.m.Name = "War Crime";
		this.m.Description = "Inflict a horrific, unforgivable, inhumane act on a target with very low health. The target dies instantly. Can be used on both allies and enemies.";
		this.m.Icon = "ui/xx51.png";
		this.m.IconDisabled = "ui/xx51_sw.png";
		this.m.SoundOnHit = [
			"sounds/combat/pound_hit_01.wav",
			"sounds/combat/pound_hit_02.wav",
			"sounds/combat/pound_hit_03.wav",
			"sounds/combat/smash_hit_01.wav",
			"sounds/combat/smash_hit_02.wav",
			"sounds/combat/smash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 1;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.IsUsingHitchance = false;
		this.m.ChanceDecapitate = 10;
		this.m.ChanceDisembowel = 80;
		this.m.ChanceSmash = 10;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Gained Effect: Max Mood, Max Morale, Killing Frenzy, Adrenaline, 50% Less Current Fatigue"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Background was \'Raider\' / \'Barbarian\' / \'Killer\': +1 Melee Skill"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can be used [color=#8f1e1e]" + this.m.Skillcharge + "[/color] more times in this battle."
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (_targetTile.IsEmpty || !_targetTile.getEntity().isAttackable() || !_targetTile.getEntity().isAlive() || _targetTile.getEntity().isDying())
		{
			return false;
		}
		if (_targetTile.getEntity().getHitpoints() > 50)
		{
			return false;
		}
		if (_targetTile.getEntity().getHitpointsPct() > 0.25)
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
		else if (this.m.Skillcharge <= 0)
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcharge = this.m.Skillcharge - 1
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local helmet = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local target = _targetTile.getEntity();
		local actorsk = actor.getSkills();
		local xxap = actor.getActionPoints();
		actor.setActionPoints(0);
		if (actorsk.hasSkill("background.raider") || actorsk.hasSkill("background.barbarian") || actorsk.hasSkill("background.killer_on_the_run"))
		{
			actor.getBaseProperties().MeleeSkill += 1;
		}
		if (helmet != null && actor.getSprite("head").Visible)
		{
			actor.getSprite("helmet").Visible = false;
		}
		actor.getSprite("armor").Visible = false;
		actor.getSprite("arms_icon").Visible = false;
		actor.getSprite("shield_icon").Visible = false;
		actor.addSprite("dirty_injury_wcrime1").setBrush("bust_slime");
		actor.getSprite("dirty_injury_wcrime1").Visible = true;
		actor.getSprite("dirty_injury_wcrime1").Color = this.createColor("#ffffb3");
		actor.getSprite("dirty_injury_wcrime1").Alpha = 155;
		target.addSprite("dirty_injury_wcrime1").setBrush("bust_slime");
		target.getSprite("dirty_injury_wcrime1").setHorizontalFlipping(true);
		target.getSprite("dirty_injury_wcrime1").Visible = true;
		target.getSprite("dirty_injury_wcrime1").Alpha = 222;
		target.getSprite("dirty_injury_wcrime1").Saturation = 0.1;
		if (!actor.getSkills().hasSkill("effects.killing_frenzy"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/killing_frenzy_effect"));
		}
		if (!actor.getSkills().hasSkill("effects.indomitable"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/indomitable_effect"));
		}
		if (!actor.getSkills().hasSkill("effects.adrenaline"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/adrenaline_effect"));
		}
		this.Sound.play("sounds/humans/0/human_flee_06.wav", this.Const.Sound.Volume.Skill * 1.7, actor.getPos());
		this.Sound.play("sounds/humans/5/human_fatigue_01.wav", this.Const.Sound.Volume.Skill * 1.5, actor.getPos());
		this.Tactical.getShaker().shake(target, myTile, 4, this.Const.Combat.ShakeEffectHitpointsHitColor, this.Const.Combat.ShakeEffectHitpointsHitHighlight, this.Const.Combat.ShakeEffectHitpointsHitFactor, this.Const.Combat.ShakeEffectHitpointsSaturation, this.Const.ShakeCharacterLayers[this.Const.BodyPart.All], 5.0);
		actor.playSound(this.Const.Sound.ActorEvent.Death, 2);
		target.playSound(this.Const.Sound.ActorEvent.Death, 2);
		actor.setMoraleState(this.Const.MoraleState.Confident);
		actor.improveMood(10.0, "Life is good");
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 600, function ( _skill )
		{
			actor.playSound(this.Const.Sound.ActorEvent.Death, 1);
			target.playSound(this.Const.Sound.ActorEvent.Death, 1);
			this.Tactical.getShaker().shake(target, myTile, 1, this.Const.Combat.ShakeEffectHitpointsHitColor, this.Const.Combat.ShakeEffectHitpointsHitHighlight, this.Const.Combat.ShakeEffectHitpointsHitFactor, this.Const.Combat.ShakeEffectHitpointsSaturation, this.Const.ShakeCharacterLayers[this.Const.BodyPart.All], 5.0);
		}.bindenv(this), this);
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1200, function ( _skill )
		{
			actor.setActionPoints(xxap);
			actor.setFatigue(actor.getFatigue() / 2)
			if (actor.hasSprite("dirty_injury_wcrime1"))
			{
				actor.getSprite("dirty_injury_wcrime1").Visible = false;
				actor.removeSprite("dirty_injury_wcrime1");
			}
			if (target.hasSprite("dirty_injury_wcrime1"))
			{
				target.getSprite("dirty_injury_wcrime1").Visible = false;
				target.removeSprite("dirty_injury_wcrime1");
			}
			actor.getSprite("helmet").Visible = true;
			actor.getSprite("armor").Visible = true;
			actor.getSprite("arms_icon").Visible = true;
			actor.getSprite("shield_icon").Visible = true;
			actor.getItems().updateAppearance();
			local slime = _user.getSprite("dirt");
			slime.setBrush("bust_body_bloodied_02");
			slime.Visible = true;
			_skill.attackEntity(_user, target);
			this.Sound.play("sounds/combat/taunt_0" + this.Math.rand(2, 3) + ".wav", this.Const.Sound.Volume.Skill * 3, actor.getPos());
			myTile.clear(this.Const.Tactical.DetailFlag.Scorchmark);
			myTile.spawnDetail("detail_vomit", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
		}.bindenv(this), this);
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = 9998;
			_properties.DamageRegularMax = 9999;
		}
	}

	function onCombatFinished()
	{
		this.m.Skillcharge = 1;
	}

});

