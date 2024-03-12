this.sb_slander_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_slander_skill";
		this.m.Name = "Slander";
		this.m.Description = "Boosts caster morale by demeaning allies. Makes the caster\'s morale state [color=#135213]Confident[/color] and the target ally\'s morale state [color=#8f1e1e]Breaking[/color]";
		this.m.Icon = "ui/xx66.png";
		this.m.IconDisabled = "ui/xx66_sw.png";
		this.m.Overlay = "status_effect_106";
		this.m.SoundOnUse = [
			"sounds/new_round_01.wav"
		];
		this.m.SoundVolume = 2;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 4;
	}

	function getTooltip()
	{
		return this.getDefaultUtilityTooltip();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}
		if (!_targetTile.getEntity().isAlliedWith(this.getContainer().getActor()))
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.Tactical.getShaker().shake(_targetTile.getEntity(), _user.getTile(), 4);
		_user.setMoraleState(this.Const.MoraleState.Confident);
		_targetTile.getEntity().setMoraleState(this.Const.MoraleState.Breaking);
		this.spawnIcon("status_effect_107", _targetTile);
		return true;
	}

});

