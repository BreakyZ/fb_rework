this.ai_demonbuff <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ai_demonbuff";
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
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}
		local actor = this.getContainer().getActor();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}
			ally.getBaseProperties().MeleeSkill += 2;
			ally.getBaseProperties().RangedSkill += 2;
			ally.getSkills().add(this.new("scripts/skills/actives/ai_fakebuff"));
		}
	}

});

