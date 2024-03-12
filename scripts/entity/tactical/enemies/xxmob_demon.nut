this.xxmob_demon <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Name = "Demon Lord";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.OrcWarrior.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = null;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/orc_warlord_agent");
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Flee);
		this.m.AIAgent.removeBehavior(this.Const.AI.Behavior.ID.Retreat);
		this.m.AIAgent.setActor(this);
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/orc_death_01.wav",
			"sounds/enemies/orc_death_02.wav",
			"sounds/enemies/orc_death_03.wav",
			"sounds/enemies/orc_death_04.wav",
			"sounds/enemies/orc_death_05.wav",
			"sounds/enemies/orc_death_06.wav",
			"sounds/enemies/orc_death_07.wav",
			"sounds/enemies/orc_death_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/orc_flee_01.wav",
			"sounds/enemies/orc_flee_02.wav",
			"sounds/enemies/orc_flee_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/orc_hurt_01.wav",
			"sounds/enemies/orc_hurt_02.wav",
			"sounds/enemies/orc_hurt_03.wav",
			"sounds/enemies/orc_hurt_04.wav",
			"sounds/enemies/orc_hurt_05.wav",
			"sounds/enemies/orc_hurt_06.wav",
			"sounds/enemies/orc_hurt_07.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/orc_idle_01.wav",
			"sounds/enemies/orc_idle_02.wav",
			"sounds/enemies/orc_idle_03.wav",
			"sounds/enemies/orc_idle_04.wav",
			"sounds/enemies/orc_idle_05.wav",
			"sounds/enemies/orc_idle_06.wav",
			"sounds/enemies/orc_idle_07.wav",
			"sounds/enemies/orc_idle_08.wav",
			"sounds/enemies/orc_idle_09.wav",
			"sounds/enemies/orc_idle_10.wav",
			"sounds/enemies/orc_idle_11.wav",
			"sounds/enemies/orc_idle_12.wav",
			"sounds/enemies/orc_idle_13.wav",
			"sounds/enemies/orc_idle_14.wav",
			"sounds/enemies/orc_idle_15.wav",
			"sounds/enemies/orc_idle_16.wav",
			"sounds/enemies/orc_idle_17.wav",
			"sounds/enemies/orc_idle_18.wav",
			"sounds/enemies/orc_idle_19.wav",
			"sounds/enemies/orc_idle_20.wav",
			"sounds/enemies/orc_idle_21.wav",
			"sounds/enemies/orc_idle_22.wav",
			"sounds/enemies/orc_idle_23.wav",
			"sounds/enemies/orc_idle_24.wav",
			"sounds/enemies/orc_idle_25.wav",
			"sounds/enemies/orc_idle_26.wav",
			"sounds/enemies/orc_idle_27.wav",
			"sounds/enemies/orc_idle_28.wav",
			"sounds/enemies/orc_idle_29.wav",
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/orc_fatigue_01.wav",
			"sounds/enemies/orc_fatigue_02.wav",
			"sounds/enemies/orc_fatigue_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundPitch = 0.95;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.HedgeKnight);
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsAffectedByNight = false;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInSpears = true;
		b.Hitpoints += this.Math.rand(1000, 1500);
		b.MeleeSkill -= 10;
		b.MeleeDefense += 10;
		b.RangedDefense -= 30;
		b.Bravery += 500;
		b.DamageRegularMin += 50;
		b.DamageRegularMax += 80;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.addSprite("socket").setBrush("bust_base_beasts");

		local wtt = this.new("scripts/items/weapons/named/xx_mob_fakeweapon15");
		wtt.m.RangeMax = 1;
		wtt.m.RangeIdeal = 1;
		wtt.m.ArmorDamageMult = 1.1;
		wtt.m.DirectDamageMult = 0.3;
		this.m.Items.equip(wtt);

		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_demonbuff"));
		this.m.Skills.add(this.new("scripts/skills/actives/warcry"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/actives/ai_punch"));
		local head = this.addSprite("head")
		head.setBrush("bust_demon_head_01");
		this.setSpriteOffset("head", this.createVec(0, 0));
		local body = this.addSprite("body");
		body.setBrush("bust_body_81");
		this.addSprite("permanent_injury_5").setHorizontalFlipping(true);
		this.getSprite("permanent_injury_5").setBrush("zombie_rage_eyes");
		this.getSprite("permanent_injury_5").Visible = true;
		this.getSprite("permanent_injury_5").Color = this.createColor("#fff200");
		this.getSprite("permanent_injury_5").Saturation = 1.1;
		this.setSpriteOffset("permanent_injury_5", this.createVec(2, -2));
		this.setAlwaysApplySpriteOffset(true);
	}

	function onTurnEnd()
	{
		this.actor.onTurnEnd();
		if (this.Tactical.Entities.isEnemyRetreating() || this.Tactical.State.isAutoRetreat() || !this.m.IsAlive || this.m.IsDying)
		{
			return;
		}
		this.actor.getSkills().add(this.new("scripts/skills/effects/ai_spearwall_effect"));
		this.actor.getSkills().add(this.new("scripts/skills/effects/riposte_effect"));
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
			local decal;
			for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
			{
				decal = _tile.spawnDetail(this.Const.CorpsePart[i]);
				decal.Scale = 1.15;
			}
			this.spawnTerrainDropdownEffect(_tile);
			this.spawnBloodPool(_tile, 1);
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});

