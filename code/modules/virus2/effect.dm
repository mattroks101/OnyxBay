////////////////////////////////////////////////////////////////
////////////////////////EFFECTS/////////////////////////////////
////////////////////////////////////////////////////////////////
/proc/get_random_virus2_effect(stage, badness, exclude)
	var/list/datum/disease2/effect/candidates = list()
	for(var/T in subtypesof(/datum/disease2/effect))
		var/datum/disease2/effect/E = T
		if(E in exclude)
			continue
		if(initial(E.badness) > badness)	//we don't want such strong effects
			continue
		if(initial(E.stage) <= stage)
			candidates += T
	var/type = pick(candidates)
	var/datum/disease2/effect/effect = new type
	effect.generate()
	effect.chance = rand(0,effect.chance_max)
	effect.multiplier = rand(1,effect.multiplier_max)
	return effect

/datum/disease2/effect
	var/name = "Blanking effect"
	var/chance			//probality to fire every tick
	var/chance_max = 50
	var/multiplier = 1	//effect magnitude multiplier
	var/multiplier_max = 1
	var/stage = 4		//minimal stage
	var/badness = VIRUS_MILD	//Used in random generation to limit how bad result should come out.
	var/list/data = list()	//For semi-procedural effects; this should be generated in generate() if used
	var/oneshot
	var/delay = 5 SECONDS	//minimal time between activations
	var/hold_until		//can only fire after this worldtime
	var/allow_multiple	//allow to have more than 1 effect of this type in the same virus

/datum/disease2/effect/proc/fire(mob/living/carbon/human/mob,current_stage)
	if(oneshot == -1)
		return
	if(hold_until > world.time)
		return
	if(mob.chem_effects[CE_ANTIVIRAL] >= badness)
		return
	if(stage <= current_stage && prob(chance))
		hold_until = world.time + delay
		activate(mob)
		if(oneshot == 1)
			oneshot = -1

/datum/disease2/effect/proc/minormutate()
	switch(pick(1,2,3,4,5))
		if(1)
			chance = rand(0,chance_max)
		if(2)
			multiplier = rand(1,multiplier_max)

/datum/disease2/effect/proc/activate(mob/living/carbon/human/mob)
/datum/disease2/effect/proc/deactivate(mob/living/carbon/human/mob)
/datum/disease2/effect/proc/generate(copy_data) // copy_data will be non-null if this is a copy; it should be used to initialise the data for this effect if present

/datum/disease2/effect/invisible
	name = "Waiting Syndrome"
	stage = 1

////////////////////////STAGE 4/////////////////////////////////

/datum/disease2/effect/gibbingtons
	name = "Gibbingtons Syndrome"
	stage = 4
	badness = VIRUS_EXOTIC
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		// Probabilities have been tweaked to kill in ~2-3 minutes, giving 5-10 messages.
		// Probably needs more balancing, but it's better than LOL U GIBBED NOW, especially now that viruses can potentially have no signs up until Gibbingtons.
		mob.adjustBruteLoss(10*multiplier)
		var/obj/item/organ/external/O = pick(mob.organs)
		if(prob(25))
			to_chat(mob, GIBBINGTONS_EFFECT_WARNING(O.name))
		if(prob(10))
			spawn(50)
				if(O)
					O.droplimb(0,DROPLIMB_BLUNT)

/datum/disease2/effect/radian
	name = "Radian's Syndrome"
	stage = 4
	multiplier_max = 3
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.apply_effect(2*multiplier, IRRADIATE, blocked = 0)

/datum/disease2/effect/deaf
	name = "Dead Ear Syndrome"
	stage = 4
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.ear_deaf += 20

/datum/disease2/effect/monkey
	name = "Two Percent Syndrome"
	stage = 4
	badness = VIRUS_EXOTIC
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.monkeyize()

/datum/disease2/effect/killertoxins
	name = "Toxification Syndrome"
	stage = 4
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.adjustToxLoss(15*multiplier)

/datum/disease2/effect/dna
	name = "Reverse Pattern Syndrome"
	stage = 4
	badness = VIRUS_ENGINEERED
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.bodytemperature = max(mob.bodytemperature, 350)
		scramble(0,mob,10)
		mob.apply_damage(10, CLONE)

