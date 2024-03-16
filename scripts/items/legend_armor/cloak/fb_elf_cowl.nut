this.fb_elf_cowl <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.fb_elf_cowl";
		this.m.Name = "Gwalch Cowl";
		this.m.Description = "A forest elf cowl";
		this.m.ArmorDescription = "Has a forest elf cowl";
		this.m.Variant = 101;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 50;
		this.m.Condition = 15;
		this.m.ConditionMax = 15;
		this.m.StaminaModifier = -1;
		this.m.ItemType = this.m.ItemType;
		this.m.Bravery = 0;
	}

	function updateVariant()
	{
		local baseName = "fb_elf_cowl";
		this.m.SpriteBack = baseName;
		this.m.SpriteDamagedBack = baseName + "_damaged";
		this.m.SpriteCorpseBack = baseName + "_dead";
		this.m.Icon = "legend_armor/icon_fb_elf_cowl" + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_fb_elf_cowl" + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_fb_elf_cowl" + ".png";
	}

});

