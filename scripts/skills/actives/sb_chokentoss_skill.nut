this.sb_chokentoss_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 5,
		Skillcool = 5
	},
	function create()
	{
		this.m.ID = "actives.sb_chokentoss_skill";
		this.m.Name = "Choke and Toss (Choke)";
		this.m.Description = "Chokes the target to sleep and enables the Toss skill. The Toss skill can only be used on this skill target";
		this.m.Icon = "ui/xx45.png";
		this.m.IconDisabled = "ui/xx45_sw.png";
		this.m.Overlay = "active_116";
		this.m.SoundOnUse = [
			"sounds/vomit_01.wav"
		];
		this.m.SoundVolume = 1.8;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cannot be used if target is rooted, immune to knockback or immune to stun"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown : 5 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}
	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}
		local target = _targetTile.getEntity();
		if (target.getCurrentProperties().IsRooted)
		{
			return false;
		}
		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}
		if (target.getCurrentProperties().IsImmuneToStun)
		{
			return false;
		}
		if (target.isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		this.m.Container.add(this.new("scripts/skills/actives/sb2_chokentoss_skill"));
		local target = _targetTile.getEntity();
		target.getSkills().add(this.new("scripts/skills/effects/sb_chokentoss_effect"));
		this.Tactical.getShaker().shake(target, _user.getTile(), 4);
		if (target.isAlive() && !target.getCurrentProperties().IsStunned)
		{
			local skilla = this.new("scripts/skills/effects/sleeping_effect");
			skilla.m.SoundOnUse = [
				"sounds/humans/5/human_flee_02.wav"
			];
			target.getSkills().add(skilla);
			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " falls to sleep");
			}
		}
		return true;
	}

	function isHidden()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("actives.sb2_chokentoss_skill"))
		{
			return false;
		}
		return true;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
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

