this.xxhat_hunshelm <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.xxhat_hunshelm";
		this.m.Name = "Eastern Helm";
		this.m.Description = "Equipment to protect the head.";
		this.m.IsDroppedAsLoot = true;
		this.m.IsIndestructible = false;
		this.m.ShowOnCharacter = true;
		this.m.HideCharacterHead = false;
		this.m.HideCorpseHead = false;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = 110;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1000;
		this.m.Condition = 240;
		this.m.ConditionMax = 240;
		this.m.StaminaModifier = -16;
		this.m.Vision = -2;
	}

	function updateVariant()
	{
		this.m.Sprite = "xxknighthelm_" + this.m.Variant;
		this.m.SpriteDamaged = "xxknighthelm_" + this.m.Variant + "_damaged";
		this.m.SpriteCorpse = "xxknighthelm_" + this.m.Variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_xxhat_hunshelm.png";
	}

});

