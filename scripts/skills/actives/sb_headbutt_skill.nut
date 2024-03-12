this.sb_headbutt_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sb_headbutt_skill";
		this.m.Name = "Headbutt";
		this.m.Description = "Deals damage to a single target. Damage is affected by the caster\'s current fatigue. Always hits the head. Melee hit chance.";
		this.m.Icon = "ui/xx31.png";
		this.m.IconDisabled = "ui/xx31_sw.png";
		this.m.Overlay = "active_52";
		this.m.SoundOnUse = [
			"sounds/enemies/lindwurm_tail_slam_01.wav",
			"sounds/enemies/lindwurm_tail_slam_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/lindwurm_tail_slam_hit_01.wav",
			"sounds/enemies/lindwurm_tail_slam_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted + 228;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Damage: [color=" + this.Const.UI.Color.PositiveValue + "]50% of Caster\'s current used fatigue + 10 ~ 20[/color]"
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		this.Sound.play("sounds/combat/indomitable_0" + this.Math.rand(1, 2) + ".wav", this.Const.Sound.Volume.Skill * 1.5, this.getContainer().getActor().getPos());
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local actor = this.getContainer().getActor();
			local mainh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offh = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			local sdmg = this.Math.floor(actor.getFatigue() * 0.5);
			_properties.DamageRegularMin = sdmg + 10;
			_properties.DamageRegularMax = sdmg + 20;
			_properties.DamageArmorMult = 1.5;
			if (actor.getSkills().hasSkill("perk.duelist"))
			{
				if (offh == null || offh.isItemType(this.Const.Items.ItemType.Tool))
				{
					_properties.DamageDirectAdd -= 0.25;
				}
			}
			if (mainh != null && offh == null && mainh.isDoubleGrippable())
			{
				_properties.DamageTotalMult /= 1.25;
			}
			_properties.HitChance[this.Const.BodyPart.Head] += 100.0;
		}
	}

});

