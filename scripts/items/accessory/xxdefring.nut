this.xxdefring <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.xxdefring";
		this.m.Name = "Ring of Protection";
		this.m.Description = "A ring with magical protection. Detects hostile behavior and alerts the wearer to avoid it.";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "accessory/xxdefring.png";
		this.m.Sprite = "xxsilvertrophy";
		this.m.Value = 2000;
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
			text = "When the total durability of armor and helmet is 400 or less: +8~18 melee defense during battle in proportion to total durability"
		});
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Otherwise: +8 melee defense during battle"
		});
		result.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]WARNING:[/color]If you have learned Nimble perk or Battle forged perk, this will not work."
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.accessory.onUpdateProperties(_properties);
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("perk.battle_forged") || actor.getSkills().hasSkill("perk.nimble") || !this.getContainer().getActor().isPlacedOnMap())
		{
		}
		else
		{
			local armor = actor.getArmorMax(this.Const.BodyPart.Head) + actor.getArmorMax(this.Const.BodyPart.Body);
			if (armor <= 400)
			{
				local def = this.Math.floor(armor * 0.045);
				_properties.MeleeDefense += this.Math.max(8, def);
			}
			else
			{
				_properties.MeleeDefense += 8;
			}
		}
	}

});

