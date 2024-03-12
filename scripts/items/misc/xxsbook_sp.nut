this.xxsbook_sp <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.m.ID = "misc.xxsbook_sp";
		this.m.Name = "Advanced Skill Book";
		this.m.Description = "Learn a random special skill. 27% chance to learn a desired skill. Previously learned special skills are lost. There is no penalty for learning this multiple times. (Some special mercenaries cannot use skill books)";
		this.m.Icon = "xx_item_04b_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
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
			id = 65,
			type = "text",
			text = "Use by Right-clicking or Dragging on the body slot of the currently selected character. This item will be consumed in the process."
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		local chk = _actor.getSkills();
		foreach ( s in this.FantasyChampList )
		{
			if (chk.hasSkill(s))
			{
				return false;
			}
		}

		if (_actor.getFlags().getAsInt("xxSkillBookTraining") < 9999989)
		{
		}
		else
		{
			return false;
		}

		if (this.Math.rand(1, 100) <= 27)
		{
			chk.add(this.new("scripts/skills/actives/xxzzcheck_skill"));
		        ::World.State.getMenuStack().popAll(true);
			::World.Events.fire("event.xxzzskillbook_event");
		}
		else
		{
			this.FantasySpellbookact(_actor);
		}
		return true;
	}

	function getBuyPrice()
	{
		return this.Math.ceil(this.getValue());
	}

	function getSellPrice()
	{
		return this.Math.round(this.getValue() * 1);
	}

});

