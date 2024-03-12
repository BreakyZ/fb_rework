this.sb_strike_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Skilltime = 0
	},
	function create()
	{
		this.m.ID = "actives.ai_punch";
		this.m.Name = "Martial Strike";
		this.m.Description = "Attacks the target with a martial strike. \n[color=#8f1e1e]Requires:[/color] Unarmed";
		this.m.Icon = "ui/xx68.png";
		this.m.IconDisabled = "ui/xx68_sw.png";
		this.m.Overlay = "active_08";
		this.m.SoundOnUse = [
			"sounds/combat/shatter_01.wav",
			"sounds/combat/shatter_02.wav",
			"sounds/combat/shatter_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/overhead_strike_hit_01.wav",
			"sounds/combat/overhead_strike_hit_02.wav",
			"sounds/combat/overhead_strike_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted - 100;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 2;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 10;
		this.m.ChanceDisembowel = 10;
		this.m.ChanceSmash = 50;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=#8f1e1e]-10%[/color] chance to hit"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Every 10 uses, 3x strike. (Used [color=#8f1e1e]" + this.m.Skilltime + "[/color] times)"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "+10 Damage after Level 10"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Off-Hand slot empty : +20 Damage \nHead slot empty: +25 Damage \nBody slot empty: +25 Damage \nwas \'Brawler\': +10 Damage"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skilltime = this.m.Skilltime + 1;
		local actor = this.getContainer().getActor();
		local target = _targetTile.getEntity();
		if (this.m.Skilltime >= 10 && actor.getFaction() == this.Const.Faction.Player)
		{
			this.m.Skilltime = 0;
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
			this.Sound.play("sounds/combat/hand_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Skill * 1, actor.getPos());
			if (target.m.IsShakingOnHit)
			{
				this.Tactical.getShaker().shake(target, _targetTile, 1);
			}
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 100, function ( _skill )
			{
				if (target.isAlive())
				{
					_skill.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
					_skill.attackEntity(_user, target);
				}
			}.bindenv(this), this);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, function ( _skill )
			{
				if (target.isAlive())
				{
					_skill.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
					_skill.attackEntity(_user, target);
				}
			}.bindenv(this), this);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, function ( _skill )
			{
				if (target.isAlive())
				{
					_skill.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);
					_skill.attackEntity(_user, target);
				}
				_skill.m.IsDoingAttackMove = true;
				_skill.getContainer().setBusy(false);
			}.bindenv(this), this);
			return true;
		}
		else
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
			this.attackEntity(actor, target);
		}
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local offh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local rr = 0;
			if (offh == null)
			{
				rr += 20;
			}
			if (head == null)
			{
				rr += 25;
			}
			if (body == null)
			{
				rr += 25;
			}
			if (actor.getLevel() >= 10)
			{
				rr += 10;
			}
			if (actor.getBackground().getID() == "background.brawler" )
			{
				rr += 10;
			}
			_properties.DamageRegularMin = 10 + rr;
			_properties.DamageRegularMax = 20 + rr;
			if (actor.getSkills().hasSkill("perk.duelist"))
			{
				if (offh == null || offh.isItemType(this.Const.Items.ItemType.Tool))
				{
					_properties.DamageDirectAdd -= 0.1;
				}
			}
			_properties.DamageArmorMult = 0.9;
			_properties.MeleeSkill -= 10;
		}
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		return (mainhand == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function isHidden()
	{
		if (this.m.Container.getActor().isPlacedOnMap())
		{
			local mainhand = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			return mainhand != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden();
		}
		return false;
	}

	function onCombatFinished()
	{
		this.m.Skilltime = 0;
	}

	function onAdded()
	{
		if (this.m.Container.hasSkill("actives.hand_to_hand"))
		{
			this.m.Container.removeByID("actives.hand_to_hand");
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasSkill("actives.hand_to_hand"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/hand_to_hand"));
		}
	}

});

