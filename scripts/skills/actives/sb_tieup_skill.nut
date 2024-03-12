this.sb_tieup_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 3,
		Skillcool = 3
	},
	function create()
	{
		this.m.ID = "actives.sb_tieup_skill";
		this.m.Name = "Tie Up";
		this.m.Description = "Tie up the target that cannot resist with rope. Stuns the target for 2 turns and ties it in place. After level 10, stronger nets are used.";
		this.m.Icon = "ui/xx70.png";
		this.m.IconDisabled = "ui/xx70_sw.png";
		this.m.Overlay = "active_73";
		this.m.SoundOnUse = [
			"sounds/combat/throw_net_01.wav",
			"sounds/combat/throw_net_02.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/break_free_net_01.wav",
			"sounds/combat/break_free_net_02.wav",
			"sounds/combat/break_free_net_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDoingForwardMove = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 6;
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
			icon = "ui/icons/hitchance.png",
			text = "Can only be used on stunned or netted targets."
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 3 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local actor = this.getContainer().getActor();
		local target = _targetTile.getEntity();
		if (target.getSkills().hasSkill("effects.net"))
		{
			target.getSkills().removeByID("effects.net");
		}
		if (!target.getCurrentProperties().IsImmuneToRoot && !target.getCurrentProperties().IsRooted)
		{
			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, target.getPos());
			}
			target.getSkills().add(this.new("scripts/skills/effects/net_effect"));
			local breakFree = this.new("scripts/skills/actives/break_free_skill");
			breakFree.m.Icon = "skills/active_74.png";
			breakFree.m.IconDisabled = "skills/active_74_sw.png";
			breakFree.m.Overlay = "active_74";
			breakFree.m.SoundOnUse = this.m.SoundOnHit;
			if (actor.getLevel() >= 10)
			{
				breakFree.setDecal("net_destroyed_02");
				breakFree.setChanceBonus(-15);
			}
			else
			{
				breakFree.setDecal("net_destroyed");
				breakFree.setChanceBonus(0);
			}
			target.getSkills().add(breakFree);
			local effect = this.Tactical.spawnSpriteEffect("bust_net_02", this.createColor("#ffffff"), _targetTile, 0, 10, 1.0, target.getSprite("status_rooted").Scale, 100, 100, 0);
			local flip = !target.isAlliedWithPlayer();
			effect.setHorizontalFlipping(flip);
			this.Time.scheduleEvent(this.TimeUnit.Real, 200, this.onNetSpawn.bindenv(this), {
				Target = target
			});
		}
		if (target.getSkills().hasSkill("effects.stunned"))
		{
			target.getSkills().removeByID("effects.stunned");
		}
		if (!target.getCurrentProperties().IsImmuneToStun)
		{
			local stun = this.new("scripts/skills/effects/stunned_effect");
			target.getSkills().add(stun);
			stun.setTurns(2);
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " for two turns");
			}
		}
		return true;
	}

	function onNetSpawn( _data )
	{
		local rooted = _data.Target.getSprite("status_rooted");
		rooted.setBrush("bust_net_02");
		rooted.Visible = true;
		local rooted_back = _data.Target.getSprite("status_rooted_back");
		rooted_back.setBrush("bust_net_back_02");
		rooted_back.Visible = true;
		_data.Target.setDirty(true);
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local targetsk = _targetTile.getEntity().getSkills();
		if (targetsk.hasSkill("effects.stunned") || targetsk.hasSkill("effects.net"))
		{
			return true;
		}

		return false;
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

