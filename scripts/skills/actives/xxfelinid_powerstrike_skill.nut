this.xxbakubb_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.xxbakubb_skill";
		this.m.Name = "Devastating Blow";
		this.m.Description = "Use a powerful strike with a melee weapon. It puts a lot of strain on the weapon.";
		this.m.Icon = "ui/xx37.png";
		this.m.IconDisabled = "ui/xx37_sw.png";
		this.m.Overlay = "active_06";
		this.m.SoundOnUse = [
			"sounds/combat/smash_01.wav",
			"sounds/combat/smash_02.wav",
			"sounds/combat/smash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav",
			"sounds/combat/smash_hit_02.wav",
			"sounds/combat/smash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 222;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 55;
		this.m.ChanceSmash = 44;
		this.m.ChanceDisembowel = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Two-Handed Melee Weapon: [color=" + this.Const.UI.Color.PositiveValue + "]+300%[/color] Damage, \nOne-Handed Melee Weapon: [color=" + this.Const.UI.Color.PositiveValue + "]+500%[/color] Damage"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "50% chance to disarm the target on hit."
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]WARNING:[/color] Uses 30% of max weapon durability. Cannot be used if current durability is 10 or less."
		});
		return ret;
	}

	function isHidden()
	{
		local mainh = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (mainh == null)
		{
			return true;
		}
		if (mainh.isItemType(this.Const.Items.ItemType.MeleeWeapon))
		{
			return false;
		}
		return true;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		local mainh = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (mainh == null)
		{
			return false;
		}
		if (mainh.m.Condition <= 10)
		{
			return false;
		}
		return true;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local success = this.attackEntity(_user, target);
		local mainh = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local qq = mainh.m.Condition - (mainh.m.ConditionMax * 0.3);
		if (qq <= 1)
		{
			mainh.m.Condition = 1;
		}
		else
		{
			mainh.m.Condition = qq;
		}
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor && target.isAlive())
		{
			if (this.Math.rand(1, 100) <= 50 && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsImmuneToDisarm)
			{
				target.getSkills().add(this.new("scripts/skills/effects/disarmed_effect"));
				this.Sound.play("sounds/combat/weapon_break_01.wav", this.Const.Sound.Volume.Skill * 1.5, this.getContainer().getActor().getPos());
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has disarmed " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
				}
			}
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local mainh = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (_skill == this && mainh.isItemType(this.Const.Items.ItemType.MeleeWeapon))
		{
			this.m.DirectDamageMult = mainh.m.DirectDamageMult;
			if (mainh.isItemType(this.Const.Items.ItemType.TwoHanded))
			{
				_properties.MeleeDamageMult *= 3.0;
			}
			else
			if (mainh.isItemType(this.Const.Items.ItemType.OneHanded))
			{
				_properties.MeleeDamageMult *= 5.0;
			}
		}
	}

});

