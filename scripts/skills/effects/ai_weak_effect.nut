this.ai_weak_effect <- this.inherit("scripts/skills/skill", {
//sb_mark, sbp_agile, sbp_beater, xxitem_meteoraa
	m = {
		Count = 1,
		TurnsLeft = 2,
		TurnsBase = 2
	},
	function create()
	{
		this.m.ID = "effects.ai_weak_effect";
		this.m.Name = "Expose Weakness (" + this.m.Count + " Stack)";
		this.m.Icon = "skills/status_effect_53.png";
		this.m.IconMini = "status_effect_53_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has reduced melee and ranged defense for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function getTooltip()
	{
		return [
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
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.Math.maxf(1, 1 * this.m.Count) + "%[/color] melee and ranged defense"
			}
		];
	}

	function onRefresh()
	{
		++this.m.Count;
		this.m.TurnsLeft = this.m.TurnsBase;
		this.m.Name = "Expose Weakness (" + this.m.Count + " Stack)";
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense -= this.Math.maxf(1, 1 * this.m.Count);
		_properties.RangedDefense -= this.Math.maxf(1, 1 * this.m.Count);
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

