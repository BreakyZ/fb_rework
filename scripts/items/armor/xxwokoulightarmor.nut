this.xxwokoulightarmor <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.xxwokoulightarmor";
		this.m.Name = "Wokou Light Armor";
		this.m.Description = "Light armor that protects the body";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 100;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 300;
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.StaminaModifier = -10;
	}

	function updateVariant()
	{
		local variant = this.m.Variant
		this.m.Sprite = "xxarmor_" + variant;
		this.m.SpriteDamaged = "xxarmor_" + variant + "_damaged";
		this.m.SpriteCorpse = "xxarmor_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "armor/inventory_xxarmor_" + variant + ".png";
	}

	function isDroppedAsLoot()
	{
		return this.m.IsDroppedAsLoot;
	}

});

