var/global/datum/body_build/default_body_build = new

/datum/body_build
	var/name		= "Default"

	var/genders		= list(MALE, FEMALE)
	var/index		= ""
	var/roboindex   = ""										// for slim and slim_alt BBs prothesis
	var/misk_icon	= 'icons/mob/mob.dmi'
	var/uniform_icon= 'icons/inv_slots/uniforms/mob.dmi'
	var/suit_icon	= 'icons/inv_slots/suits/mob.dmi'
	var/gloves_icon	= 'icons/inv_slots/gloves/mob.dmi'
	var/glasses_icon= 'icons/inv_slots/glasses/mob.dmi'
	var/ears_icon	= 'icons/inv_slots/ears/mob.dmi'
	var/mask_icon	= 'icons/inv_slots/masks/mob.dmi'
	var/hat_icon	= 'icons/inv_slots/hats/mob.dmi'
	var/shoes_icon	= 'icons/inv_slots/shoes/mob.dmi'
	var/belt_icon	= 'icons/inv_slots/belts/mob.dmi'
	var/s_store_icon= 'icons/mob/onmob/belt_mirror.dmi'
	var/back_icon	= 'icons/inv_slots/back/mob.dmi'
	var/ties_icon	= 'icons/inv_slots/acessories/mob.dmi'
	var/hidden_icon = 'icons/inv_slots/hidden/mob.dmi'
	var/rig_back	= 'icons/inv_slots/rig/mob.dmi'
	var/id_icon		= 'icons/mob/onmob/id.dmi'
	var/blood_icon	= 'icons/mob/human_races/masks/blood_human.dmi'

	//var/r_hand		= 'icons/inv_slots/items/items_r_default.dmi'
	//var/l_hand		= 'icons/inv_slots/items/items_l_default.dmi'

	var/l_hand = 'icons/mob/onmob/items/lefthand.dmi'
	var/r_hand = 'icons/mob/onmob/items/righthand.dmi'

	//var/list/hand_groups = list()

/datum/body_build/New()
	// hand_groups["[SPRITE_UNIFORMS]_l"] = 'icons/inv_slots/uniforms/hand_l_default.dmi'
	// hand_groups["[SPRITE_UNIFORMS]_r"] = 'icons/inv_slots/uniforms/hand_r_default.dmi'
	// hand_groups["[SPRITE_SUITS]_r"]    = 'icons/inv_slots/suits/hand_r_default.dmi'
	// hand_groups["[SPRITE_SUITS]_l"]    = 'icons/inv_slots/suits/hand_l_default.dmi'
	// hand_groups["[SPRITE_BACKPACK]_l"] = 'icons/inv_slots/back/hand_l_default.dmi'
	// hand_groups["[SPRITE_BACKPACK]_r"] = 'icons/inv_slots/back/hand_r_default.dmi'
	// hand_groups["[SPRITE_GLOVES]_l"]   = 'icons/inv_slots/gloves/hand_l_default.dmi'
	// hand_groups["[SPRITE_GLOVES]_r"]   = 'icons/inv_slots/gloves/hand_r_default.dmi'
	// hand_groups["[SPRITE_MELEE]_l"]    = 'icons/inv_slots/items/melee_l_default.dmi'
	// hand_groups["[SPRITE_MELEE]_r"]    = 'icons/inv_slots/items/melee_r_default.dmi'
	// hand_groups["[SPRITE_STORAGE]_l"]  = 'icons/inv_slots/items/storage_l_default.dmi'
	// hand_groups["[SPRITE_STORAGE]_r"]  = 'icons/inv_slots/items/storage_r_default.dmi'
	// hand_groups["[SPRITE_GUNS]_l"]     = 'icons/inv_slots/items/guns_l_default.dmi'
	// hand_groups["[SPRITE_GUNS]_r"]     = 'icons/inv_slots/items/guns_r_default.dmi'

// /datum/body_build/proc/get_inhand_icon(var/group, var/hand)
// 	if(hand == LEFT)
// 		group += "_l"
// 	else
// 		group += "_r"
// 	if(group in hand_groups)
// 		return hand_groups[group]
// 	else
// 		return (hand == LEFT) ? l_hand : r_hand

