this.xxmob_berserkguts <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Name = "the Black Swordsman";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
		this.human.create();
		this.m.Faces = null;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.HedgeKnight);
		b.IsSpecializedInSwords = true;
		b.MovementAPCostAdditional -= 1;
		b.Hitpoints += 500;
		b.Bravery += 500;
		b.Stamina += 200;
		b.MeleeSkill += 5;
		b.MeleeDefense += 5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.addSprite("socket").setBrush("bust_base_beasts");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/adrenaline_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_gutsbuff"));
		this.getSprite("head").setBrush("bust_head_13");
		this.getSprite("hair").setBrush("hair_black_08");
		this.getSprite("body").setBrush("bust_body_53");
		this.getSprite("tattoo_body").setBrush("bust_body_62");
		this.getSprite("tattoo_body").Saturation = 0.1;
		this.getSprite("surcoat").setBrush("bust_body_noble_07");
		this.getSprite("surcoat").Saturation = 0.1;
		this.getSprite("surcoat").Color = this.createColor("#d4d4d4");
	}

	function assignRandomEquipment()
	{
		local itt = this.new("scripts/items/weapons/greatsword");
		itt.m.ArmamentIcon = "icon_xx_weapon_08";
		itt.m.Condition = 7777;
		itt.m.ConditionMax = itt.m.Condition;
		this.m.Items.equip(itt);
		itt = this.new("scripts/items/armor/named/black_leather_armor");
		itt.m.ShowOnCharacter = false;
		itt.m.Condition = 500;
		itt.m.ConditionMax = itt.m.Condition;
		this.m.Items.equip(itt);
		itt = this.new("scripts/items/helmets/named/wolf_helmet");
		itt.m.ShowOnCharacter = false;
		itt.m.Condition = 500;
		itt.m.ConditionMax = itt.m.Condition;
		this.m.Items.equip(itt);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			for( local i = 0; i < this.Const.Tactical.KrakenDevourVictimParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.KrakenDevourVictimParticles[i].Brushes, _tile, this.Const.Tactical.KrakenDevourVictimParticles[i].Delay, this.Const.Tactical.KrakenDevourVictimParticles[i].Quantity, this.Const.Tactical.KrakenDevourVictimParticles[i].LifeTimeQuantity, this.Const.Tactical.KrakenDevourVictimParticles[i].SpawnRate, this.Const.Tactical.KrakenDevourVictimParticles[i].Stages);
			}
			for( local i = 0; i < this.Const.Tactical.GruesomeFeastParticles.len(); i = ++i )
			{
				this.Tactical.spawnParticleEffect(true, this.Const.Tactical.GruesomeFeastParticles[i].Brushes, _tile, this.Const.Tactical.GruesomeFeastParticles[i].Delay, this.Const.Tactical.GruesomeFeastParticles[i].Quantity, this.Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, this.Const.Tactical.GruesomeFeastParticles[i].SpawnRate, this.Const.Tactical.GruesomeFeastParticles[i].Stages);
			}
			local flip = this.Math.rand(0, 100) < 50;
			this.m.IsCorpseFlipped = flip;
			this.spawnBloodPool(_tile, 1);
			local decal = _tile.spawnDetail("bust_xxcorpse_01", this.Const.Tactical.DetailFlag.Corpse, flip, false);
			decal.Scale = this.Math.rand(1, 10) * 0.01 + 1.1;
			decal.varySaturation(0.2);
			decal.varyColor(0.2, 0.2, 0.2);
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = this.getName();
			corpse.Tile = _tile;
			corpse.IsHeadAttached = true;
			corpse.IsConsumable = true;
			corpse.IsResurrectable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});

