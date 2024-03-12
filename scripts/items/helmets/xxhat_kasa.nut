this.xxhat_kasa <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.xxhat_kasa";
		this.m.Name = "Kasa";
		this.m.Description = "It is an armor that protects the head from rain and arrows.";
		this.m.IsDroppedAsLoot = true;
		this.m.IsIndestructible = false;
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = false;
		this.m.HideCorpseHead = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 232;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 350;
		this.m.Condition = 105;
		this.m.ConditionMax = 105;
		this.m.StaminaModifier = -5;
		this.m.Vision = -1;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_helmet_xx02";
		this.m.SpriteDamaged = "bust_helmet_xx02_damaged";
		this.m.SpriteCorpse = "bust_helmet_xx02_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_bust_helmet_xx02.png";
	}

});