/datum/body_build/proc/get_mob_icon(slot, icon_state)
	var/icon/I
	for(var/datum/body_build/BB in list(src, default_body_build))
		switch(slot)
			if ("hidden")  				I = BB.hidden_icon
			if (slot_w_uniform_str)  	I = BB.uniform_icon
			if (slot_wear_suit_str)  	I = BB.suit_icon
			if (slot_gloves_str)  		I = BB.gloves_icon
			if (slot_glasses_str) 		I = BB.glasses_icon
			if (slot_l_ear_str) 		I = BB.ears_icon
			if (slot_r_ear_str) 		I = BB.ears_icon
			if (slot_wear_mask_str)  	I = BB.mask_icon
			if (slot_head_str)    		I = BB.hat_icon
			if (slot_shoes_str)   		I = BB.shoes_icon
			if (slot_belt_str)    		I = BB.belt_icon
			if (slot_s_store_str)       I = BB.s_store_icon
			if (slot_back_str)    		I = BB.back_icon
			if (slot_tie_str)     		I = BB.ties_icon
			if (slot_l_hand_str)		I = BB.l_hand
			if (slot_r_hand_str)		I = BB.r_hand
			if (slot_handcuffed_str)	I = BB.misk_icon
			if (slot_legcuffed_str)		I = BB.misk_icon
			if (slot_wear_id_str)		I = BB.id_icon
			else
				world.log << "##ERROR. Wrong sprite group for mob icon \"[slot]\""
		if(icon_state in icon_states(I))
			break

	return I

/datum/body_build/slim
	name			= "Slim"

	index			= "_slim"
	roboindex   	= "_slim"
	genders			= list(FEMALE)
	uniform_icon	= 'icons/inv_slots/uniforms/mob_slim.dmi'
	suit_icon		= 'icons/inv_slots/suits/mob_slim.dmi'
	gloves_icon		= 'icons/inv_slots/gloves/mob_slim.dmi'
	glasses_icon	= 'icons/inv_slots/glasses/mob_slim.dmi'
	ears_icon		= 'icons/inv_slots/ears/mob_slim.dmi'
	mask_icon		= 'icons/inv_slots/masks/mob_slim.dmi'
	shoes_icon		= 'icons/inv_slots/shoes/mob_slim.dmi'
	belt_icon		= 'icons/inv_slots/belts/mob_slim.dmi'
	s_store_icon	= 'icons/mob/onmob/belt_mirror_slim.dmi'
	back_icon		= 'icons/inv_slots/back/mob_slim.dmi'
	ties_icon		= 'icons/inv_slots/acessories/mob_slim.dmi'
	hidden_icon 	= 'icons/inv_slots/hidden/mob_slim.dmi'
	rig_back		= 'icons/inv_slots/rig/mob_slim.dmi'
	blood_icon		= 'icons/mob/human_races/masks/blood_human_slim.dmi'

	l_hand = 'icons/mob/onmob/items/lefthand_slim.dmi'
	r_hand = 'icons/mob/onmob/items/righthand_slim.dmi'

/datum/body_build/slim/New()
	..()
	// hand_groups["[SPRITE_UNIFORMS]_l"] = 'icons/inv_slots/uniforms/hand_l_slim.dmi'
	// hand_groups["[SPRITE_UNIFORMS]_r"] = 'icons/inv_slots/uniforms/hand_r_slim.dmi'
	// hand_groups["[SPRITE_BACKPACK]_l"] = 'icons/inv_slots/back/hand_l_slim.dmi'
	// hand_groups["[SPRITE_BACKPACK]_r"] = 'icons/inv_slots/back/hand_r_slim.dmi'
	// hand_groups["[SPRITE_GLOVES]_l"]   = 'icons/inv_slots/gloves/hand_l_slim.dmi'
	// hand_groups["[SPRITE_GLOVES]_r"]   = 'icons/inv_slots/gloves/hand_r_slim.dmi'
	// hand_groups["[SPRITE_MELEE]_l"]    = 'icons/inv_slots/items/melee_l_slim.dmi'
	// hand_groups["[SPRITE_MELEE]_r"]    = 'icons/inv_slots/items/melee_r_slim.dmi'

/datum/body_build/slim/alt
	name			= "Slim Alt"

	index			= "_slim_alt"
	genders			= list(FEMALE)
	uniform_icon	= 'icons/inv_slots/uniforms/mob_slimalt.dmi'
	suit_icon		= 'icons/inv_slots/suits/mob_slimalt.dmi'
	gloves_icon		= 'icons/inv_slots/gloves/mob_slim.dmi'
	glasses_icon	= 'icons/inv_slots/glasses/mob_slim.dmi'
	ears_icon		= 'icons/inv_slots/ears/mob_slim.dmi'
	mask_icon		= 'icons/inv_slots/masks/mob_slim.dmi'
	shoes_icon		= 'icons/inv_slots/shoes/mob_slimalt.dmi'
	belt_icon		= 'icons/inv_slots/belts/mob_slim.dmi'
	back_icon		= 'icons/inv_slots/back/mob_slim.dmi'
	ties_icon		= 'icons/inv_slots/acessories/mob_slim.dmi'
	hidden_icon 	= 'icons/inv_slots/hidden/mob_slimalt.dmi'
	rig_back		= 'icons/inv_slots/rig/mob_slim.dmi'
	blood_icon		= 'icons/mob/human_races/masks/blood_human_slim_alt.dmi'

