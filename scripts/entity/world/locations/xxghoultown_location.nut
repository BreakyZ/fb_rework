this.xxghoultown_location <- this.inherit("scripts/entity/world/location", {
	function getDescription()
	{
		return "Occupied by black beasts and monsters, this place is filled with a disgusting smell and gloom.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.xxghoultown_location";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsDespawningDefenders = false;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 500;
		this.m.OnEnter = "event.xxghoultown_enter_event";
	}

	function onSpawned()
	{
		this.m.Name = "Dark Hive";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.SkeletonMedium
		}, false);
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_kraken_stones");
		this.getSprite("body").Color = this.createColor("#8c8c8c");
		this.getSprite("body").Saturation = 0.4;
		this.addSprite("lightinga").setBrush("world_townhall_01_undead_lights");
		this.getSprite("lightinga").Saturation = 1.2;
		this.addSprite("lightingb").setBrush("world_townhall_02_undead_lights");
		this.getSprite("lightingb").Saturation = 1.2;
		this.addSprite("lightingc").setBrush("world_townhall_03_undead_lights");
		this.getSprite("lightingc").Saturation = 1.2;
	}

});