/datum/disease2/effect/organs
	name = "Shutdown Syndrome"
	stage = 4
	badness = VIRUS_ENGINEERED
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		var/organ = pick(list(BP_R_ARM,BP_L_ARM,BP_R_LEG,BP_L_LEG))
		var/obj/item/organ/external/E = mob.organs_by_name[organ]
		if (!(E.status & ORGAN_DEAD))
			E.status |= ORGAN_DEAD
			to_chat(mob, ORGANS_SHUTDOWN_EFFECT_WARNING(E.name))
			for (var/obj/item/organ/external/C in E.children)
				C.status |= ORGAN_DEAD
		mob.update_body(1)
		mob.adjustToxLoss(15*multiplier)

	deactivate(var/mob/living/carbon/human/mob,var/multiplier)
		for (var/obj/item/organ/external/E in mob.organs)
			E.status &= ~ORGAN_DEAD
			for (var/obj/item/organ/external/C in E.children)
				C.status &= ~ORGAN_DEAD
		mob.update_body(1)

/datum/disease2/effect/immortal
	name = "Longevity Syndrome"
	stage = 4
	badness = VIRUS_ENGINEERED
	activate(mob/living/carbon/human/mob, multiplier)
		for (var/obj/item/organ/external/E in mob.organs)
			if (E.status & ORGAN_BROKEN && prob(30))
				to_chat(mob, IMMORTAL_RECOVER_EFFECT_WARNING(E.name))
				E.status ^= ORGAN_BROKEN
				break
		for (var/obj/item/organ/internal/I in mob.internal_organs)
			if (I.damage && prob(30))
				to_chat(mob, IMMORTAL_HEALING_EFFECT_WARNING(mob.get_organ(I.parent_organ)))
				I.take_internal_damage(-2*multiplier)
				break
		var/heal_amt = -5*multiplier
		mob.apply_damages(heal_amt,heal_amt,heal_amt,heal_amt)

	deactivate(var/mob/living/carbon/human/mob,var/multiplier)
		to_chat(mob, IMMORTAL_AGING_EFFECT_WARNING)
		mob.age += 8
		var/backlash_amt = 5*multiplier
		mob.apply_damages(backlash_amt,backlash_amt,backlash_amt,backlash_amt)

/datum/disease2/effect/bones
	name = "Fragile Bones Syndrome"
	stage = 4
	badness = VIRUS_ENGINEERED
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		for (var/obj/item/organ/external/E in mob.organs)
			E.min_broken_damage = max(5, E.min_broken_damage - 30)

	deactivate(var/mob/living/carbon/human/mob,var/multiplier)
		for (var/obj/item/organ/external/E in mob.organs)
			E.min_broken_damage = initial(E.min_broken_damage)

////////////////////////STAGE 3/////////////////////////////////

/datum/disease2/effect/toxins
	name = "Hyperacidity"
	stage = 3
	multiplier_max = 3
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.adjustToxLoss((2*multiplier))

/datum/disease2/effect/shakey
	name = "World Shaking Syndrome"
	stage = 3
	multiplier_max = 3
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		shake_camera(mob,5*multiplier)

/datum/disease2/effect/telepathic
	name = "Telepathy Syndrome"
	stage = 3
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.dna.SetSEState(GLOB.REMOTETALKBLOCK,1)
		domutcheck(mob, null, MUTCHK_FORCED)

/datum/disease2/effect/mind
	name = "Lazy Mind Syndrome"
	stage = 3
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob, var/multiplier)
		var/obj/item/organ/internal/brain/B = mob.internal_organs_by_name[BP_BRAIN]
		if (B && B.damage < B.min_broken_damage)
			B.take_internal_damage(5)

/datum/disease2/effect/deaf
	name = "Hard of Hearing Syndrome"
	stage = 3
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.ear_deaf = 5

/datum/disease2/effect/confusion
	name = "Topographical Cretinism"
	stage = 3
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		to_chat(mob, CONFUSION_EFFECT_WARNING)
		mob.confused += 10

/datum/disease2/effect/mutation
	name = "DNA Degradation"
	stage = 3
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.apply_damage(2, CLONE)

/datum/disease2/effect/chem_synthesis
	name = "Chemical Synthesis"
	stage = 3
	badness = VIRUS_COMMON
	chance_max = 25

	generate(c_data)
		if(c_data)
			data = c_data
		else
			data = pick(/datum/reagent/bicaridine, /datum/reagent/kelotane, /datum/reagent/dylovene, /datum/reagent/inaprovaline, /datum/reagent/space_drugs, /datum/reagent/sugar,
						/datum/reagent/tramadol, /datum/reagent/dexalin, /datum/reagent/cryptobiolin, /datum/reagent/impedrezene, /datum/reagent/hyperzine, /datum/reagent/ethylredoxrazine,
						/datum/reagent/mindbreaker, /datum/reagent/nutriment/glucose)
		var/datum/reagent/R = data
		name = "[initial(name)] ([initial(R.name)])"

	activate(var/mob/living/carbon/human/mob,var/multiplier)
		if (mob.reagents.get_reagent_amount(data) < 5)
			mob.reagents.add_reagent(data, 2)

