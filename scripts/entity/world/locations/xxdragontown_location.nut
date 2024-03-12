this.xxdragontown_location <- this.inherit("scripts/entity/world/location", {
	function getDescription()
	{
		return "The nest of legendary creatures. This is a very dangerous place if the owner of the nest still exists.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.xxdragontown_location";
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
		this.m.OnEnter = "event.xxdragontown_enter_event";
	}

	function onSpawned()
	{
		this.m.Name = "Dragon Nest";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.SkeletonMedium
		}, false);
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_kraken_stones");
		this.getSprite("body").Color = this.createColor("#c4724f");
		this.getSprite("body").Saturation = 0.8;
		this.addSprite("lightinga").setBrush("world_townhall_01_undead_lights");
		this.getSprite("lightinga").Saturation = 1.2;
		this.addSprite("lightingb").setBrush("world_townhall_02_undead_lights");
		this.getSprite("lightingb").Saturation = 1.2;
		this.addSprite("lightingc").setBrush("world_townhall_03_undead_lights");
		this.getSprite("lightingc").Saturation = 1.2;
	}

});

