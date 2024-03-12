this.xxfelinid_roar_skill <- this.inherit("scripts/skills/skill", {
	m = {
		//Cooldown = 5,
		//Skillcool = 5
	},
	function create()
	{
		this.m.ID = "actives.xxfelinid_roar_skill";
		this.m.Name = "Roar";
		this.m.Description = "Let out a terrifying roar that weakens and negatively affects the morale nearby enemies.";
		this.m.Icon = "ui/xx77.png";
		this.m.IconDisabled = "ui/xx77_sw.png";
		this.m.Overlay = "xx77";
		this.m.SoundOnUse = [
			"sounds/combat/roar.wav"
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
				text = "Decreases the defenses of enemies by 15% for one turn. The chance to trigger the effect is equal to the resolve skill."
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Decreases the morale of enemies. The chance to trigger the effect is your resolve - the target resolve."
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
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " uses Roar");
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
					local difficulty = 100 - _user.getBravery() + a.getBravery();
					this.Tactical.EventLog.log("difficulty: " + difficulty);
					a.checkMorale(-1, difficulty, this.Const.MoraleCheckType.MentalAttack);
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