/datum/disease2/effect/nothing
	name = "Nil Syndrome"
	stage = 1
	badness = VIRUS_MILD
	chance_max = 0
	allow_multiple = 1

////////////////////////STAGE 2/////////////////////////////////
/datum/disease2/effect/drowsness
	name = "Automated Sleeping Syndrome"
	stage = 2
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.drowsyness += 10

/datum/disease2/effect/sleepy
	name = "Resting Syndrome"
	stage = 2
	chance_max = 15
	delay = 35 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.emote("collapse")

/datum/disease2/effect/blind
	name = "Blackout Syndrome"
	stage = 2
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.eye_blind = max(mob.eye_blind, 4)

/datum/disease2/effect/cough
	name = "Anima Syndrome"
	stage = 2
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.emote("cough")
		if (mob.wear_mask)
			return
		for(var/mob/living/carbon/human/M in oview(2,mob))
			mob.spread_disease_to(M)

/datum/disease2/effect/hungry
	name = "Appetiser Effect"
	stage = 2
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.nutrition = max(0, mob.nutrition - 200)

/datum/disease2/effect/fridge
	name = "Refridgerator Syndrome"
	stage = 2
	chance_max = 25
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.emote("shiver")

/datum/disease2/effect/hair
	name = "Hair Loss"
	stage = 2
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		if(mob.species.name == SPECIES_HUMAN && !(mob.h_style == "Bald") && !(mob.h_style == "Balding Hair"))
			to_chat(mob, HAIR_EFFECT_WARNING)
			spawn(50)
				mob.h_style = "Balding Hair"
				mob.update_hair()

/datum/disease2/effect/stimulant
	name = "Adrenaline Extra"
	stage = 2
	badness = VIRUS_COMMON
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		to_chat(mob, STIMULANT_EFFECT_WARNING)
		if (mob.reagents.get_reagent_amount(/datum/reagent/hyperzine) < 10)
			mob.reagents.add_reagent(/datum/reagent/hyperzine, 4)
		if (prob(30))
			mob.jitteriness += 10

/datum/disease2/effect/disorientation
	name = "Disorientation"
	stage = 2
	delay = 15 SECONDS

/datum/disease2/effect/disorientation/activate(mob/living/carbon/human/mob, multiplier)
	to_chat(mob, DISORIENTATION_EFFECT_WARNING)
	if(mob.client)
		var/client/C = mob.client
		if(prob(50))
			C.dir = turn(C.dir, 90)
		else
			C.dir = turn(C.dir, -90)

////////////////////////STAGE 1/////////////////////////////////

/datum/disease2/effect/sneeze
	name = "Coldingtons Effect"
	stage = 1
	delay = 15 SECONDS

	activate(var/mob/living/carbon/human/mob,var/multiplier)
		if (prob(30))
			to_chat(mob, SNEEZE_EFFECT_WARNING)
		sleep(5)
		mob.emote("sneeze")
		for(var/mob/living/carbon/human/M in get_step(mob,mob.dir))
			mob.spread_disease_to(M)
		if (prob(50) && !mob.wear_mask)
			var/obj/effect/decal/cleanable/mucus/M = new(get_turf(mob))
			M.virus2 = virus_copylist(mob.virus2)

/datum/disease2/effect/gunck
	name = "Flemmingtons"
	stage = 1
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		to_chat(mob, GUNCK_EFFECT_WARNING)

/datum/disease2/effect/drool
	name = "Saliva Effect"
	stage = 1
	chance_max = 25
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.emote("drool")

/datum/disease2/effect/twitch
	name = "Twitcher"
	stage = 1
	chance_max = 25
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.emote("twitch")

/datum/disease2/effect/headache
	name = "Headache"
	stage = 1
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		mob.custom_pain("Your head hurts a bit.", 20)

/datum/disease2/effect/itch
	name = "Itches"
	stage = 1
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		var/obj/O = pick(mob.organs)
		to_chat(mob, ITCH_EFFECT_WARNING(O.name))

/datum/disease2/effect/stomach
	name = "Upset stomach"
	stage = 1
	delay = 25 SECONDS
	activate(var/mob/living/carbon/human/mob,var/multiplier)
		to_chat(mob, STOMACH_EFFECT_WARNING)

/datum/disease2/effect/stealth
	name = "Silent Death Syndrome"
	stage = 1
	badness = VIRUS_EXOTIC
	chance_max = 0
	allow_multiple = 1
