this.sb_wolfride_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 15,
		Skillcool = 15
	},
	function create()
	{
		this.m.ID = "actives.sb_wolfride_skill";
		this.m.Name = "Riding a Giant Wolf";
		this.m.Description = "Ride a giant wolf and defeat your enemies.";
		this.m.Icon = "ui/xx23.png";
		this.m.IconDisabled = "ui/xx23_sw.png";
		this.m.SoundOnUse = [
			"sounds/enemies/wardog_charge_00.wav",
			"sounds/enemies/wardog_charge_01.wav",
			"sounds/enemies/wardog_charge_02.wav"
		];
		this.m.SoundVolume = 0.9;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 35;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/special.png",
				text = "While riding on a wolf: -1 Move AP, No fatigue when moving on flat ground, Add a \'Bite\' skill, +10 Melee skill when after Level 10"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Lasts for 3 turns"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Cooldown : 15 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
			}
		];
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		this.m.Container.add(this.new("scripts/skills/effects/sb_wolfride_effect"));
		return true;
	}

	function isHidden()
	{
		if (this.m.Container.getActor().isPlacedOnMap())
		{
			local actorsk = this.getContainer();
			if (actorsk.hasSkill("effects.sb_wolfride_effect") || actorsk.hasSkill("effects.xxitem_horse_skill"))
			{
				return true;
			}
			return false;
		}
		return false;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}
		else
		if (this.m.Skillcool < this.m.Cooldown)
		{
			return false;
		}
		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("effects.sb_wolfride_effect") || actor.getSkills().hasSkill("effects.xxitem_horse_skill"))
		{
			return false;
		}		
		return true;
	}

	function onTurnStart()
	{
		this.m.Skillcool = this.m.Skillcool + 1;
	}

	function onCombatFinished()
	{
		this.m.Skillcool = this.m.Cooldown;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.sb2_wolfride_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/sb2_wolfride_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.sb2_wolfride_skill");
	}

});

