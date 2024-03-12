this.sb_frenzy_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Skillcharge = 2
	},
	function create()
	{
		this.m.ID = "actives.sb_frenzy_skill";
		this.m.Name = "Wicked Frenzy";
		this.m.Description = "Strengthens self or allies with wicked magic. When attacking an enemy within 1 tile, damage increases by [color=#135213]+25%[/color], but melee skill, ranged skill, melee defense, and ranged defense are reduced by [color=#8f1e1e]-10[/color]. This effect lasts until the end of the battle.";
		this.m.Icon = "ui/xx73.png";
		this.m.IconDisabled = "ui/xx73_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		this.m.SoundVolume = 1.2;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 5;
		this.m.MinRange = 0;
		this.m.MaxRange = 2;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can be used [color=#8f1e1e]" + this.m.Skillcharge + "[/color] more times in this battle."
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
		this.m.Skillcharge = this.m.Skillcharge - 1
		_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/sb_frenzy_effect"));
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
		this.m.Skillcharge = 2;
	}

});

