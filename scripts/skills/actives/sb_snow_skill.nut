this.sb_snow_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_snow_skill";
		this.m.Name = "Double Edge";
		this.m.Description = "Attack the target (25% chance), or attack self (25% chance), or both (50% chance). \n[color=#8f1e1e]Requires:[/color] Melee Weapon";
		this.m.Icon = "ui/xx76.png";
		this.m.IconDisabled = "ui/xx76_sw.png";
		this.m.Overlay = "active_07";
		this.m.SoundOnUse = [
			"sounds/combat/bash_01.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/bash_hit_01.wav"
		];
		this.m.SoundVolume = 1.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.IsUsingHitchance = false;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 100;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 0;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This skill costs half the AP cost and fatigue cost of the weapon's main skill."
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		if (this.Math.rand(1, 100) <= 50)
		{
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
			this.attackEntity(_user, target, false);
			this.spawnAttackEffect(_user.getTile(), this.Const.Tactical.AttackEffectSlash);
			return this.attackEntity(_user, _user, false);
		}
		else
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				this.spawnAttackEffect(_user.getTile(), this.Const.Tactical.AttackEffectSlash);
				return this.attackEntity(_user, _user, false);
			}
			else
			{
				this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
				return this.attackEntity(_user, target, false);
			}
		}
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
		}
	}

	function onAfterUpdate( _properties )
	{
		local skills = this.getContainer().getActor().getSkills().getAllSkillsOfType(this.Const.SkillType.Active);
		if (skills[0].m.IsWeaponSkill && skills[0].getID() != this.getID())
		{
			this.m.ActionPointCost = this.Math.maxf(skills[0].m.ActionPointCost / 2, 1);
			this.m.FatigueCost = this.Math.maxf(skills[0].m.FatigueCost / 2 * skills[0].m.FatigueCostMult, 1);
			this.m.MinRange = skills[0].m.MinRange;
			this.m.MaxRange = skills[0].m.MaxRange;
			this.m.SoundOnUse = skills[0].m.SoundOnUse;
			this.m.SoundOnHit = skills[0].m.SoundOnHit;
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

