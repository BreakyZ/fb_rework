this.ai_demonkingbuff <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ai_demonkingbuff";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsStacking = false;
	}

	function onAdded()
	{
		if (this.m.Container.hasSkill("actives.hand_to_hand"))
		{
			this.m.Container.removeByID("actives.hand_to_hand");
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		actor.getBaseProperties().MeleeSkill += 7;
		actor.getSkills().add(this.new("scripts/skills/actives/ai_fakebuff"));
	}

});

