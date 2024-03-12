this.xxfelinid_claws_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.xxfelinid_claws_skill";
		this.m.Name = "Felinid Claws";
		this.m.Description = "Felinids have sharp claws in their hands that they can use as natural weapons.";
		this.m.KilledString = "Clawed to death";
		this.m.Icon = "ui/xx78.png";
		this.m.IconDisabled = "ui/xx78.png";
		this.m.Overlay = "xx78";
		this.m.SoundOnUse = [
			"sounds/combat/slash_01.wav",
			"sounds/combat/slash_02.wav",
			"sounds/combat/slash_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/slash_hit_01.wav",
			"sounds/combat/slash_hit_02.wav",
			"sounds/combat/slash_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 50;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		//ret.push({
		//	id = 6,
		//	type = "text",
		//	icon = "ui/icons/hitchance.png",
		//	text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] chance to hit"
		//});
		return ret;
		// additionally, fist weapons deal 50% more damage
	}

	function isUsable()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (this.m.Container.hasSkill("perk.legend_ambidextrous") && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand) && this.skill.isUsable)
		{
			return true;
		}

		return (main == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}


	function isHidden()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (this.m.Container.hasSkill("perk.legend_ambidextrous") && off == null && !items.hasBlockedSlot(this.Const.ItemSlot.Offhand))
		{
			return false;
		}

		return main != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}
	
	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInFists)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInFists ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

			if (this.m.Container.hasSkill("perk.legend_ambidextrous"))
			{
				this.m.ActionPointCost = 3;
			}
		}

		if (this.m.Container.hasSkill("perk.legend_ambidextrous"))
		{
			if (this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
			{
				this.m.IsIgnoredAsAOO = true;
			}
			else
			{
				this.m.IsIgnoredAsAOO = false;
			}
		}
	}

	function onUpdate( _properties )
	{
		if (this.isUsable())
		{
			_properties.DamageRegularMin = 15;
			_properties.DamageRegularMax = 30;
			_properties.DamageArmorMult = 0.5;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		//_properties.DamageRegularMin += 5;
		//_properties.DamageRegularMax += 10;
		//_properties.DamageArmorMult = 0.5;

		//if (this.m.Container.hasSkill("effects.disarmed") || this.m.Container.hasSkill("perk.legend_ambidextrous"))
		//{
		//	local mhand = actor.getMainhandItem();
		//
		//	if (mhand != null)
		//	{
		//		_properties.DamageRegularMin -= mhand.m.RegularDamage;
		//		_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
		//	}
		//}

		_properties.FatigueDealtPerHitMult += 1.0;

		if (this.m.Container.hasSkill("perk.legend_ambidextrous"))
		{
			if (actor.getMainhandItem() != null)
			{
				_properties.MeleeDamageMult /= 1.25;
			}
		}
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

