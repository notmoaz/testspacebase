///ripped from paper wizard code
/mob/living/simple_animal/hostile/plaguedoctor/plague_doctor
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


/mob/living/simple_animal/hostile/plaguedoctor/Initialize(mapload)
	. = ..()
	apply_dynamic_human_appearance(src, mob_spawn_path = /obj/effect/mob_spawn/corpse/human/plaguedoctormob)
	grant_abilities()


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



