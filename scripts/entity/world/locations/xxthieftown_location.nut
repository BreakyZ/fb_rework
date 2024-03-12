this.xxthieftown_location <- this.inherit("scripts/entity/world/location", {
	function getDescription()
	{
		return "A city of exiles and rebels who rebelled against the nobility. The pure spirit of the uprising is gone and it is now a den of villains.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.xxthieftown_location";
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.CombatLocation.Template[0] = "tactical.xxtactical_ruintown";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 10;
		this.m.IsDespawningDefenders = false;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsAttackable = true;
		this.m.VisibilityMult = 1.0;
		this.m.Resources = 500;
		this.m.OnDestroyed = "event.xxthieftown_destroyed_event";
		this.m.OnEnter = "event.xxthieftown_enter_event";
	}

	function onSpawned()
	{
		this.m.Name = "City of Thieves";
		this.location.onSpawned();
		local i;
		local mob;
		for( i = 0; i < 3; i = ++i )
		{
			mob = {
				ID = this.Const.EntityType.OrcWarlord,
				Variant = 0,
				Strength = 1,
				Row = 3,
				Script = "scripts/entity/tactical/enemies/xxmob_syndicate",
			}
			this.Const.World.Common.addTroop(this, {Type = mob}, false, 100);
		}
		for( i = 0; i < 1; i = ++i )
		{
			mob = {
				ID = this.Const.EntityType.OrcWarlord,
				Variant = 0,
				Strength = 1,
				Row = 0,
				Script = "scripts/entity/tactical/enemies/xxmob_darkman",
			}
			this.Const.World.Common.addTroop(this, {Type = mob}, false, 100);
			mob = {
				ID = this.Const.EntityType.OrcWarlord,
				Variant = 0,
				Strength = 1,
				Row = 2,
				Script = "scripts/entity/tactical/enemies/xxmob_guildmaster",
			}
			this.Const.World.Common.addTroop(this, {Type = mob}, false, 100);
		}

		local Troops = 
		[
			{
				Type = this.Const.World.Spawn.Troops.StandardBearer,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.BanditRaider,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.BanditMarksman,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.BanditThug,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.BanditRaiderWolf,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.BanditLeader,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Mercenary,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.MercenaryRanged,
				Num = 2
			}
			{
				Type = this.Const.World.Spawn.Troops.BountyHunter,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.BountyHunterRanged,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.HedgeKnight,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.Swordmaster,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.MasterArcher,
				Num = 2
			}
		]
		foreach(troop in Troops)
		{
			for( local i = 0; i < troop.Num; i = ++i )
			{
				this.Const.World.Common.addTroop(this, {Type = troop.Type}, false);
			}
		}
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_stronghold_02");
		this.addSprite("lighting").setBrush("world_stronghold_02_undead_lights");
		this.getSprite("lighting").Saturation = 1.2;
	}

});

