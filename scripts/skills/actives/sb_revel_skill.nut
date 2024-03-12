this.sb_revel_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 5,
		Skillcool = 5
	},
	function create()
	{
		this.m.ID = "actives.sb_revel_skill";
		this.m.Name = "Revel";
		this.m.Description = "Drinking alcohol by the target increases morale to the maximum and decreases fatigue by 35. The target becomes drunk. Can be used on self or allies.";
		this.m.Icon = "ui/xx59.png";
		this.m.IconDisabled = "ui/xx59_sw.png";
		this.m.Overlay = "morale_up";
		this.m.SoundOnUse = [
			"sounds/tavern_round_01.wav"
		];
		this.m.SoundVolume = 3;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 1;
		this.m.MinRange = 0;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Removes hangover debuff."
		});
		ret.push({
			id = 5,
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

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local target = _targetTile.getEntity();
		if (!target.getSkills().hasSkill("effects.drunk"))
		{
			target.getSkills().add(this.new("scripts/skills/effects_world/drunk_effect"));
		}
		if (target.getSkills().hasSkill("effects.hangover"))
		{
			target.getSkills().removeByID("effects.hangover");
		}
		target.setFatigue(this.Math.max(0, target.getFatigue() - 35));
		target.setMoraleState(this.Const.MoraleState.Confident);
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

