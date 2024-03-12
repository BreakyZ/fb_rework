this.xxmob_darkman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Name = "Faceless";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.HedgeKnight);
		b.IsSpecializedInSwords = true;
		b.AdditionalActionPointCost = -2;
		b.MovementAPCostAdditional += 1;
		b.Hitpoints += 100;
		b.Bravery += 200;
		b.MeleeSkill += 3;
		b.MeleeDefense += 3;
		b.RangedDefense -= 30;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.addSprite("socket").setBrush("bust_base_beasts");
		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.getSprite("head").setBrush("bust_head_04");
		this.getSprite("head").Color = this.createColor("#000000");
		this.getSprite("hair").setBrush("bust_helmet_63");
		this.getSprite("body").setBrush("bust_body_5" + this.Math.rand(1, 3));
		local injury = this.getSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_head_injured_02");
		injury.Scale = 0.8;
		local injury_body = this.getSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_naked_body_01_injured");
		local rr = this.Math.rand(1, 5);
		this.addSprite("surcoat").setHorizontalFlipping(true);
		if (rr == 1)
		{
			this.getSprite("surcoat").setBrush("icon_named_axe_05_bloodied");
		}
		else if (rr == 2)
		{
			this.getSprite("surcoat").setBrush("icon_named_cleaver_03_bloodied");
		}
		else if (rr == 3)
		{
			this.getSprite("surcoat").setBrush("icon_scimitar_01_bloodied");
		}
		else if (rr == 4)
		{
			this.getSprite("surcoat").setBrush("icon_scimitar_01_named_01_bloodied");
		}
		else
		{
			this.getSprite("surcoat").setBrush("icon_scimitar_01_named_02_bloodied");
		}
		this.setSpriteOffset("surcoat", this.createVec(-30, 10));
		this.setSpriteOffset("arms_icon", this.createVec(10, 0));
		this.setAlwaysApplySpriteOffset(true);
	}

	function onUpdateInjuryLayer()
	{
		local injury = this.getSprite("injury");
		local injury_body = this.getSprite("injury_body");
		local p = this.m.Hitpoints / this.getHitpointsMax();
		if (p > 0.7)
		{
			this.setDirty(this.m.IsDirty || injury.Visible || injury_body.Visible);
			injury.Visible = false;
			injury_body.Visible = false;
		}
		else
		{
			this.setDirty(this.m.IsDirty || !injury.Visible || !injury_body.Visible);
			injury_body.Visible = true;
			if (p > 0.4)
			{
				injury.Visible = false;
			}
			else
			{
				injury.Visible = true;
			}
		}
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/named/named_shamshir"));
		local itt = this.new("scripts/items/armor/named/black_leather_armor");
		itt.m.ShowOnCharacter = false;
		itt.m.Condition = this.Math.rand(200, 250);
		itt.m.ConditionMax = itt.m.Condition;
		this.m.Items.equip(itt);
		local htt = this.new("scripts/items/helmets/named/wolf_helmet");
		htt.m.ShowOnCharacter = false;
		htt.m.Condition = this.Math.rand(200, 250);
		htt.m.ConditionMax = htt.m.Condition;
		this.m.Items.equip(htt);
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

