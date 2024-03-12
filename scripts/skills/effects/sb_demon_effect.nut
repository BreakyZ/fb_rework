this.sb_demon_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.sb_demon_effect";
		this.m.Name = "Demonized";
		this.m.Description = "This character demonizes himself with an evil sorcery and gains great abilities. But terrible things can happen to this character after a battle.";
		this.m.Icon = "skills/status_effect_84.png";
		this.m.IconMini = "status_effect_84_mini";
		this.m.SoundOnUse = [
			"sounds/enemies/orc_charge_01.wav",
			"sounds/enemies/orc_charge_02.wav",
			"sounds/enemies/orc_charge_03.wav",
			"sounds/enemies/orc_charge_04.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.hasSprite("permanent_injury_xx1"))
		{
			actor.getSprite("permanent_injury_xx1").Visible = false;
			actor.removeSprite("permanent_injury_xx1");
		}
		if (actor.hasSprite("permanent_injury_xx2"))
		{
			actor.getSprite("permanent_injury_xx2").Visible = false;
			actor.removeSprite("permanent_injury_xx2");
		}
		actor.addSprite("permanent_injury_xx1");
		actor.getSprite("permanent_injury_xx1").setBrush("zombie_rage_eyes");
		actor.getSprite("permanent_injury_xx1").Visible = true;
		actor.getSprite("permanent_injury_xx1").Color = this.createColor("#1aff00");
		actor.getSprite("permanent_injury_xx1").Saturation = 0.5;
		actor.addSprite("permanent_injury_xx2");
		actor.getSprite("permanent_injury_xx2").setBrush("xxhorn_1");
		actor.getSprite("permanent_injury_xx2").Visible = true;
		actor.getSprite("permanent_injury_xx2").Color = this.createColor("#7d0000");
		actor.getSprite("permanent_injury_xx2").Saturation = 1.1;
		actor.getSprite("tattoo_body").setBrush("scar_01_bust_naked_body_00");
		actor.getSprite("tattoo_body").Visible = true;
		actor.getSprite("tattoo_body").Color = this.createColor("#8cff00");
		actor.getSprite("tattoo_body").Saturation = 0.9;
		local tattoo_head_type = [
			"zombify_01",
			"",
			""
		];
		actor.getSprite("tattoo_head").setBrush(tattoo_head_type[this.Math.rand(0, tattoo_head_type.len() - 1)]);
		actor.getSprite("tattoo_head").Visible = true;
		actor.getSprite("tattoo_head").Color = this.createColor("#c9ff87");
		actor.getSprite("tattoo_head").Saturation = 0.7;
		local xhead = actor.getSprite("head");
		local xbody = actor.getSprite("body");
		xhead.Color = this.createColor("#850000");
		xhead.Saturation = 0.8;
		xbody.Color = this.createColor("#7d0000");
		xbody.Saturation = 0.8;
		if (actor.hasSprite("arms_icon"))
		{
			actor.removeSprite("arms_icon");
			actor.addSprite("arms_icon")
			actor.getItems().updateAppearance();
		}
	}

	function onAfterUpdate( _properties )
	{
		_properties.MeleeSkill += 30;
		_properties.RangedSkill += 30;
		_properties.Hitpoints += 100;
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		if (actor.hasSprite("permanent_injury_xx1"))
		{
			actor.getSprite("permanent_injury_xx1").Visible = false;
			actor.removeSprite("permanent_injury_xx1");
		}
		if (actor.hasSprite("permanent_injury_xx2"))
		{
			actor.getSprite("permanent_injury_xx2").Visible = false;
			actor.removeSprite("permanent_injury_xx2");
		}
		actor.getSprite("tattoo_head").setBrush("");
		actor.getSprite("tattoo_head").Color = this.createColor("#ffffff");
		actor.getSprite("tattoo_head").Saturation = 1.0;
		actor.getSprite("tattoo_head").Visible = false;
		actor.getSprite("tattoo_body").setBrush("");
		actor.getSprite("tattoo_body").Color = this.createColor("#ffffff");
		actor.getSprite("tattoo_body").Saturation = 1.0;
		actor.getSprite("tattoo_body").Visible = false;
		actor.getSprite("head").Saturation = 0.4;
		actor.getSprite("head").Color = this.createColor("#ffffff");
		actor.getSprite("body").Saturation = 0.4;
		actor.getSprite("body").Color = this.createColor("#ffffff");
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		actor.getBaseProperties().Armor[this.Const.BodyPart.Head] = 0;
		actor.getBaseProperties().Armor[this.Const.BodyPart.Body] = 0;
		actor.getBaseProperties().ArmorMax[this.Const.BodyPart.Head] = 0;
		actor.getBaseProperties().ArmorMax[this.Const.BodyPart.Body] = 0;
		if (this.Math.rand(1, 100) <= 22)
		{
			actor.kill(actor, this, this.Const.FatalityType.Decapitated);
		}
		else
		{
			if (!actor.getSkills().hasSkill("effects.afraid") && this.Math.rand(1, 100) <= 30)
			{
				actor.getSkills().add(this.new("scripts/skills/effects_world/afraid_effect"));
			}
			else if (!actor.getSkills().hasSkill("effects.hangover") && this.Math.rand(1, 100) <= 20)
			{
				actor.getSkills().add(this.new("scripts/skills/effects_world/hangover_effect"));
			}
			if (!actor.getSkills().hasSkill("injury.traumatized") && this.Math.rand(1, 100) <= 10)
			{
				actor.getSkills().add(this.new("scripts/skills/injury_permanent/traumatized_injury"));
			}
			else if (!actor.getSkills().hasSkill("injury.broken_elbow_joint") && this.Math.rand(1, 100) <= 10)
			{
				actor.getSkills().add(this.new("scripts/skills/injury_permanent/broken_elbow_joint_injury"));
			}
			else if (!actor.getSkills().hasSkill("injury.broken_knee") && this.Math.rand(1, 100) <= 10)
			{
				actor.getSkills().add(this.new("scripts/skills/injury_permanent/broken_knee_injury"));
			}
			else if (!actor.getSkills().hasSkill("injury.weakened_heart") && this.Math.rand(1, 100) <= 10)
			{
				actor.getSkills().add(this.new("scripts/skills/injury_permanent/weakened_heart_injury"));
			}
			else if (actor.getBaseProperties().Hitpoints > 1 && this.Math.rand(1, 100) <= 30)
			{
				actor.getBaseProperties().Hitpoints -= 1;
			}
		}
		this.removeSelf();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), this.Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), this.Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

});

