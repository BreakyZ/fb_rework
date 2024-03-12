this.xxwolftown_location <- this.inherit("scripts/entity/world/location", {
	function getDescription()
	{
		return "This is the den of dangerous beasts. Thousands of animal and human bones are warning us not to come here.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.xxwolftown_location";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsDespawningDefenders = false;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 500;
		this.m.OnEnter = "event.xxwolftown_enter_event";
	}

	function onSpawned()
	{
		this.m.Name = "Wolves Den";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.SkeletonMedium
		}, false);
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_unhold_graveyard");
		this.addSprite("lightinga").setBrush("world_cave_01");
		this.getSprite("lightinga").Scale = 1.1;
		this.setSpriteOffset("lightinga", this.createVec(-10, -25));
	}

});

