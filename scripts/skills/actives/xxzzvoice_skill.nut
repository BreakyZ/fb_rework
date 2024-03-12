this.xxzzvoice_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.xxzzvoice_skill";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsAttack = false,
		this.m.IsWeaponSkill = false,
		this.m.IsStacking = false;
		this.m.IsSerialized = true;
		this.m.IsHidden = true;
	}

	function onCombatStarted()
	{
	   local actor = this.getContainer().getActor();
	   if (actor.getFlags().has("xxzzvoice_girl"))
	   {
		actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/ghost_death_01.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/ghost_death_02.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Fatigue] = [
			"sounds/enemies/ghastly_touch_01.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/skeleton_idle_01.wav",
			"sounds/enemies/skeleton_idle_04.wav"
		];
		actor.m.Sound[this.Const.Sound.ActorEvent.NoDamageReceived] = actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
		actor.m.Sound[this.Const.Sound.ActorEvent.Flee] = actor.m.Sound[this.Const.Sound.ActorEvent.DamageReceived];
	   }
	}
});

