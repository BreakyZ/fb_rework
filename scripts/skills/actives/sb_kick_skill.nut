this.sb_kick_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 1,
		Skillcool = 1
	},
	function create()
	{
		this.m.ID = "actives.sb_kick_skill";
		this.m.Name = "Kick";
		this.m.Description = "Attacks the enemy with a kick. This attack hit chance is always fixed at 60%. Duelist perks are partially applied. Can hit the head.";
		this.m.Icon = "ui/xx35.png";
		this.m.IconDisabled = "ui/xx35_sw.png";
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
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.IsUsingHitchance = false;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 1 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
		if (this.Math.rand(1, 99) <= 60)
		{
			this.attackEntity(_user, _targetTile.getEntity());
		}
		else
		{
			this.Tactical.getShaker().shake(_targetTile.getEntity(), _user.getTile(), 4);
		}
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			_properties.DamageRegularMin = 10;
			_properties.DamageRegularMax = 50;
			_properties.DamageArmorMult = 0.8;
			if (actor.getSkills().hasSkill("perk.duelist"))
			{
				if (offh == null || offh.isItemType(this.Const.Items.ItemType.Tool))
				{
					_properties.DamageDirectAdd -= 0.1;
				}
			}
			if (mainh != null && offh == null && mainh.isDoubleGrippable())
			{
				_properties.DamageTotalMult /= 1.25;
			}
		}
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else if (this.m.Skillcool < this.m.Cooldown)
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

