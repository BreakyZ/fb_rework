this.xxmob_shield_golem <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {},
	function create()
	{
		this.named_shield.create();
		this.updateVariant();
		this.m.ID = "shield.xxmob_shield_golem";
		this.m.Name = "Golem Shield";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = false;
		this.m.Value = 0;
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 15;
		this.m.StaminaModifier = 0;
		this.m.Condition = 120;
		this.m.ConditionMax = 120;
		this.m.SoundOnHit = this.Const.Sound.ShieldHitMetal;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_golem_02";
		this.m.SpriteDamaged = "bust_golem_02";
		this.m.ShieldDecal = "";
		this.m.IconLarge = "shields/inventory_legendary_shield_01.png";
		this.m.Icon = "shields/icon_legendary_shield_01.png";
	}

	function onUpdateProperties( _properties )
	{
		this.named_shield.onUpdateProperties(_properties);
		_properties.DamageReceivedTotalMult *= 0.5;
		_properties.MeleeSkill += 20;
	}

});

