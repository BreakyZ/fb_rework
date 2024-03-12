this.sb_sguard_effect_caster <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.shieldwall";
		this.m.Name = "Shield Guard (guarding)";
		this.m.Description = "This character is using a shield guard.";
		this.m.Icon = "skills/status_effect_03.png";
		this.m.IconMini = "status_effect_03_mini";
		this.m.Overlay = "status_effect_03";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		return [
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
				id = 5,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "-99% reduced damage taken"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= 0.11;
		_properties.TargetAttractionMult *= 0.5;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onRemoved()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
		{
			item.onShieldDown();
		}
	}

	function onAdded()
	{
		local item = this.m.Container.getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (item != null && item.isItemType(this.Const.Items.ItemType.Shield))
		{
			item.onShieldUp();
		}
	}

});

