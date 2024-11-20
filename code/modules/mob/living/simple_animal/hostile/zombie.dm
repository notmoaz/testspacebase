/mob/living/simple_animal/hostile/zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk in outer space."
	icon = 'icons/mob/simple/simple_human.dmi'
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	stat_attack = HARD_CRIT //braains
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 21
	melee_damage_upper = 21
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	istate = ISTATE_HARM|ISTATE_BLOCKING
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	bodytemp_cold_damage_limit = -1
	status_flags = CANPUSH
	death_message = "collapses, flesh gone in a pile of bones!"
	del_on_death = TRUE
	loot = list(/obj/effect/decal/remains/human)
	/// The probability that we give people real zombie infections on hit.
	var/infection_chance = 0
	/// Outfit the zombie spawns with for visuals.
	var/outfit = /datum/outfit/corpse_doctor

/mob/living/simple_animal/hostile/zombie/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, outfit, /datum/species/zombie, bloody_slots = ITEM_SLOT_OCLOTHING)

/mob/living/simple_animal/hostile/zombie/AttackingTarget()
	. = ..()
	if(. && ishuman(target) && prob(infection_chance))
		try_to_zombie_infect(target)

/datum/outfit/corpse_doctor
	name = "Corpse Doctor"
	suit = /obj/item/clothing/suit/toggle/labcoat
	uniform = /obj/item/clothing/under/rank/medical/doctor
	shoes = /obj/item/clothing/shoes/sneakers/white
	back = /obj/item/storage/backpack/medic

/datum/outfit/corpse_assistant
	name = "Corpse Assistant"
	mask = /obj/item/clothing/mask/gas
	uniform = /obj/item/clothing/under/color/grey
	shoes = /obj/item/clothing/shoes/sneakers/black
	back = /obj/item/storage/backpack


/// for plague doctor ability

/mob/living/simple_animal/hostile/zombie/minion_zombies
	name = "Mutilated Corpse"
	desc = "One of the doctors 'cured' ones."
	icon = 'icons/mob/simple/simple_human.dmi'
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	faction = list(FACTION_HOSTILE, FACTION_PLAGUE)
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	stat_attack = HARD_CRIT
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "slashes"
	attack_verb_simple = "bite"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE
	istate = ISTATE_HARM|ISTATE_BLOCKING
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	bodytemp_cold_damage_limit = -1
	status_flags = CANPUSH
	death_message = "collapses, flesh gone in a pile of bones!"
	del_on_death = TRUE


/mob/living/simple_animal/hostile/zombie/minion_zombies/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, outfit, /datum/species/zombie, bloody_slots = ITEM_SLOT_OCLOTHING)

/mob/living/simple_animal/hostile/zombie/minion_zombies/AttackingTarget()
	. = ..()
	if(. && ishuman(target) && prob(infection_chance))
		try_to_zombie_infect(target)

/mob/living/simple_animal/hostile/zombie/minion_zombies/zombieprisoner
	name = "Cured Prisoner"
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "weakly slashes"
	attack_verb_simple = "slash"
	footstep_type = FOOTSTEP_MOB_SHOE
	outfit = /datum/outfit/dclassoutfit

/mob/living/simple_animal/hostile/zombie/minion_zombies/zombielguard
	name = "Cured Facility Guard"
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	footstep_type = FOOTSTEP_MOB_SHOE
	outfit = /datum/outfit/lightguardcorpse

/mob/living/simple_animal/hostile/zombie/minion_zombies/zombiehguard
	name = "Cured Facility Guard"
	melee_damage_lower = 21
	melee_damage_upper = 25
	attack_verb_continuous = "strongly slashes"
	attack_verb_simple = "slash"
	footstep_type = FOOTSTEP_MOB_SHOE
	outfit = /datum/outfit/heavyguardcorpse

/mob/living/simple_animal/hostile/zombie/minion_zombies/zombiescientist
	name = "Cured Scientist"
	melee_damage_lower = 15
	melee_damage_upper = 15
	attack_verb_continuous = "weakly slashes"
	attack_verb_simple = "slash"
	footstep_type = FOOTSTEP_MOB_SHOE
	outfit = /datum/outfit/scpscientistcorpse

/mob/living/simple_animal/hostile/zombie/minion_zombies/zombiemanager
	name = "Cured Manager"
	melee_damage_lower = 15
	melee_damage_upper = 17
	attack_verb_continuous = "weakly slashes"
	attack_verb_simple = "slash"
	footstep_type = FOOTSTEP_MOB_SHOE
	outfit = /datum/outfit/facilitymanagercorpse


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





/mob/living/simple_animal/hostile/zombie/minion_zombies/plague_doctor
	name = "The Plague Doctor"
	desc = "A mysterious figure with a birdmask and a tattered, old black coat ."
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	faction = list(FACTION_HOSTILE, FACTION_PLAGUE)
	gender = MALE

	response_help_continuous = "tries to poke"
	response_help_simple = "tries to poke"
	response_disarm_continuous = "pushes"
	response_disarm_simple = "push"
	///basic_mob_flags = DEL_ON_DEATH

	maxHealth = 1000
	health = 1000
	melee_damage_lower = 5
	melee_damage_upper = 10
	obj_damage = 50
	attack_sound = 'sound/hallucinations/growl3.ogg'
	ai_controller = /datum/ai_controller/basic_controller/plague_doctor
	///spell to summon minions
	var/datum/action/cooldown/spell/conjure/plague_summon_minions/summon


/mob/living/simple_animal/hostile/zombie/minion_zombies/plaguedoctor/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, mob_spawn_path = /obj/effect/mob_spawn/corpse/human/plaguedoctormob)
	grant_abilities()


/mob/living/simple_animal/hostile/zombie/minion_zombies/proc/grant_abilities()
	summon = new(src)
	summon.Grant(src)
	ai_controller.set_blackboard_key(BB_WIZARD_SUMMON_MINIONS, summon)

/mob/living/simple_animal/hostile/plaguedoctor/proc/grant_abilities()
	summon = new(src)
	summon.Grant(src)
	ai_controller.set_blackboard_key(BB_WIZARD_SUMMON_MINIONS, summon)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/less_walking
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/use_mob_ability/plague_summon_minions,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/attack_obstacle_in_path/plague_doctor,
	)


/datum/ai_planning_subtree/use_mob_ability/plague_summon_minions
	ability_key = BB_WIZARD_SUMMON_MINIONS
	finish_planning = FALSE

