this.xxmob_mage <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Name = "Mage";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		b.IsImmuneToDisarm = true;
		b.Hitpoints += this.Math.rand(100, 150);
		b.RangedSkill += 30;
		b.Bravery += 300;
		b.Stamina += 300;
		b.MeleeDefense += 10
		b.RangedDefense -= 30
		b.Initiative += 80,
		b.Vision += 5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.addSprite("socket").setBrush("bust_base_beasts");
		this.getSprite("head").Saturation = 0.4;
		this.getSprite("body").Saturation = 0.4;
		this.addSprite("weapona").setHorizontalFlipping(true);
		this.getSprite("weapona").setBrush("icon_goblin_weapon_06");

		local wtt = this.new("scripts/items/weapons/named/xx_mob_fakeweapon15");
		wtt.m.RangeMax = 5;
		wtt.m.RangeIdeal = 5;
		this.m.Items.equip(wtt);
		this.m.Items.equip(this.new("scripts/items/helmets/wizard_hat"));
		this.m.Items.equip(this.new("scripts/items/armor/wizard_robe"));

		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_nopunch"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_magicspear"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_damaged_teleport"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_ghost_01"
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff5f"),
						ColorMax = this.createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = this.createColor("ffffff2f"),
						ColorMax = this.createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});

