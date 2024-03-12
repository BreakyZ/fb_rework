this.sb_moneysteal_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Skillcharge = 1
	},
	function create()
	{
		this.m.ID = "actives.sb_moneysteal_skill";
		this.m.Name = "Stealing";
		this.m.Description = "Steals crowns from target. The stronger the enemy, the more crowns you have a chance to give away. Can only be used against humans and goblins";
		this.m.Icon = "ui/xx24.png";
		this.m.IconDisabled = "ui/xx24_sw.png";
		this.m.SoundOnUse = [
			"sounds/coins_01.wav",
			"sounds/coins_02.wav",
			"sounds/coins_03.wav"
		];
		this.m.SoundVolume = 2.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can only be used against humans and goblins. Cannot use on previously stolen targets."
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can be used [color=#8f1e1e]" + this.m.Skillcharge + "[/color] more times in this battle."
		});
		return ret;
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
		if (target.getFlags().has("nomoney_target"))
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcharge = this.m.Skillcharge - 1;
		local target = _targetTile.getEntity();
		local rr = this.Math.rand(0, target.getXPValue() * 0.3);
		if (this.Math.rand(1, 100) <= 30)
		{
			rr = 0;
		}
		target.getFlags().add("nomoney_target");
		this.World.Assets.addMoney(rr);
		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " stole " + rr + " crowns");
		}
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		this.Tactical.getShaker().shake(target, _user.getTile(), 4);
		return true;
	}

	function isHidden()
	{
		if (this.m.Skillcharge > 0)
		{
			return false;
		}

		return true;
	}

	function onCombatFinished()
	{
		this.m.Skillcharge = 1;
	}

});

