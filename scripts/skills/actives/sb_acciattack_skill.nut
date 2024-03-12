this.sb_acciattack_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_acciattack_skill";
		this.m.Name = "Accidental Attack";
		this.m.Description = "Attack the target with melee weapon. Hit chance is reversed so the attack must miss to deal damage. Less damage than usual. \n[color=#8f1e1e]Requires:[/color] Melee Weapon";
		this.m.Icon = "ui/xx69.png";
		this.m.IconDisabled = "ui/xx69_sw.png";
		this.m.Overlay = "active_rand";
		this.m.SoundOnUse = [
			"sounds/combat/bash_01.wav",
			"sounds/combat/bash_02.wav",
			"sounds/combat/bash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bash_hit_01.wav",
			"sounds/combat/bash_hit_02.wav",
			"sounds/combat/bash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = this.Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The cost of this skill depends on the AP cost and fatigue cost of the weapon\'s main skill."
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		if (this.Math.rand(1, 100) <= this.getHitchance(target))
		{
			_user.getCurrentProperties().DamageTotalMult = 0;
			_user.getCurrentProperties().MeleeSkill += -500;
			this.attackEntity(_user, target, false);
			return false;
		}
		_user.getCurrentProperties().MeleeSkill += 500;
		return this.attackEntity(_user, target, false);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (mainh != null && mainh.isItemType(this.Const.Items.ItemType.MeleeWeapon))
			{
				this.m.DirectDamageMult = mainh.m.DirectDamageMult;
			}
			_properties.DamageTotalMult *= 0.9;
		}
	}

	function onAfterUpdate( _properties )
	{
		local skills = this.getContainer().getActor().getSkills().getAllSkillsOfType(this.Const.SkillType.Active);
		if (skills[0].m.IsWeaponSkill && skills[0].getID() != this.getID())
		{
			this.m.ActionPointCost = skills[0].m.ActionPointCost;
			this.m.FatigueCost = skills[0].m.FatigueCost + 5 * skills[0].m.FatigueCostMult;
			this.m.MinRange = skills[0].m.MinRange;
			this.m.MaxRange = skills[0].m.MaxRange;
		}
	}

	function isHidden()
	{
		if (this.m.Container.getActor().isPlacedOnMap())
		{
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			if (mainh != null && mainh.isItemType(this.Const.Items.ItemType.MeleeWeapon))
			{
				return false;
			}
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
		local actor = this.getContainer().getActor();
		local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (mainh != null && mainh.isItemType(this.Const.Items.ItemType.MeleeWeapon))
		{
			return true;
		}
		return false;
	}

});

