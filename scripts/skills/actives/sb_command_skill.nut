this.sb_command_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_command_skill";
		this.m.Name = "Battle Command";
		this.m.Description = "Give tactical orders to all allies to prepare for enemy attacks.";
		this.m.Icon = "ui/xx33.png";
		this.m.IconDisabled = "ui/xx33_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/inspire_01.wav",
			"sounds/combat/inspire_02.wav"
		];
		this.m.SoundVolume = 1.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 229;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 30;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Command all allies to use Shield Wall, Spear Wall, and Riposte"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID())
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 1, function ( _skill )
			{
				foreach( a in actors )
				{
					if (a.getID() == _user.getID())
					{
						continue;
					}
					if (a.getSkills().hasSkill("actives.riposte") && !a.getSkills().hasSkill("effects.riposte"))
					{
						a.getSkills().add(this.new("scripts/skills/effects/riposte_effect"));
					}
					if (a.getSkills().hasSkill("actives.spearwall") && !a.getSkills().hasSkill("effects.spearwall"))
					{
						a.getSkills().add(this.new("scripts/skills/effects/spearwall_effect"));
					}
				}
			}.bindenv(this), this);

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, function ( _skill )
			{
				foreach( a in actors )
				{
					if (a.getID() == _user.getID())
					{
						continue;
					}
					if (a.getSkills().hasSkill("actives.shieldwall") && !a.getSkills().hasSkill("effects.shieldwall"))
					{
						a.getSkills().add(this.new("scripts/skills/effects/shieldwall_effect"));
					}
				}
			}.bindenv(this), this);
		}

		return true;
	}

});

