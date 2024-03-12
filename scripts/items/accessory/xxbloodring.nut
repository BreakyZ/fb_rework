this.xxbloodring <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.xxbloodring";
		this.m.Name = "Blood Ring";
		this.m.Description = "Imbued with the power of the Necrosavant, this ring makes the wearer thirst for blood.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/xxbloodring.png";
		this.m.Sprite = "xxsilvertrophy";
		this.m.Value = 3000;
	}

	function getTooltip()
	{
		local result = [
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
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When attacking a bleeding target: +10% Damage, +5 Melee skill, +5 Ranged skill, 30% Lifesteal on Hit"
		});
		return result;
	}

	function onEquip()
	{
		this.accessory.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_bloodringaa_skill"));
	}

});

