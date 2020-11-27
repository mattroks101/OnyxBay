
/datum/gear/shoes
	sort_category = "Shoes"
	slot = slot_shoes

/datum/gear/shoes/boots
	display_name = "boot selection"
	path = /obj/item/clothing/shoes
	cost = 2

/datum/gear/shoes/boots/New()
	..()
	var/boots = list()
	boots += /obj/item/clothing/shoes/jackboots
	boots += /obj/item/clothing/shoes/workboots
	gear_tweaks += new /datum/gear_tweak/path/specified_types_list(boots)

/datum/gear/shoes/color
	display_name = "shoe selection"
	path = /obj/item/clothing/shoes

/datum/gear/shoes/color/New()
	..()
	var/shoes = list()
	shoes += /obj/item/clothing/shoes/black
	shoes += /obj/item/clothing/shoes/blue
	shoes += /obj/item/clothing/shoes/brown
	shoes += /obj/item/clothing/shoes/laceup
	shoes += /obj/item/clothing/shoes/green
	shoes += /obj/item/clothing/shoes/leather
	shoes += /obj/item/clothing/shoes/orange
	shoes += /obj/item/clothing/shoes/purple
	shoes += /obj/item/clothing/shoes/rainbow
	shoes += /obj/item/clothing/shoes/red
	shoes += /obj/item/clothing/shoes/white
	shoes += /obj/item/clothing/shoes/yellow
	gear_tweaks += new /datum/gear_tweak/path/specified_types_list(shoes)

/datum/gear/shoes/sandal
	display_name = "wooden sandals"
	path = /obj/item/clothing/shoes/sandal

//
// Donator's shop
//

/datum/gear/shoes/clown_shoes
	display_name = "clown shoes"
	path = /obj/item/clothing/shoes/clown_shoes
	price = 18

/datum/gear/shoes/cyborg_shoes
	display_name = "cyborg shoes"
	path = /obj/item/clothing/shoes/cyborg
	price = 2

/datum/gear/shoes/swimmingfins
	display_name = "swimming fins"
	path = /obj/item/clothing/shoes/swimmingfins
	price = 5

/datum/gear/shoes/slippers
	display_name = "bunny slippers"
	path = /obj/item/clothing/shoes/slippers
	price = 5

/datum/gear/shoes/mime_shoes
	display_name = "mime shoes"
	path = /obj/item/clothing/shoes/mime
	price = 12
