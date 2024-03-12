this.xxlefts <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxlefts";
		this.m.Name = "Left Handed Sword";
		this.m.Description = "Left handed sub weapon for dual wielding. You must have a main weapon to attack.";
		this.m.Categories = "Unknown Weapon";
		this.m.IconLarge = "xx_weapon_03.png";
		this.m.Icon = "xx_weapon_03_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Tool;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_03";
		this.m.Value = 1000;
		this.m.ArmorDamageMult = 1.0;
		this.m.StaminaModifier = -4;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Melee Damage"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Melee Defense"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Add [color=" + this.Const.UI.Color.PositiveValue + "]Special Skill[/color] when equipped with a double grip weapon (except unknown weapon)"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_leftsaa_skill"));
		if (this.getContainer().getActor().isAlliedWithPlayer())
		{
			this.getContainer().getActor().setSpriteOffset("arms_icon", this.createVec(-15, 0));
		}
		else
		{
			this.getContainer().getActor().setSpriteOffset("arms_icon", this.createVec(15, 0));
		}
		this.getContainer().getActor().setAlwaysApplySpriteOffset(true);
		this.updateAppearance();
	}

	function onUnequip()
	{
		this.m.IsBloodied = false;
		this.weapon.onUnequip();
		if (this.m.ShowArmamentIcon)
		{
			if (this.m.SlotType == this.Const.ItemSlot.Offhand)
			{
				this.getContainer().getAppearance().Shield = "";
			}
			else
			{
				this.getContainer().getAppearance().Weapon = "";
				this.getContainer().getAppearance().TwoHanded = false;
			}
		}
		this.getContainer().getActor().setSpriteOffset("arms_icon", this.createVec(0, 0));
		this.getContainer().updateAppearance();
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		_properties.MeleeDefense += 5;
		_properties.MeleeDamageMult += 0.15;
	}

});

