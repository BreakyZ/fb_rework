this.sb_bribe_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_bribe_skill";
		this.m.Name = "Bribe";
		this.m.Description = "Bribe the target enemy. The target who received the bribe has a chance to give up the battle or defect. \n[color=#8f1e1e]Requires:[/color] 155 Crowns";
		this.m.Icon = "ui/xx50.png";
		this.m.IconDisabled = "ui/xx50_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/taunt_01.wav",
			"sounds/combat/taunt_02.wav",
			"sounds/combat/taunt_03.wav",
			"sounds/combat/taunt_04.wav",
			"sounds/combat/taunt_05.wav"
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
		this.m.MaxRange = 3;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=#135213]70%[/color] chance of success"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "It cannot be used on beings who are not interested in money or who have high bravery"
		});
		if (this.Tactical.isActive())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Own [color=#e6b71e]" + this.World.Assets.getMoney() + "[/color] crowns"
			});
		}
		return ret;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else if (this.World.Assets.getMoney() < 155)
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local target = _targetTile.getEntity();
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}
		if (target.isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}
		if (!target.getFlags().has("human") && !target.getFlags().has("goblin"))
		{
			return false;
		}
		if (target.getSkills().hasSkill("actives.insects"))
		{
			return false;
		}
		if (target.getBaseProperties().Bravery > 71)
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local rr = 70;
		this.World.Assets.addMoney(-155);
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		if (target.getBaseProperties().Bravery > 70)
		{
			rr = 40;
		}
		if (this.Math.rand(1, 99) <= rr)
		{
			this.Tactical.spawnIconEffect("status_effect_107", _targetTile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
			target.playSound(this.Const.Sound.ActorEvent.DamageReceived, 2.2);
			if (this.Math.rand(1, 100) <= 50)
			{
				target.setFaction(this.Const.Faction.PlayerAnimals);
			}
			else
			{
				target.checkMorale(-100, -100, this.Const.MoraleCheckType.MentalAttack);
				target.checkMorale(-100, -100, this.Const.MoraleCheckType.MentalAttack);
				target.checkMorale(-100, -100, this.Const.MoraleCheckType.MentalAttack);
				target.checkMorale(-100, -100, this.Const.MoraleCheckType.MentalAttack);
				target.checkMorale(-100, -100, this.Const.MoraleCheckType.MentalAttack);
			}
		}
		return true;
	}

});

