this.xxhalforc_warcry_skill <- this.inherit("scripts/skills/skill", {
	m = {
		//Cooldown = 5,
		//Skillcool = 5
	},
	function create()
	{
		this.m.ID = "actives.xxhalforc_warcry_skill";
		this.m.Name = "Warcry";
		this.m.Description = "Let out a terrifying shout that negatively affects the morale nearby enemies. Additionally, bolster the morale of nearby allies.";
		this.m.Icon = "ui/xx44.png";
		this.m.IconDisabled = "ui/xx44_sw.png";
		this.m.Overlay = "xx44";
		this.m.SoundOnUse = [
			"sounds/enemies/warcry_01.wav"
		];
		this.m.SoundVolume = 1.1;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 222;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret =
		[
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Decreases the morale of enemies. The chance to trigger the effect starts when max hitpoints and target current hitpoints are equal. The chance increases by 1% per point of difference and reaches 100% when more than 100."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Bolsters the morale of nearby allies or rallies them if they are fleeing. The chance to trigger this effect is max hitpoints / 3."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Removes the Sleeping status effect of allies."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Area of effect: 2 tiles around"
			},
			//{
			//	id = 7,
			//	type = "text",
			//	icon = "ui/icons/special.png",
			//	text = "Cooldown: 5 turn"
			//}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Warcry");
		}
		
		//this.m.Skillcool = 0;
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
				if (!a.isAlive())
				{
					continue;
				}
				// terrorize enemies
				if (!a.isAlliedWith(_user))
				{
					local difficulty = 100 - _user.getHitpointsMax() + a.getHitpoints();
					this.Tactical.EventLog.log("difficulty: " + difficulty);
					a.checkMorale(-1, difficulty, this.Const.MoraleCheckType.MentalAttack);
				}
				// rally friends
				else
				{
					a.getSkills().removeByID("effects.sleeping");
					
					local difficulty = 100-_user.getHitpointsMax()/3;
					if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
					{
						a.checkMorale(this.Const.MoraleState.Wavering - this.Const.MoraleState.Fleeing, difficulty);
					}
					else
					{
						a.checkMorale(1, difficulty);
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
		//else if (this.m.Skillcool < this.m.Cooldown)
		//{
		//	return false;
		//}

		return true;
	}

	//function onTurnStart()
	//{
	//	this.m.Skillcool = this.m.Skillcool + 1;
	//}

	//function onCombatFinished()
	//{
	//	this.m.Skillcool = this.m.Cooldown;
	//}

});

