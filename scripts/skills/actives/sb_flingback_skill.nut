this.sb_flingback_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 3,
		Skillcool = 3
	},
	function create()
	{
		this.m.ID = "actives.sb_flingback_skill";
		this.m.Name = "Fling Back";
		this.m.Description = "Throws the target behind the caster, dealing damage. The caster moves to the location where the target was originally. On hit, staggers the target and removes shieldwall / spearwall / riposte.";
		this.m.Icon = "ui/xx34.png";
		this.m.IconDisabled = "ui/xx34_sw.png";
		this.m.Overlay = "active_111";
		this.m.SoundOnUse = [
			"sounds/enemies/unhold_fling_01.wav",
			"sounds/enemies/unhold_fling_02.wav",
			"sounds/enemies/unhold_fling_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.Delay = 750;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.HitChanceBonus = 15;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "+15% Additional hit chance. (Melee hit chance)"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage: [color=" + this.Const.UI.Color.PositiveValue + "]1 ~ 150[/color] (150% armor damage)"
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Cooldown: 3 turn \nCooldown left: [color=#8f1e1e]" + this.Math.max(0, (this.m.Cooldown - this.m.Skillcool)) + "[/color] turn"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Skillcool = 0;
		local target = _targetTile.getEntity();

		_user.getCurrentProperties().DamageRegularMin = 0;
		_user.getCurrentProperties().DamageRegularMax = 0;
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		if (!this.attackEntity(_user, target, false))
		{
			return false;
		}
		this.m.SoundOnHit = [
			"sounds/combat/smash_hit_01.wav"
		];

		local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);
		if (knockToTile == null)
		{
			return false;
		}

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
		{
			return false;
		}

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " moved " + this.Const.UI.getColorizedEntityName(target));
		}

		if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has staggered " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
		}
		target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));

		local skills = target.getSkills();
		skills.removeByID("effects.shieldwall");
		skills.removeByID("effects.spearwall");
		skills.removeByID("effects.riposte");

		local tag = {
			Attacker = _user,
			TargetTile = _targetTile,
			Skill = this
		};
		target.setCurrentMovementType(this.Const.Tactical.MovementType.Involuntary);
		this.Tactical.getNavigator().teleport(target, knockToTile, this.onKnockedDown, tag, true, 1.5);
		return true;
	}

	function onKnockedDown( _entity, _tag )
	{
		if (_tag.Attacker.isAlive() && !_tag.Attacker.isDying() && _entity.isAlive() && !_entity.isDying() && _entity.isAttackable())
		{
			_tag.Attacker.getCurrentProperties().MeleeSkill = 500;
			_tag.Attacker.getCurrentProperties().DamageRegularMin = 1;
			_tag.Attacker.getCurrentProperties().DamageRegularMax = 150;
			_tag.Attacker.getCurrentProperties().DamageArmorMult = 1.5;
			_tag.Skill.attackEntity(_tag.Attacker, _entity, false);
		}
		if (_tag.Attacker.isAlive() && _tag.TargetTile.IsEmpty)
		{
			_tag.Attacker.setCurrentMovementType(this.Const.Tactical.MovementType.Default);
			this.Tactical.getNavigator().teleport(_tag.Attacker, _tag.TargetTile, null, null, false, 3);
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0;
			_properties.HitChanceMult[this.Const.BodyPart.Body] = 1;
			_properties.DamageDirectAdd = 0;
			_properties.DamageDirectMeleeAdd = 0;
			_properties.DamageDirectRangedAdd = 0;
			_properties.DamageDirectMult = 1;
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			if (mainh != null && offh == null && mainh.isDoubleGrippable())
			{
				_properties.DamageTotalMult /= 1.25;
			}
			_properties.MeleeSkill += 15;
		}
	}

	function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local dir = _targetTile.getDirectionTo(_userTile);

		if (_userTile.hasNextTile(dir))
		{
			local flingToTile = _userTile.getNextTile(dir);

			if (flingToTile.IsEmpty && this.Math.abs(flingToTile.Level - _userTile.Level) <= 1)
			{
				return flingToTile;
			}
		}

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;

		if (_userTile.hasNextTile(altdir))
		{
			local flingToTile = _userTile.getNextTile(altdir);

			if (flingToTile.IsEmpty && this.Math.abs(flingToTile.Level - _userTile.Level) <= 1)
			{
				return flingToTile;
			}
		}

		altdir = dir + 1 <= 5 ? dir + 1 : 0;

		if (_userTile.hasNextTile(altdir))
		{
			local flingToTile = _userTile.getNextTile(altdir);

			if (flingToTile.IsEmpty && this.Math.abs(flingToTile.Level - _userTile.Level) <= 1)
			{
				return flingToTile;
			}
		}

		return null;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsRooted && !_targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab && this.findTileToKnockBackTo(_originTile, _targetTile) != null;
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
		else if (this.getContainer().getActor().getCurrentProperties().IsRooted)
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

});

