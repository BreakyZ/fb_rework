this.xxdarkstartown_location <- this.inherit("scripts/entity/world/location", {
	function getDescription()
	{
		return "Where the black star fell. Something from outer space is driving people crazy.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.xxdarkstartown_location";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.CombatLocation.ForceLineBattle = false;
		this.m.CombatLocation.AdditionalRadius = 10;
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.IsDespawningDefenders = false;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = false;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 500;
		this.m.OnEnter = "event.xxdarkstartown_enter_event";
	}

	function onSpawned()
	{
		this.m.Name = "Dark Star";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.SkeletonMedium
		}, false);
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_holy_site_01");
		this.getSprite("body").Color = this.createColor("#888894");
		this.getSprite("body").Saturation = 0.1;
		this.addSprite("lightinga").setBrush("world_townhall_01_undead_lights");
		this.getSprite("lightinga").Saturation = 1.2;
		this.addSprite("lightingb").setBrush("world_stronghold_02_undead_lights");
		this.getSprite("lightingb").Saturation = 1.2;
	}

});

