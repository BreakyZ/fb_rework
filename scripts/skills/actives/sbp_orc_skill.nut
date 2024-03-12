this.sbp_orc_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_orc_skill";
		this.m.Name = "Orc Weaponology (passive)";
		this.m.Icon = "ui/xxp29.png";
		this.m.Description = "When using an Orc\'s melee weapon: +30 max fatigue, +5 Resolve, +3 Melee defense, +3 Ranged defense";
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
			if (item.getID() == "weapon.orc_wooden_club" || item.getID() == "weapon.orc_metal_club" || item.getID() == "weapon.orc_flail_2h" || 
			item.getID() == "weapon.orc_cleaver" || item.getID() == "weapon.orc_axe_2h" || item.getID() == "weapon.orc_axe" || 
			item.getID() == "weapon.named_orc_cleaver" || item.getID() == "weapon.named_orc_axe" || item.getID() == "weapon.xxorc_flail_two_handed")
			{
				_properties.Stamina += 30;
				_properties.Bravery += 5;
				_properties.MeleeDefense += 3;
				_properties.RangedDefense += 3;
			}
		}
	}

});

