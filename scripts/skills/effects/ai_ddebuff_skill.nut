this.ai_ddebuff_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Count = 1
	},
	function create()
	{
		this.m.ID = "effects.ai_ddebuff_skill";
		this.m.Name = "Dungeon Debuff";
		this.m.Description = "This character takes more damage from enemies and has a reduced chance to hit and dodge.";
		this.m.Icon = "skills/status_effect_52.png";
		this.m.IconMini = "status_effect_52_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		if (this.m.Count <= 1)
		{
			return this.m.Name;
		}
		else
		{
			return this.m.Name + " (x" + this.m.Count + ")";
		}
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
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 2 + "[/color] Melee and Ranged Skill"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 4 + "[/color] Melee and Ranged Defense"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + ((this.m.Count * 0.05) + 1) * 100 + "%[/color] Damage Taken"
			}
		];
	}

	function setTurns( _t )
	{
		if (this.getContainer() != null)
		{
			this.m.Count = this.Math.max(1, _t);
		}
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += -2 * this.m.Count;
		_properties.RangedSkill += -2 * this.m.Count;
		_properties.MeleeDefense += -4 * this.m.Count;
		_properties.RangedDefense += -4 * this.m.Count;
		_properties.DamageReceivedTotalMult *= (this.m.Count * 0.05) + 1;
	}

});

