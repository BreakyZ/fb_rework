this.xxsc_armor_outz <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.xxsc_armor_outz";
		this.m.NameList = [
			"Avenger",
			"Ancestor",
			"Basilisk",
			"Cockatrice",
			"Gorgon",
			"Griffin",
			"Phoenix",
			"Pegasus",
			"Sasquatch",
			"Yeti",
			"Best Friend",
			"Buddy",
			"Bastion",
			"Defender",
			"Doppelganger",
			"Keeper",
			"Tutelary",
			"Dominator",
			"Warden",
			"Guardian",
			"Protector",
			"Safeguard",
			"Spirit",
			"Shapechanger",
			"Legacy",
			"Peacekeeper",
			"Overseer",
			"Overlord",
			"Sage",
			"Tyrant",
			"Great One",
			"Old One",
			"Elderguard",
			"Invincible",
			"Unbeatable",
			"Preserver",
			"Savior",
			"Familiar",
			"Eternal Life",
			"Saver",
			"Redeemer",
			"Supreme Guard",
			"Unique Guard"
		];
		this.m.Description = "Shape change has been applied.";
		this.m.ShowOnCharacter = true;
		this.m.VariantString = "";
		this.m.Variant = 12;
		this.m.Sprite = "bust_body_12";
		this.m.SpriteDamaged = "bust_body_12_damaged";
		this.m.SpriteCorpse = "bust_body_12_dead";
		this.m.IconLarge = "armor/inventory_body_armor_12.png";
		this.m.Icon = "armor/icon_body_armor_12.png";
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.JesterImpact;
		this.m.Value = 2000;
		this.m.Condition = 200;
		this.m.ConditionMax = 200;
		this.m.StaminaModifier = -20;
		this.m.UseRandomName = true;
		this.xxnameditem();
	}

	function updateVariant()
	{
	}

	function xxnameditem()
	{
		if (this.Math.rand(0, 2) == 2)
		{
			this.m.StaminaModifier = this.Math.rand(-40, -10);
			this.m.Condition = this.Math.rand(100, 350);
		}
		else
		{
			this.m.StaminaModifier = this.Math.rand(-40, -20);
			this.m.Condition = this.Math.rand(200, 350);
		}
		this.m.ConditionMax = this.m.Condition;
	}

	function onSerialize( _out )
	{
		_out.writeString(this.m.Name);
		_out.writeF32(this.m.Condition);
		_out.writeF32(this.m.ConditionMax);
		_out.writeI8(this.m.StaminaModifier);
		_out.writeString(this.m.Sprite);
		_out.writeString(this.m.SpriteDamaged);
		_out.writeString(this.m.SpriteCorpse);
		_out.writeString(this.m.IconLarge);
		_out.writeString(this.m.Icon);
		_out.writeString(this.m.VariantString);
		_out.writeI8(this.m.Variant);
		this.armor.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.Name = _in.readString();
		this.m.Condition = _in.readF32();
		this.m.ConditionMax = _in.readF32();
		this.m.StaminaModifier = _in.readI8();
		this.m.Sprite = _in.readString();
		this.m.SpriteDamaged = _in.readString();
		this.m.SpriteCorpse = _in.readString();
		this.m.IconLarge = _in.readString();
		this.m.Icon = _in.readString();
		this.m.VariantString = _in.readString();
		this.m.Variant = _in.readI8();
		this.armor.onDeserialize(_in);
		this.updateVariant();
	}

});

