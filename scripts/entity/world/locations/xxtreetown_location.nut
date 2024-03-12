this.xxtreetown_location <- this.inherit("scripts/entity/world/location", {
	function getDescription()
	{
		return "Bigger than any castle, this tree is like a mythical being.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.xxtreetown_location";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsDespawningDefenders = false;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 500;
		this.m.OnEnter = "event.xxtreetown_enter_event";
	}

	function onSpawned()
	{
		this.m.Name = "Tree of Life";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.SkeletonMedium
		}, false);
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_tundra_location");
		this.getSprite("body").Color = this.createColor("#9ecf84");
	}

});

