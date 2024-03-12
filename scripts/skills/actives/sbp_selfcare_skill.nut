this.sbp_selfcare_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_selfcare_skill";
		this.m.Name = "Self Care (passive)";
		this.m.Icon = "ui/xxp1.png";
		this.m.Description = "Veteran warriors take care of themselves in their non-combat time, tending to their wounds, repairing their gear, and preparing for the next battle.";
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
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "At the end of battle: Fully recover Armor, Helm, HP"
		});
		return ret;
	}

	function onCombatFinished()
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return false;
		}

		local actor = this.getContainer().getActor();
		local helmet = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
		local armor = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		if (helmet != null)
		{
			helmet.setArmor(helmet.getArmorMax());
		}
		if (armor != null)
		{
			armor.setArmor(armor.getArmorMax());
		}
		actor.setHitpoints(actor.getHitpointsMax());
	}

});

