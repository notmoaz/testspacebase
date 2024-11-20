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
