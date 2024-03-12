this.sbp_prudence_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sbp_prudence_skill";
		this.m.Name = "Prudence (passive)";
		this.m.Icon = "ui/xxp24.png";
		this.m.Description = "This character decides every action carefully and remains cool-headed.";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsSerialized = true;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
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
			}
		];
		ret.push({
			id = 3,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=#135213]+10[/color] Melee Defense"
		});
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "When [color=#8f1e1e]Fleeing[/color] state: [color=#135213]50%[/color] chance become [color=#135213]Breaking[/color] state at start of turn"
		});
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = "[color=#8f1e1e]+1[/color] Additional Action Point per tile moved"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 10;
		_properties.MovementAPCostAdditional += 1;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		if (actor.getMoraleState() == this.Const.MoraleState.Fleeing && this.Math.rand(1, 100) <= 50)
		{
			actor.setMoraleState(this.Const.MoraleState.Breaking);
		}
	}

});

