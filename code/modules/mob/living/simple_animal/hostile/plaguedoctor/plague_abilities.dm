///ripped from paper wizard code
/datum/action/cooldown/spell/conjure/plague_summon_minions
	name = "Summon Cured Ones"
	button_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	button_icon_state = "art_summon"
	invocation = "Come forth cured ones; fend the sickly off!"
	invocation_type = INVOCATION_SHOUT
	spell_requirements = NONE
	cooldown_time = 15 SECONDS
	summon_type = list(
		/mob/living/simple_animal/hostile/zombie/minion_zombies/zombieprisoner,
		/mob/living/simple_animal/hostile/zombie/minion_zombies/zombielguard,
		/mob/living/simple_animal/hostile/zombie/minion_zombies/zombiehguard,
		/mob/living/simple_animal/hostile/zombie/minion_zombies/zombiescientist,
	)
	summon_radius = 1
	summon_amount = 2
	///How many minions we summoned
	var/summoned_minions = 0
	///How many minions we can have at once
	var/max_minions = 6


/datum/action/cooldown/spell/conjure/plague/can_cast_spell(feedback = TRUE)
	. = ..()
	if(!.)
		return FALSE
	if(summoned_minions >= max_minions)
		return FALSE
	return TRUE

/datum/action/cooldown/spell/conjure/plague_summon_minions/post_summon(atom/summoned_object, atom/cast_on)
	var/mob/living/chosen_minion = summoned_object
	RegisterSignals(chosen_minion, list(COMSIG_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(lost_minion))
	summoned_minions++

/datum/action/cooldown/spell/conjure/plague_summon_minions/proc/lost_minion(mob/source)
	SIGNAL_HANDLER

	UnregisterSignal(source, list(COMSIG_QDELETING, COMSIG_LIVING_DEATH))
	summoned_minions--