/datum/body_build/slim/male
	name			= "Slim"

	index			= "_slim"
	roboindex   	= "_slim"
	genders			= list(MALE)
	uniform_icon	= 'icons/inv_slots/uniforms/mob_slim_m.dmi'
	suit_icon		= 'icons/inv_slots/suits/mob_slim_m.dmi'
	gloves_icon		= 'icons/inv_slots/gloves/mob_slim.dmi'
	glasses_icon	= 'icons/inv_slots/glasses/mob_slim.dmi'
	ears_icon		= 'icons/inv_slots/ears/mob_slim.dmi'
	mask_icon		= 'icons/inv_slots/masks/mob_slim.dmi'
	shoes_icon		= 'icons/inv_slots/shoes/mob_slim.dmi'
	belt_icon		= 'icons/inv_slots/belts/mob_slim.dmi'
	s_store_icon	= 'icons/mob/onmob/belt_mirror_slim.dmi'
	back_icon		= 'icons/inv_slots/back/mob_slim_m.dmi'
	ties_icon		= 'icons/inv_slots/acessories/mob_slim_m.dmi'
	hidden_icon 	= 'icons/inv_slots/hidden/mob_slim_m.dmi'
	rig_back		= 'icons/inv_slots/rig/mob_slim.dmi'
	blood_icon		= 'icons/mob/human_races/masks/blood_human_m_slim.dmi'

/datum/body_build/slim/alt/tajaran //*sigh. I regret of doing this.
	name = "Slim Tajaran"

	mask_icon	= 'icons/inv_slots/masks/mob_tajaran.dmi'
	hat_icon	= 'icons/inv_slots/hats/mob_tajaran.dmi'
	suit_icon	= 'icons/inv_slots/suits/mob_tajaran.dmi'
	blood_icon		= 'icons/mob/human_races/masks/blood_human_slim.dmi'

/datum/body_build/tajaran
	name		= "Tajaran"

	suit_icon	= 'icons/inv_slots/suits/mob_tajaran.dmi'
	gloves_icon	= 'icons/inv_slots/gloves/mob_tajaran.dmi'
	mask_icon	= 'icons/inv_slots/masks/mob_tajaran.dmi'
	shoes_icon	= 'icons/inv_slots/shoes/mob_tajaran.dmi'
	hat_icon	= 'icons/inv_slots/hats/mob_tajaran.dmi'
	hidden_icon = 'icons/inv_slots/hidden/mob_tajaran.dmi'

/datum/body_build/unathi
	name		= SPECIES_UNATHI

	suit_icon	= 'icons/inv_slots/suits/mob_unathi.dmi'
	mask_icon	= 'icons/inv_slots/masks/mob_unathi.dmi'
	hat_icon	= 'icons/inv_slots/hats/mob_unathi.dmi'
	hidden_icon = 'icons/inv_slots/hidden/mob_unathi.dmi'

/datum/body_build/vox
	name		= "Vox"

	uniform_icon= 'icons/inv_slots/uniforms/mob_vox.dmi'
	suit_icon	= 'icons/inv_slots/suits/mob_vox.dmi'
	gloves_icon	= 'icons/inv_slots/gloves/mob_vox.dmi'
	glasses_icon= 'icons/inv_slots/glasses/mob_vox.dmi'
	mask_icon	= 'icons/inv_slots/masks/mob_vox.dmi'
	hat_icon	= 'icons/inv_slots/hats/mob_vox.dmi'
	shoes_icon	= 'icons/inv_slots/shoes/mob_vox.dmi'
	ties_icon	= 'icons/inv_slots/acessories/mob_vox.dmi'

/datum/body_build/monkey
	name		= "Monkey"

	uniform_icon= 'icons/mob/species/monkey/uniform.dmi'
	ties_icon	= 'icons/mob/species/monkey/ties.dmi'
	blood_icon		= 'icons/mob/human_races/masks/blood_monkey.dmi'
