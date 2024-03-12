local gt = this.getroottable();

gt.Const.ProjectileType.xxgreenspear <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.xxmagicspear <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.xxprojectile_01 <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.xxprojectile_02 <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.xxprojectile_03 <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.xxprojectile_04 <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.xxprojectile_05 <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.xxprojectile_06 <- gt.Const.ProjectileType.len() - 1;
gt.Const.ProjectileType.COUNT = gt.Const.ProjectileType.len();

gt.Const.ProjectileDecals.push([""]);
gt.Const.ProjectileDecals.push([""]);
gt.Const.ProjectileDecals.push([""]);
gt.Const.ProjectileDecals.push([""]);
gt.Const.ProjectileDecals.push([""]);
gt.Const.ProjectileDecals.push([""]);
gt.Const.ProjectileDecals.push([""]);
gt.Const.ProjectileDecals.push([""]);

gt.Const.ProjectileSprite.push("blood_spray_green_01");
gt.Const.ProjectileSprite.push("effect_lightning_02");
gt.Const.ProjectileSprite.push("xxprojectile_01");
gt.Const.ProjectileSprite.push("xxprojectile_02");
gt.Const.ProjectileSprite.push("xxprojectile_03");
gt.Const.ProjectileSprite.push("xxprojectile_04");
gt.Const.ProjectileSprite.push("xxprojectile_05");
gt.Const.ProjectileSprite.push("xxprojectile_06");

