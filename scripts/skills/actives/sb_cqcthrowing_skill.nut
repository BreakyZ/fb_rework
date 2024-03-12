this.sb_cqcthrowing_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_cqcthrowing_skill";
		this.m.Name = "Close Quarters Combat Throwing";
		this.m.Description = "[color=#135213]Active:[/color] Attacks with thrown weapons at close range. \n[color=#135213]Passive:[/color] Increases melee defense when throwing weapons are equipped. \n[color=#8f1e1e]Requires:[/color] Javelin / Throwing Axe / Throwing Spear / Staff Sling / Spiked Bolas";
		this.m.Icon = "skills/active_07.png";
		this.m.IconDisabled = "skills/active_07_sw.png";
		this.m.Overlay = "active_07";
		this.m.SoundOnUse = [
			"sounds/combat/overhead_strike_01.wav",
			"sounds/combat/overhead_strike_02.wav",
			"sounds/combat/overhead_strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/overhead_strike_hit_01.wav",
			"sounds/combat/overhead_strike_hit_02.wav",
			"sounds/combat/overhead_strike_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 221;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 44;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 11;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When passive is activated: [color=#135213]+7[/color] melee defense"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage: [color=#135213]weapon damage + (level x 3)[/color]"
		});
		local ammo = this.getAmmo();
		if (ammo > 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=#135213]" + ammo + "[/color] throwing weapons left"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=#8f1e1e]No throwing weapons left[/color]"
			});
		}
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			if (actor.getSkills().hasSkill("actives.throw_balls") || actor.getSkills().hasSkill("actives.sling_stone") ||  actor.getSkills().hasSkill("actives.throw_spear") || 
			actor.getSkills().hasSkill("actives.throw_axe") || actor.getSkills().hasSkill("actives.throw_javelin") || 
			item.getID() == "weapon.throwing_spear")
			{
				_properties.MeleeDefense += 7;
			}
		}
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);
		local mainh = _user.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (mainh != null)
		{
			if (_user.getSkills().hasSkill("actives.throw_spear"))
			{
				_user.getItems().unequip(mainh);
			}
			else
			{
				this.consumeAmmo();
			}
		}
		return this.attackEntity(_user, _targetTile.getEntity());
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
			_properties.DamageRegularMin += actor.getLevel() * 3;
			_properties.DamageRegularMax += actor.getLevel() * 3;
		}
	}

	function getAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item == null)
		{
			return 0;
		}
		return item.getAmmo();
	}

	function consumeAmmo()
	{
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			item.consumeAmmo();
		}
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}

		if (this.getAmmo() <= 0)
		{
			return false;
		}

		if (this.getContainer().hasSkill("actives.throw_axe"))
		{
			return true;
		}
		else if (this.getContainer().hasSkill("actives.throw_javelin"))
		{
			return true;
		}
		else if (this.getContainer().hasSkill("actives.throw_spear"))
		{
			return true;
		}
		else if (this.getContainer().hasSkill("actives.sling_stone"))
		{
			return true;
		}
		else if (this.getContainer().hasSkill("actives.throw_balls"))
		{
			return true;
		}

		return false;
	}

	function isHidden()
	{
		if (this.m.Container.getActor().isPlacedOnMap())
		{
			local actorsk = this.getContainer();
			if (!actorsk.hasSkill("actives.throw_axe") && !actorsk.hasSkill("actives.throw_javelin") && !actorsk.hasSkill("actives.throw_spear") && !actorsk.hasSkill("actives.sling_stone") && !actorsk.hasSkill("actives.throw_balls"))
			{
				return true;
			}
			return false;
		}
		return false;
	}

});

