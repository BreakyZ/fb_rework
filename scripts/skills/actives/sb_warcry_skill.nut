this.sb_warcry_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 7,
		Skillcool = 7
	},
	function create()
	{
		this.m.ID = "actives.sb_warcry_skill";
		this.m.Name = "Warcry";
		this.m.Description = "Let out a terrifying roar that negatively affects nearby enemies.";
		this.m.Icon = "ui/xx44.png";
		this.m.IconDisabled = "ui/xx44_sw.png";
		this.m.Overlay = "active_49";
		this.m.SoundOnUse = [
			"sounds/enemies/warcry_01.wav"
		];
		this.m.SoundVolume = 1.1;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 222;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Decreases the morale of nearby enemies and inflicts negative debuffs."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Area of effect: 2 tiles around"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 7 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getAllInstances();
		this.Tactical.spawnSpriteEffect("effect_skull_03", this.createColor("#ffffff"), myTile, 0, 20, 0.5, 1.2, 2, 400, 300);
		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.getID() == _user.getID())
				{
					continue;
				}
				if (myTile.getDistanceTo(a.getTile()) > 2)
				{
					continue;
				}
				if (!a.isAlliedWith(_user) && a.isAlive())
				{
					a.checkMorale(-1, 0, this.Const.MoraleCheckType.MentalAttack);
					if (this.Math.rand(1, 100) <= 50 && !a.getCurrentProperties().IsImmuneToDaze)
					{
						a.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
					}
					else
					if (this.Math.rand(1, 100) <= 50)
					{
						a.getSkills().add(this.new("scripts/skills/effects/distracted_effect"));
					}
					else
					{
						a.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
					}
				}
			}
		}
		return true;
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

