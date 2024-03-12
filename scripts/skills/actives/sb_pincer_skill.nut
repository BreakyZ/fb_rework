this.sb_pincer_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_pincer_skill";
		this.m.Name = "Pincer Thrust";
		this.m.Description = "Attack the target along with any allies with spears within 2 tile of the target. Melee hit chance. \n[color=#8f1e1e]Requires:[/color] Spear";
		this.m.Icon = "ui/xx62.png";
		this.m.IconDisabled = "ui/xx62_sw.png";
		this.m.SoundOnUse = [
			"sounds/combat/thrust_01.wav",
			"sounds/combat/thrust_02.wav",
			"sounds/combat/thrust_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/thrust_hit_01.wav",
			"sounds/combat/thrust_hit_02.wav",
			"sounds/combat/thrust_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 227;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "All allies with a spear within 2 tile of the target also participate in the attack, dealing +20 additional damage per ally. (max +140)"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Two-handed weapons deal half weapon damage."
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());
		local target = _targetTile.getEntity();
		local flip;
		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}
			if (_targetTile.getDistanceTo(a.getTile()) > 2)
			{
				continue;
			}
			if (!a.getSkills().hasSkill("actives.thrust") && !a.getSkills().hasSkill("actives.prong"))
			{
				continue;
			}
			if (a.getFaction() == _user.getFaction())
			{
				flip = !this.m.IsProjectileRotated && target.getPos().X > a.getPos().X;
				this.Tactical.spawnProjectileEffect("effect_impale_N", a.getTile(), _targetTile, 2, 1.1, true, flip);
				this.Tactical.spawnProjectileEffect("effect_impale_N", a.getTile(), _targetTile, 2, 1.5, true, flip);
			}
		}
		flip = !this.m.IsProjectileRotated && target.getPos().X > _user.getPos().X;
		this.Tactical.spawnProjectileEffect("effect_impale_N", myTile, _targetTile, 2, 1.1, true, flip);
		this.Tactical.spawnProjectileEffect("effect_impale_N", myTile, _targetTile, 2, 1.5, true, flip);
		return this.attackEntity(_user, target, false);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local rr = 0;
			if (_targetEntity != null && actor.isPlacedOnMap())
			{
				local actors = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
				foreach( a in actors )
				{
					if (a.getID() == actor.getID())
					{
						continue;
					}
					if (_targetEntity.getTile().getDistanceTo(a.getTile()) > 2)
					{
						continue;
					}
					if (!a.getSkills().hasSkill("actives.thrust") && !a.getSkills().hasSkill("actives.prong"))
					{
						continue;
					}
					if (a.getFaction() == actor.getFaction())
					{
						rr = rr + 20;
					}
				}
			}
			if (mainh != null && mainh.isItemType(this.Const.Items.ItemType.MeleeWeapon))
			{
				this.m.DirectDamageMult = mainh.m.DirectDamageMult;
				if (mainh.isItemType(this.Const.Items.ItemType.TwoHanded))
				{
					_properties.MeleeDamageMult *= 0.5;
				}
			}
			_properties.DamageRegularMin += this.Math.min(rr, 140);
			_properties.DamageRegularMax += this.Math.min(rr, 140);
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSpears ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function isHidden()
	{
		if (this.m.Container.getActor().isPlacedOnMap() && !this.getContainer().hasSkill("actives.thrust") && !this.getContainer().hasSkill("actives.prong"))
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
		else if (this.getContainer().hasSkill("actives.thrust"))
		{
			return true;
		}
		else if (this.getContainer().hasSkill("actives.prong"))
		{
			return true;
		}

		return false;
	}

});