gt.Const.Tactical.MortarImpactParticles2 <- [
	{
		Delay = 0,
		Quantity = 250,
		LifeTimeQuantity = 250,
		SpawnRate = 512,
		Brushes = [
			"effect_fire_01",
			"effect_fire_02",
			"effect_fire_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("cff9ff00"),
				ColorMax = this.createColor("cff9ff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				SpawnOffsetMin = this.createVec(-20, -60),
				SpawnOffsetMax = this.createVec(20, -20),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("3decffff"),
				ColorMax = this.createColor("3decffff"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("52f1fcf0"),
				ColorMax = this.createColor("52f1fcf0"),
				ScaleMin = 1.0,
				ScaleMax = 1.25,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("00d1d800"),
				ColorMax = this.createColor("00d1d800"),
				ScaleMin = 1.25,
				ScaleMax = 1.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 75,
		LifeTimeQuantity = 75,
		SpawnRate = 512,
		Brushes = [
			"blood_splatter_sand_01",
			"blood_splatter_sand_02",
			"blood_splatter_bones_01",
			"blood_splatter_bones_01",
			"blood_splatter_red_08",
			"blood_splatter_red_09"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("fffffff00"),
				ColorMax = this.createColor("fffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				SpawnOffsetMin = this.createVec(-20, -60),
				SpawnOffsetMax = this.createVec(20, -20),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("fffffff0"),
				ColorMax = this.createColor("fffffff0"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				ForceMin = this.createVec(0, -90),
				ForceMax = this.createVec(0, -90)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 500,
				VelocityMax = 600,
				ForceMin = this.createVec(0, -90),
				ForceMax = this.createVec(0, -90)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 80,
		LifeTimeQuantity = 80,
		SpawnRate = 512,
		Brushes = [
			"explosion_01",
			"explosion_01",
			"explosion_02"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("cff9ff00"),
				ColorMax = this.createColor("cff9ff00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				SpawnOffsetMin = this.createVec(-20, -60),
				SpawnOffsetMax = this.createVec(20, -20),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("3decffff"),
				ColorMax = this.createColor("3decffff"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.0, 0.25),
				DirectionMax = this.createVec(1.0, 1.0),
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("52f1fcf0"),
				ColorMax = this.createColor("52f1fcf0"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			},
			{
				LifeTimeMin = 0.3,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("00d1d800"),
				ColorMax = this.createColor("00d1d800"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				ForceMin = this.createVec(0, 90),
				ForceMax = this.createVec(0, 90)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 12,
		LifeTimeQuantity = 12,
		SpawnRate = 512,
		Brushes = [
			"explosion_01",
			"explosion_02",
			"explosion_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("51e4e800"),
				ColorMax = this.createColor("51e4e800"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.25, 0.25),
				DirectionMax = this.createVec(1.25, 0.25),
				SpawnOffsetMin = this.createVec(-10, -50),
				SpawnOffsetMax = this.createVec(10, -30),
				ForceMin = this.createVec(0, 10),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("99fcff30"),
				ColorMax = this.createColor("99fcff30"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				DirectionMin = this.createVec(-1.25, 0.25),
				DirectionMax = this.createVec(1.25, 0.25),
				ForceMin = this.createVec(0, 10),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("99fcff00"),
				ColorMax = this.createColor("99fcff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 300,
				VelocityMax = 400,
				ForceMin = this.createVec(0, 10),
				ForceMax = this.createVec(0, 10)
			}
		]
	},
	{
		Delay = 125,
		Quantity = 100,
		LifeTimeQuantity = 100,
		SpawnRate = 512,
		Brushes = [
			"ash_01",
			"ash_02",
			"ash_light_01",
			"ash_light_02"
		],
		Stages = [
			{
				LifeTimeMin = 0.25,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 200,
				VelocityMax = 300,
				DirectionMin = this.createVec(-1.0, -0.25),
				DirectionMax = this.createVec(1.0, 0.25),
				SpawnOffsetMin = this.createVec(-50, -60),
				SpawnOffsetMax = this.createVec(50, 30),
				ForceMin = this.createVec(0, 45),
				ForceMax = this.createVec(0, 45)
			},
			{
				LifeTimeMin = 0.25,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 1.0,
				ScaleMax = 1.25,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 75,
				VelocityMax = 150,
				DirectionMin = this.createVec(-0.5, -0.25),
				DirectionMax = this.createVec(0.5, 0.25),
				ForceMin = this.createVec(0, 45),
				ForceMax = this.createVec(0, 45)
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("fffffff0"),
				ColorMax = this.createColor("fffffff0"),
				ScaleMin = 1.25,
				ScaleMax = 1.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 0.0),
				DirectionMax = this.createVec(0.0, 0.0),
				ForceMin = this.createVec(0, 45),
				ForceMax = this.createVec(0, 45)
			},
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 2.0,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.5,
				ScaleMax = 1.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 50,
				VelocityMax = 100,
				DirectionMin = this.createVec(0.0, 0.0),
				DirectionMax = this.createVec(0.0, 0.0),
				ForceMin = this.createVec(0, 45),
				ForceMax = this.createVec(0, 45)
			}
		]
	}
];
gt.Const.Tactical.AttackEffectThresh2 <- [
	{
		Brush = "effect_thresh2",
		Movement0 = this.createVec(0, 0),
		Movement1 = this.createVec(0, 0),
		Offset = this.createVec(0, 0)
	},
	{
		Brush = "effect_thresh2",
		Movement0 = this.createVec(0, 0),
		Movement1 = this.createVec(0, 0),
		Offset = this.createVec(0, 0)
	},
	{
		Brush = "effect_thresh2",
		Movement0 = this.createVec(0, 0),
		Movement1 = this.createVec(0, 0),
		Offset = this.createVec(0, 0)
	},
	{
		Brush = "effect_thresh2",
		Movement0 = this.createVec(0, 0),
		Movement1 = this.createVec(0, 0),
		Offset = this.createVec(0, 0)
	},
	{
		Brush = "effect_thresh2",
		Movement0 = this.createVec(0, 0),
		Movement1 = this.createVec(0, 0),
		Offset = this.createVec(0, 0)
	},
	{
		Brush = "effect_thresh2",
		Movement0 = this.createVec(0, 0),
		Movement1 = this.createVec(0, 0),
		Offset = this.createVec(0, 0)
	}
];
gt.Const.Tactical.HellFireParticles <- [
	{
		Delay = 0,
		Quantity = 230,
		LifeTimeQuantity = 0,
		SpawnRate = 156,
		Brushes = [
			"effect_fire_01",
			"effect_fire_02",
			"effect_fire_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.1,
				ColorMin = this.createColor("efffcf00"),
				ColorMax = this.createColor("ecffcf00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				SpawnOffsetMin = this.createVec(-50, -45),
				SpawnOffsetMax = this.createVec(50, 5),
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("dbff3dff"),
				ColorMax = this.createColor("eeffa1ff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("fcf653f0"),
				ColorMax = this.createColor("c1fc53f0"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("c3d90000"),
				ColorMax = this.createColor("c3d90000"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			}
		]
	},
	{
		Delay = 100,
		Quantity = 40,
		LifeTimeQuantity = 0,
		SpawnRate = 21,
		Brushes = [
			"ash_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("c1ff0000"),
				ColorMax = this.createColor("c1ff0000"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				SpawnOffsetMin = this.createVec(-35, -45),
				SpawnOffsetMax = this.createVec(35, 0)
			},
			{
				LifeTimeMin = 2.0,
				LifeTimeMax = 3.0,
				ColorMin = this.createColor("e6ff9cff"),
				ColorMax = this.createColor("a4db00ff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("f7ffde00"),
				ColorMax = this.createColor("97bf1b00"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, -80),
				ForceMax = this.createVec(0, -80)
			}
		]
	}
];
gt.Const.Tactical.BeartrapParticles <- [
	{
		Delay = 0,
		Quantity = 30,
		LifeTimeQuantity = 0,
		SpawnRate = 5,
		Brushes = [
			"effect_lightning_01",
			"effect_lightning_02",
			"effect_lightning_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.45,
				LifeTimeMax = 0.65,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.5, 0.5),
				DirectionMax = this.createVec(0.5, 0.5),
				SpawnOffsetMin = this.createVec(-50, -40),
				SpawnOffsetMax = this.createVec(50, 20),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 2.0,
				LifeTimeMax = 3.0,
				ColorMin = this.createColor("9d82172d"),
				ColorMax = this.createColor("f5e6aa2d"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 0.3,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			}
		]
	},
	{
		Delay = 0,
		Quantity = 20,
		LifeTimeQuantity = 0,
		SpawnRate = 4,
		Brushes = [
			"miasma_effect_02",
			"miasma_effect_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.75,
				LifeTimeMax = 1.25,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.5, 0.5),
				DirectionMax = this.createVec(0.5, 0.5),
				SpawnOffsetMin = this.createVec(-50, -40),
				SpawnOffsetMax = this.createVec(50, 20),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 4.0,
				LifeTimeMax = 6.0,
				ColorMin = this.createColor("9d82172d"),
				ColorMax = this.createColor("f5e6aa2d"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			}
		]
	}
];

gt.Const.CharacterBackgrounds.push("xxheroroyal_background");
gt.Const.CharacterBackgrounds.push("xxherohighelf_background");
gt.Const.CharacterBackgrounds.push("xxherocrimson_background");

gt.FantasyChampList <- [
"background.xxheroroyal",
"background.xxherosp"
];

gt.FantasySpellbookact <- function ( _actor ) {
	local chk = _actor.getSkills();
	local sk_type = [
		"sb_acciattack_skill",
		"sb_acidbomb_skill",
		"sb_backstab_skill",
		"sb_beartrap_skill",
		"sb_bkcharge_skill",
		"sb_blackbomb_skill",
		"sb_blessing_skill",
		"sb_bloodletting_skill",
		"sb_bloodlust_skill",
		"sb_bribe_skill",
		"sb_cannon_skill",
		"sb_chokentoss_skill",
		"sb_command_skill",
		"sb_concent_skill",
		"sb_cqcthrowing_skill",
		"sb_cure_skill",
		"sb_demon_skill",
		"sb_devablow_skill",
		"sb_drainblood_skill",
		"sb_earthquake_skill",
		"sb_electric_skill",
		"sb_feast_skill",
		"sb_fireball_skill",
		"sb_firebomb_skill",
		"sb_flamewave_skill",
		"sb_flingback_skill",
		"sb_fonature_skill",
		"sb_frenzy_skill",
		"sb_frostblast_skill",
		"sb_gale_skill",
		"sb_great_skill",
		"sb_headbutt_skill",
		"sb_heal_skill",
		"sb_hide_skill",
		"sb_holyspear_skill",
		"sb_judo_skill",
		"sb_kick_skill",
		"sb_linebreaker_skill",
		"sb_lute_skill",
		"sb_manaforce_skill",
		"sb_march_skill",
		"sb_mark_skill",
		"sb_miracle_skill",
		"sb_moneysteal_skill",
		"sb_multishot_skill",
		"sb_penshot_skill",
		"sb_pincer_skill",
		"sb_pull_skill",
		"sb_pull2_skill",
		"sb_puri_skill",
		"sb_rain_skill",
		"sb_revel_skill",
		"sb_rock_skill",
		"sb_sand_skill",
		"sb_scream_skill",
		"sb_sguard_skill",
		"sb_shadowwalk_skill",
		"sb_shieldbash_skill",
		"sb_shockwave_skill",
		"sb_slander_skill",
		"sb_snake_skill",
		"sb_snow_skill",
		"sb_stormfury_skill",
		"sb_strike_skill",
		"sb_sumfiend_skill",
		"sb_sumskel_skill",
		"sb_sumwolf_skill",
		"sb_swap_skill",
		"sb_sweep_skill",
		"sb_taichi_skill",
		"sb_tieup_skill",
		"sb_unlrage_skill",
		"sb_warcrime_skill",
		"sb_warcry_skill",
		"sb_waterbomb_skill",
		"sb_whirlwind_skill",
		"sb_wolfride_skill",
		"sb_zeroshot_skill",
		"sbp_agile_skill",
		"sbp_allrounder_skill",
		"sbp_banner_skill",
		"sbp_battletrance_skill",
		"sbp_beater_skill",
		"sbp_bondage_skill",
		"sbp_challenger_skill",
		"sbp_counter_skill",
		"sbp_desolator_skill",
		"sbp_drunk_skill",
		"sbp_goblin_skill",
		"sbp_hardenskin_skill",
		"sbp_headcollector_skill",
		"sbp_hunting_skill",
		"sbp_kensei_skill",
		"sbp_laststand_skill",
		"sbp_lifestealer_skill",
		"sbp_maso_skill",
		"sbp_oddball_skill",
		"sbp_orc_skill",
		"sbp_outsider_skill",
		"sbp_overwarmup_skill",
		"sbp_prudence_skill",
		"sbp_rapid_skill",
		"sbp_selfcare_skill",
		"sbp_sharpshooter_skill",
		"sbp_skullsurgery_skill",
		"sbp_spear_skill",
		"sbp_veteran_skill"
	];
	for( local i = 0; i < sk_type.len(); i = ++i )
	{
		local skname = "actives." + sk_type[i]
		if (chk.hasSkill(skname))
		{
			chk.removeByID(skname);
			sk_type.remove(i)
		}
	}
	sk_type = sk_type[this.Math.rand(0, sk_type.len() - 1)];
	chk.add(this.new("scripts/skills/actives/" + sk_type));
	this.Sound.play("sounds/inventory/armor_upgrade_use_01.wav", this.Const.Sound.Volume.Inventory);
};
