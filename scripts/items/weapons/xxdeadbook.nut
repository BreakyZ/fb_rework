this.xxdeadbook <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.xxdeadbook";
		this.m.Name = "Book of the Dead";
		this.m.Description = "A book that contains all the knowledge about death. Set effect occurs when used with Obsidian Dagger.";
		this.m.Categories = "Unknown Weapon, Left-Handed";
		this.m.IconLarge = "xx_weapon_09.png";
		this.m.Icon = "xx_weapon_09_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Tool;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_xx_weapon_09";
		this.m.Value = 5000;
		this.m.ArmorDamageMult = 1.0;
		this.m.StaminaModifier = 0;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Melee Defense"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25/35[/color] Damage when equipped with a Obsidian Dagger"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/xxitem_deadbookaa_skill"));
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
		this.getContainer().getActor().setSpriteOffset("arms_icon", this.createVec(0, 0));
		this.getContainer().updateAppearance();
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
		local mainh = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local offh = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		_properties.MeleeDefense += 20;
		if (mainh != null && mainh.getID() == "weapon.obsidian_dagger")
		{
			_properties.DamageRegularMin += 25;
			_properties.DamageRegularMax += 35;
		}
	}

});

