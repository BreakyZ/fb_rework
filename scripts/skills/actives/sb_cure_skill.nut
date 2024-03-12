this.sb_cure_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Skillcharge = 2
	},
	function create()
	{
		this.m.ID = "actives.sb_cure_skill";
		this.m.Name = "Battle Cure";
		this.m.Description = "Removes various negative effects. \n[color=#8f1e1e]Requires:[/color] 100 Crowns";
		this.m.Icon = "ui/xx65.png";
		this.m.IconDisabled = "ui/xx65_sw.png";
		this.m.Overlay = "active_96";
		this.m.SoundOnUse = [
			"sounds/combat/drink_01.wav",
			"sounds/combat/drink_02.wav",
			"sounds/combat/drink_03.wav"
		];
		this.m.SoundVolume = 3;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Removed effects: \n#Temporary injuries, #Damage over time, #Acid, #Goblin poison, #Stunned, #Dazed, #Staggered, #Other various debuffs"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can be used [color=#8f1e1e]" + this.m.Skillcharge + "[/color] more times in this battle."
		});
		if (this.Tactical.isActive())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/asset_money.png",
				text = "Own [color=#e6b71e]" + this.World.Assets.getMoney() + "[/color] crowns"
			});
		}
		return ret;
	}

	function getCursorForTile( _tile )
	{
		return this.Const.UI.Cursor.Drink;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcharge = this.m.Skillcharge - 1
		this.World.Assets.addMoney(-100);
		local target = _targetTile.getEntity();
		target.getSkills().removeByType(this.Const.SkillType.TemporaryInjury);
		target.getSkills().removeByType(this.Const.SkillType.SemiInjury);
		target.getSkills().removeByType(this.Const.SkillType.DamageOverTime);
		while (target.getSkills().hasSkill("effects.goblin_poison"))
		{
			target.getSkills().removeByID("effects.goblin_poison");
		}
		while (target.getSkills().hasSkill("effects.acid"))
		{
			target.getSkills().removeByID("effects.acid");
		}
		target.getSkills().removeByID("effects.stunned");
		target.getSkills().removeByID("effects.dazed");
		target.getSkills().removeByID("effects.staggered");
		target.getSkills().removeByID("effects.chilled");
		target.getSkills().removeByID("effects.charmed");
		target.getSkills().removeByID("effects.disarmed");
		target.getSkills().removeByID("effects.distracted");
		target.getSkills().removeByID("effects.hex_slave");
		target.getSkills().removeByID("effects.horrified");
		target.getSkills().removeByID("effects.insect_swarm");
		target.getSkills().removeByID("effects.overwhelmed");
		target.getSkills().removeByID("effects.withered");
		target.getSkills().removeByID("effects.ai_weak_effect");
		target.setDirty(true);
		target.onUpdateInjuryLayer();
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}
		if (!this.m.Container.getActor().isAlliedWith(_targetTile.getEntity()))
		{
			return false;
		}
		return true;
	}

	function isUsable()
	{
		if (this.m.Skillcharge <= 0)
		{
			return false;
		}
		if (this.World.Assets.getMoney() < 100)
		{
			return false;
		}
		return true;
	}

	function isHidden()
	{
		if (this.m.Skillcharge > 0)
		{
			return false;
		}
		return true;
	}

	function onCombatFinished()
	{
		this.m.Skillcharge = 2;
	}

});

