this.sb_snake_target_effect <- this.inherit("scripts/skills/skill", {
	m = {
		LastRoundApplied = 0,
		OnRemoveCallback = null,
		OnRemoveCallbackData = null
	},
	function setOnRemoveCallback( _c, _d )
	{
		this.m.OnRemoveCallback = _c;
		this.m.OnRemoveCallbackData = _d;
	}

	function create()
	{
		this.m.ID = "effects.net";
		this.m.Name = "Entangled";
		this.m.Description = "This character is entangled. Each turn, loss of [color=" + this.Const.UI.Color.NegativeValue + "]10 ~ 15[/color] hitpoints. (This damage permanently cripples enemies instead of killing them)";
		this.m.Icon = "skills/status_effect_113.png";
		this.m.IconMini = "status_effect_113_mini";
		this.m.Overlay = "status_effect_113";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Unable to move[/color]"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Melee and Ranged Defense"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]When attacking an enemy, hit chance decreases by -70%[/color]"
			}
		];
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local target = this.getContainer().getActor();
			if (target.getCurrentProperties().DamageReceivedTotalMult > 0)
			{
				local dmg = this.Math.rand(10, 15);
				local hitInfo = clone this.Const.Tactical.HitInfo;
				this.spawnIcon("status_effect_113", target.getTile());
				if (target.getHitpoints() <= dmg)
				{
					target.getSkills().removeByID("effects.net");
					this.onRemoved();
					target.getSkills().add(this.new("scripts/skills/effects/ai_stun_effect"));
					target.getSkills().add(this.new("scripts/skills/effects/ai_mortalwound_effect"));
				}
				hitInfo.DamageRegular = 0.00001;
				hitInfo.DamageDirect = 1.0;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;
				target.onDamageReceived(target, null, hitInfo);
				target.setHitpoints(this.Math.max(target.getHitpoints() - dmg, 1));
			}
		}
	}

	function onAdded()
	{
		this.Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		local rooted = actor.getSprite("status_rooted");
		local rooted_back = actor.getSprite("status_rooted_back");
		if (this.m.OnRemoveCallback != null && !this.Tactical.Entities.isCombatFinished())
		{
			this.m.OnRemoveCallback(this.m.OnRemoveCallbackData);
		}
		else
		{
			rooted.Scale = 0.55;
			rooted.setBrush("");
			rooted.Visible = false;
			rooted_back.Scale = 0.55;
			rooted_back.setBrush("");
			rooted_back.Visible = false;
		}
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1, function ( _skill )
		{
			actor.getSkills().removeByID("actives.break_free");
		}.bindenv(this), this);
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 0.5;
		_properties.RangedDefenseMult *= 0.5;
		_properties.InitiativeForTurnOrderAdditional = -100;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() != this.getContainer().getActor().getFaction())
		{
			_properties.MeleeSkillMult *= 0.3;
			_properties.RangedSkillMult *= 0.3;
		}
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});

