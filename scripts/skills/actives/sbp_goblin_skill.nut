this.sbp_goblin_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_goblin_skill";
		this.m.Name = "Goblin Weaponology (passive)";
		this.m.Icon = "ui/xxp2.png";
		this.m.Description = "When using the Goblin\'s named weapon: +30 Damage, +10 Resolve, +5 Melee defense, +5 Ranged defense";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsSerialized = true;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null)
		{
			if (item.getID() == "weapon.named_goblin_falchion" || item.getID() == "weapon.named_goblin_heavy_bow" || item.getID() == "weapon.named_goblin_pike" || item.getID() == "weapon.named_goblin_spear")
			{
				_properties.DamageRegularMin += 30;
				_properties.DamageRegularMax += 30;
				_properties.Bravery += 10;
				_properties.MeleeDefense += 5;
				_properties.RangedDefense += 5;
			}
		}
	}

});

