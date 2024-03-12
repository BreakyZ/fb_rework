this.xxblackdragontown_location <- this.inherit("scripts/entity/world/location", {
	function getDescription()
	{
		return "A malevolent entity is amassing an army here to annihilate humanity.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.xxblackdragontown_location";
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
		this.m.OnEnter = "event.xxblackdragontown_enter_event";
	}

	function onSpawned()
	{
		this.m.Name = "Black Dragon Nest";
		this.location.onSpawned();
		this.Const.World.Common.addTroop(this, {
			Type = this.Const.World.Spawn.Troops.SkeletonMedium
		}, false);
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_unhold_graveyard");
		this.getSprite("body").Color = this.createColor("#63636b");
		this.getSprite("body").Saturation = 0.3;
		this.addSprite("lightinga").setBrush("world_townhall_01_undead_lights");
		this.getSprite("lightinga").Saturation = 1.2;
		this.addSprite("lightingb").setBrush("world_townhall_02_undead_lights");
		this.getSprite("lightingb").Saturation = 1.2;
		this.addSprite("lightingc").setBrush("world_townhall_03_undead_lights");
		this.getSprite("lightingc").Saturation = 1.2;
	}

});

