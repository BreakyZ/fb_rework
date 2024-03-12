this.sb_frenzy_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.sb_frenzy_effect";
		this.m.Name = "Wicked Frenzy";
		this.m.Description = "[color=#135213]+25%[/color]% Damage when attacking enemies within 1 tile, [color=#8f1e1e]-10%[/color] Melee skill, [color=#8f1e1e]-10[/color] Ranged skill, [color=#8f1e1e]-10%[/color] Melee defense, [color=#8f1e1e]-10%[/color] Ranged defense";
		this.m.Icon = "ui/perks/perk_36.png";
		this.m.IconMini = "perk_36_mini";
		this.m.Overlay = "perk_36";
		this.m.SoundOnUse = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += -10;
		_properties.RangedSkill += -10;
		_properties.MeleeDefense += -10;
		_properties.RangedDefense += -10;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (_skill.isAttack())
		{
			local d = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());
			if (d == 1)
			{
				_properties.DamageTotalMult += 0.25;
			}
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.hasSprite("permanent_injury_frz1"))
		{
			actor.getSprite("permanent_injury_frz1").Visible = false;
			actor.removeSprite("permanent_injury_frz1");
		}
		actor.addSprite("permanent_injury_frz1");
		actor.getSprite("permanent_injury_frz1").setBrush("zombie_rage_eyes");
		actor.getSprite("permanent_injury_frz1").Visible = true;
		actor.getSprite("permanent_injury_frz1").Color = this.createColor("#00ff95");
		actor.getSprite("permanent_injury_frz1").Alpha = 155;
		if (actor.hasSprite("arms_icon"))
		{
			actor.removeSprite("arms_icon");
			actor.addSprite("arms_icon")
			actor.getItems().updateAppearance();
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		if (actor.hasSprite("permanent_injury_frz1"))
		{
			actor.getSprite("permanent_injury_frz1").Visible = false;
			actor.removeSprite("permanent_injury_frz1");
		}
	}

});

