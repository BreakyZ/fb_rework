this.ai_knightbuff <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.ai_knightbuff";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsStacking = false;
		this.m.SoundOnUse = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
	}

	function onTurnStart()
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}
		local actor = this.getContainer().getActor();
		actor.getBaseProperties().MeleeSkill += 2;
		actor.getBaseProperties().MeleeDefense += 2;
		actor.getBaseProperties().Hitpoints += 10;
		actor.getBaseProperties().DamageRegularMin += 2;
		actor.getBaseProperties().DamageRegularMax += 2;
		actor.getSkills().add(this.new("scripts/skills/actives/ai_fakebuff"));
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, this.getContainer().getActor().getPos());
	}

});

