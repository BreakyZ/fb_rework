this.xxmob_archlich <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Name = "Arch Lich";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.XP = this.Const.Tactical.Actor.SkeletonBoss.XP;
		this.m.BloodType = this.Const.BloodType.Bones;
		this.human.create();
		this.m.Faces = null;
		this.m.Hairs = null;
		this.m.HairColors = null;
		this.m.Beards = null;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/skeleton_priest_agent");
		this.m.AIAgent.setActor(this);
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/skeleton_hurt_01.wav",
			"sounds/enemies/skeleton_hurt_02.wav",
			"sounds/enemies/skeleton_hurt_03.wav",
			"sounds/enemies/skeleton_hurt_04.wav",
			"sounds/enemies/skeleton_hurt_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/skeleton_death_01.wav",
			"sounds/enemies/skeleton_death_02.wav",
			"sounds/enemies/skeleton_death_03.wav",
			"sounds/enemies/skeleton_death_04.wav",
			"sounds/enemies/skeleton_death_05.wav",
			"sounds/enemies/skeleton_death_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/skeleton_rise_01.wav",
			"sounds/enemies/skeleton_rise_02.wav",
			"sounds/enemies/skeleton_rise_03.wav",
			"sounds/enemies/skeleton_rise_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_02.wav",
			"sounds/enemies/skeleton_idle_03.wav",
			"sounds/enemies/skeleton_idle_04.wav",
			"sounds/enemies/skeleton_idle_05.wav",
			"sounds/enemies/skeleton_idle_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.getFlags().add("undead");
		this.getFlags().add("skeleton");
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonPriest);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.Hitpoints += 900;
		b.MeleeDefense += 10;
		b.Bravery += 500;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.setAppearance();

		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.getSprite("body");
		body.setBrush("bust_skeleton_body_03");
		body.Saturation = 0.8;
		if (this.Math.rand(0, 100) < 75)
		{
			body.varySaturation(0.2);
		}
		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.025, 0.025, 0.025);
		}
		this.m.BloodColor = body.Color;
		this.m.BloodSaturation = body.Saturation;
		local tattoo_body = this.getSprite("tattoo_body");
		tattoo_body.setBrush("bust_desert_noble_03");
		local surcoat = this.getSprite("surcoat");
		surcoat.setBrush("bust_body_72");
		this.getSprite("armor");
		local head = this.getSprite("head");
		head.setBrush("bust_skeleton_head_04");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local tattoo_head = this.getSprite("tattoo_head");
		tattoo_head.setBrush("bust_skeleton_face_03");
		tattoo_head.Scale = 0.95;
		local beard = this.getSprite("beard");
		beard.setBrush("bust_skeleton_face_04");
		beard.Scale = 0.95;
		local hair = this.getSprite("hair");
		hair.setBrush("helmet_desert_noble_03");
		hair.Scale = 0.95;
		beard.Visible = true;
		this.getSprite("helmet");
		this.getSprite("helmet_damage");
		local body_dirt = this.getSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.Visible = this.Math.rand(1, 100) <= 33;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("tattoo_head", this.createVec(0, 2));
		this.setSpriteOffset("beard", this.createVec(0, 2));
		this.setSpriteOffset("hair", this.createVec(0, 7));
		this.setAlwaysApplySpriteOffset(true);
		this.m.Skills.add(this.new("scripts/skills/actives/horror_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/miasma_skill"));
		local rrr = this.Math.rand(150, 200);
		b.Armor[this.Const.BodyPart.Head] += rrr;
		b.ArmorMax[this.Const.BodyPart.Head] += rrr;
		b.Armor[this.Const.BodyPart.Body] += rrr;
		b.ArmorMax[this.Const.BodyPart.Body] += rrr;
	}

	function onUpdateInjuryLayer()
	{
		local p = this.m.Hitpoints / this.getHitpointsMax();
		if (p < 0.8)
		{
			this.getSprite("body").setBrush("bust_skeleton_body_01");
			this.getSprite("head").setBrush("bust_skeleton_head");
		}
		else
		{
			this.getSprite("body").setBrush("bust_skeleton_body_05");
			this.getSprite("head").setBrush("bust_skeleton_head_04");
		}
		if (p < 0.4)
		{
			this.getSprite("tattoo_body").setBrush("bust_skeleton_body_injured");
			this.getSprite("surcoat").setBrush("bust_body_72_damaged");
		}
		else
		{
			this.getSprite("tattoo_body").setBrush("bust_desert_noble_03");
			this.getSprite("surcoat").setBrush("bust_body_72");
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.m.BloodType = this.Const.BloodType.Ash;
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);

		local flip = this.Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;
		if (_tile != null)
		{
			local decal = _tile.spawnDetail("bust_skeleton_vampire_dead", this.Const.Tactical.DetailFlag.Corpse, flip, false);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.Faction = this.getFaction();
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.IsHeadAttached = true;
			corpse.IsConsumable = true;
			corpse.IsResurrectable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}
	}

	function onTurnEnd()
	{
		this.actor.onTurnEnd();
		if (this.Tactical.Entities.isEnemyRetreating() || this.Tactical.State.isAutoRetreat() || !this.m.IsAlive || this.m.IsDying)
		{
			return;
		}

		local xxtile = this.actor.getTile();
		if (!xxtile.IsOccupiedByActor || xxtile.IsEmpty)
		{
			return;
		}
		///

		local mapSize = this.Tactical.getMapSize();
		local attempts = 0;
		local nn = 0;
		while (attempts++ < 800)
		{
			local x = this.Math.rand(this.Math.max(0, this.getTile().SquareCoords.X - 3), this.Math.min(mapSize.X - 1, this.getTile().SquareCoords.X + 3));
			local y = this.Math.rand(this.Math.max(0, this.getTile().SquareCoords.Y - 3), this.Math.min(mapSize.Y - 1, this.getTile().SquareCoords.Y + 3));
			if (!this.Tactical.isValidTileSquare(x, y))
			{
				continue;
			}
			local tile = this.Tactical.getTileSquare(x, y);
			if (nn < 1 && tile.IsEmpty && tile.Type != this.Const.Tactical.TerrainType.Impassable && this.getTile().getDistanceTo(tile) >= 1)
			{
				local sounds = [
					"sounds/enemies/gruesome_feast_01.wav",
					"sounds/enemies/gruesome_feast_02.wav",
					"sounds/enemies/gruesome_feast_03.wav"
				];
				local spawn;
				if (this.Math.rand(1, 3) == 2)
				{
					if (this.Math.rand(1, 2) == 1)
					{
						spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/skeleton_light", tile.Coords);
					}
					else
					{
						spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/zombie_nomad", tile.Coords);
					}

					spawn.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
					local weapons = [
						"weapons/scimitar",
						"weapons/shamshir",
						"weapons/oriental/two_handed_saif",
						"weapons/oriental/two_handed_scimitar"
					];
					spawn.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

					weapons = [
						"armor/oriental/assassin_robe",
						"armor/oriental/plated_nomad_mail",
						"armor/oriental/stitched_nomad_armor",
						"armor/oriental/leather_nomad_robe",
						"armor/oriental/nomad_robe",
						"armor/oriental/thick_nomad_robe"
					];
					spawn.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

					weapons = [
						"helmets/oriental/assassin_head_wrap",
						"helmets/oriental/nomad_leather_cap",
							"helmets/oriental/nomad_light_helmet",
						"helmets/oriental/nomad_reinforced_helmet",
						"helmets/oriental/leather_head_wrap",
						"helmets/oriental/nomad_head_wrap",
						"helmets/oriental/nomad_head_wrap"
					];
					spawn.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]))

					spawn.riseFromGround();
				}
				else
				{
					if (this.Math.rand(1, 2) == 1)
					{
						spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/xxsum_skeleton", tile.Coords);
						spawn.getSkills().add(this.new("scripts/skills/effects/adrenaline_effect"));
						spawn.riseFromGround();
					}
					else
					{
						spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/xxmob_skull", tile.Coords);
					}
				}
				spawn.setFaction(this.getFaction());
				spawn.m.XP = spawn.m.XP * 0;
				local allies = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());
				local selfkill = this.new("scripts/skills/effects/ai_selfkill_effect");
				spawn.m.Skills.add(selfkill);
				selfkill.setTurns(8);
				for( local i = 0; i < this.Const.Tactical.RaiseUndeadParticles.len(); i = ++i )
				{		
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.RaiseUndeadParticles[i].Brushes, tile, this.Const.Tactical.RaiseUndeadParticles[i].Delay, this.Const.Tactical.RaiseUndeadParticles[i].Quantity, this.Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseUndeadParticles[i].SpawnRate, this.Const.Tactical.RaiseUndeadParticles[i].Stages);
				}
				this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], 1.5, tile.Pos);
			}
			nn = ++nn;
			if (nn >= 1)
			{
				break;
			}
		}
		///

		local corpses = clone this.Tactical.Entities.getCorpses();
		foreach( c in corpses )
		{
			if (!c.IsEmpty)
			{
				continue;
			}
			if (!c.IsCorpseSpawned || !c.Properties.get("Corpse").IsConsumable)
			{
				continue;
			}
			if (c.IsVisibleForPlayer)
			{
				for( local i = 0; i < this.Const.Tactical.RaiseUndeadParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.RaiseUndeadParticles[i].Brushes, c, this.Const.Tactical.RaiseUndeadParticles[i].Delay, this.Const.Tactical.RaiseUndeadParticles[i].Quantity, this.Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseUndeadParticles[i].SpawnRate, this.Const.Tactical.RaiseUndeadParticles[i].Stages);
				}
			}
			if (!c.IsOccupiedByActor)
			{
				this.actor.setHitpoints(this.Math.min(this.actor.getHitpoints() + 50, this.actor.getHitpointsMax()));
				this.Tactical.Entities.removeCorpse(c);
				c.clear(this.Const.Tactical.DetailFlag.Corpse);
				c.Properties.remove("Corpse");
				c.Properties.remove("IsSpawningFlies");
				local spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/xxmob_skull", c.Coords);
				spawn.setFaction(this.getFaction());
				spawn.m.XP = spawn.m.XP * 0;
				local allies = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());
				local selfkill = this.new("scripts/skills/effects/ai_selfkill_effect");
				spawn.m.Skills.add(selfkill);
				local stun = this.new("scripts/skills/effects/ai_stun_effect");
				spawn.m.Skills.add(stun);
				stun.setTurns(2);
				selfkill.setTurns(8);
			}
		}
	}

});

