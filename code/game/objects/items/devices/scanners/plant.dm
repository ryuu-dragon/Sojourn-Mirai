
/obj/item/device/scanner/plant
	name = "plant analyzer"
	desc = "A hand-held botanical scanner used to analyze plants."
	icon = 'icons/obj/device.dmi'
	icon_state = "hydro"
	item_state = "analyzer"
	charge_per_use = 2
	print_report_delay = 5 //we do mass plant scanning for sciences and garden

	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_GLASS = 1)
	preloaded_reagents = list("mercury" = 15, "lithium" = 5, "plasticide" = 9)

	var/global/list/valid_targets = list(
		/obj/item/reagent_containers/snacks/grown,
		/obj/item/grown,
		/obj/machinery/portable_atmospherics/hydroponics,
		/obj/machinery/beehive,
		/obj/item/seeds
	)
	var/datum/seed/loaded_seed
	var/datum/reagents/loaded_reagents

/obj/item/device/scanner/plant/perk
	charge_per_use = 0 //It need to be 0 for the Green Thumb perk to work

/obj/item/device/scanner/plant/is_valid_scan_target(atom/O)
	if(is_type_in_list(O, valid_targets))
		return TRUE
	return FALSE

/obj/item/device/scanner/plant/scan(atom/A, mob/user)
	loaded_seed = null
	loaded_reagents = null
	scan_title = "[A] at [get_area(A)]"
	scan_data = plant_scan_results(A)
	flick("hydro2", src)
	show_results(user)

/obj/item/device/scanner/plant/proc/plant_scan_results(obj/target)
	var/datum/seed/grown_seed
	var/datum/reagents/grown_reagents

	var/dat = list()
	if(istype(target, /obj/machinery/beehive))
		var/obj/machinery/beehive/BH = target
		dat += SPAN_NOTICE("Scan result of \the [BH]...")
		dat += "Beehive is [BH.bee_count ? "[round(BH.bee_count)]% full" : "empty"].[BH.bee_count > 90 ? " Colony is ready to split." : ""]"
		if(BH.frames)
			dat += "[BH.frames] frames installed, [round(BH.honeycombs / 100)] filled."
			if(BH.honeycombs < BH.frames * 100)
				dat += "Next frame is [round(BH.honeycombs % 100)]% full."
		else
			dat += "No frames installed."
		if(BH.smoked)
			dat += "The hive is smoked."
		return jointext(dat, "<br>")

	else if(istype(target,/obj/item/reagent_containers/snacks/grown))

		var/obj/item/reagent_containers/snacks/grown/G = target
		grown_seed = plant_controller.seeds[G.plantname]
		loaded_seed = grown_seed
		grown_reagents = G.reagents
		loaded_reagents = grown_reagents

	else if(istype(target,/obj/item/grown))

		var/obj/item/grown/G = target
		grown_seed = plant_controller.seeds[G.plantname]
		loaded_seed = grown_seed
		grown_reagents = G.reagents
		loaded_reagents = grown_reagents

	else if(istype(target,/obj/item/seeds))

		var/obj/item/seeds/S = target
		grown_seed = S.seed
		loaded_seed = grown_seed

	else if(istype(target,/obj/machinery/portable_atmospherics/hydroponics))

		var/obj/machinery/portable_atmospherics/hydroponics/H = target
		if(H.frozen == 1)
			to_chat(usr, "<span class='warning'>Disable the cryogenic freezing first!</span>")
			return
		var/datum/seed/S = H.seed
		grown_seed = S
		loaded_seed = grown_seed

	if(!grown_seed)
		return("No Data Available")

	var/chem_exspection = 1
	var/form_title = "[grown_seed.seed_name] (#[grown_seed.uid])"
	dat += "<h3>Plant data for [form_title]</h3>"

	dat += "<h2>General Data</h2>"

	dat += "<table>"
	dat += "<tr><td><b>Endurance</b></td><td>[grown_seed.get_trait(TRAIT_ENDURANCE)]</td></tr>"
	dat += "<tr><td><b>Yield</b></td><td>[grown_seed.get_trait(TRAIT_YIELD)]</td></tr>"
	dat += "<tr><td><b>Maturation time</b></td><td>[grown_seed.get_trait(TRAIT_MATURATION)]</td></tr>"
	dat += "<tr><td><b>Production time</b></td><td>[grown_seed.get_trait(TRAIT_PRODUCTION)]</td></tr>"
	dat += "<tr><td><b>Potency</b></td><td>[grown_seed.get_trait(TRAIT_POTENCY)]</td></tr>"
	dat += "</table>"

	if(grown_reagents && grown_reagents.reagent_list && grown_reagents.reagent_list.len)
		dat += "<h2>Reagent Data</h2>"

		dat += "<br>This sample contains: "
		for(var/datum/reagent/R in grown_reagents.reagent_list)
			dat += "<br>- [R.id], [grown_reagents.get_reagent_amount(R.id)] unit(s)"

	dat += "<h2>Other Data</h2>"

	if(grown_seed.get_trait(TRAIT_HARVEST_REPEAT))
		dat += "This plant can be harvested repeatedly.<br>"
		chem_exspection -= 0.25

	if(grown_seed.get_trait(TRAIT_IMMUTABLE) == -1)
		dat += "This plant is highly mutable.<br>"
	else if(grown_seed.get_trait(TRAIT_IMMUTABLE) > 0)
		dat += "This plant does not possess genetics that are alterable.<br>"

	if(grown_seed.get_trait(TRAIT_REQUIRES_NUTRIENTS))
		if(grown_seed.get_trait(TRAIT_NUTRIENT_CONSUMPTION) < 0.05)
			dat += "It consumes a small amount of nutrient fluid.<br>"
		else if(grown_seed.get_trait(TRAIT_NUTRIENT_CONSUMPTION) > 0.2)
			dat += "It requires a heavy supply of nutrient fluid.<br>"
		else
			dat += "It requires a supply of nutrient fluid.<br>"

	if(grown_seed.get_trait(TRAIT_REQUIRES_WATER))
		if(grown_seed.get_trait(TRAIT_WATER_CONSUMPTION) < 1)
			dat += "It requires very little water.<br>"
		else if(grown_seed.get_trait(TRAIT_WATER_CONSUMPTION) > 5)
			dat += "It requires a large amount of water.<br>"
		else
			dat += "It requires a stable supply of water.<br>"

	if(grown_seed.mutants && grown_seed.mutants.len)
		dat += "It exhibits a high degree of potential subspecies shift.<br>"

	dat += "It thrives in a temperature of [grown_seed.get_trait(TRAIT_IDEAL_HEAT)] Kelvin."

	if(grown_seed.get_trait(TRAIT_LOWKPA_TOLERANCE) < 20)
		dat += "<br>It is well adapted to low pressure levels."
	if(grown_seed.get_trait(TRAIT_HIGHKPA_TOLERANCE) > 220)
		dat += "<br>It is well adapted to high pressure levels."

	if(grown_seed.get_trait(TRAIT_HEAT_TOLERANCE) > 30)
		dat += "<br>It is well adapted to a range of temperatures."
	else if(grown_seed.get_trait(TRAIT_HEAT_TOLERANCE) < 10)
		dat += "<br>It is very sensitive to temperature shifts."

	dat += "<br>It thrives in a light level of [grown_seed.get_trait(TRAIT_IDEAL_LIGHT)] lumen[grown_seed.get_trait(TRAIT_IDEAL_LIGHT) == 1 ? "" : "s"]."

	if(grown_seed.get_trait(TRAIT_LIGHT_TOLERANCE) > 10)
		dat += "<br>It is well adapted to a range of light levels."
	else if(grown_seed.get_trait(TRAIT_LIGHT_TOLERANCE) < 3)
		dat += "<br>It is very sensitive to light level shifts."

	if(grown_seed.get_trait(TRAIT_TOXINS_TOLERANCE) < 3)
		dat += "<br>It is highly sensitive to toxins."
	else if(grown_seed.get_trait(TRAIT_TOXINS_TOLERANCE) > 6)
		dat += "<br>It is remarkably resistant to toxins."

	if(grown_seed.get_trait(TRAIT_PEST_TOLERANCE) < 3)
		dat += "<br>It is highly sensitive to pests."
	else if(grown_seed.get_trait(TRAIT_PEST_TOLERANCE) > 6)
		dat += "<br>It is remarkably resistant to pests."

	if(grown_seed.get_trait(TRAIT_WEED_TOLERANCE) < 3)
		dat += "<br>It is highly sensitive to weeds."
	else if(grown_seed.get_trait(TRAIT_WEED_TOLERANCE) > 6)
		dat += "<br>It is remarkably resistant to weeds."

	switch(grown_seed.get_trait(TRAIT_SPREAD))
		if(1)
			dat += "<br>It is able to be planted outside of a tray."
		if(2)
			dat += "<br>It is a robust and vigorous vine that will spread rapidly."

	switch(grown_seed.get_trait(TRAIT_CARNIVOROUS))
		if(1)
			dat += "<br>It is carnivorous and will eat tray pests for sustenance."
		if(2)
			dat += "<br>It is carnivorous and poses a significant threat to living things around it."

	if(grown_seed.get_trait(TRAIT_COMPANION_PLANT))
		dat += "<br>It will yields, production, and growth of other plants close to itself."

	if(grown_seed.get_trait(TRAIT_PARASITE))
		dat += "<br>It is capable of parisitizing and gaining sustenance from tray weeds."

	if(grown_seed.get_trait(TRAIT_ALTER_TEMP))
		dat += "<br>It will periodically alter the local temperature by [grown_seed.get_trait(TRAIT_ALTER_TEMP)] degrees Kelvin."

	if(grown_seed.get_trait(TRAIT_BIOLUM))
		dat += "<br>It is [grown_seed.get_trait(TRAIT_BIOLUM_COLOR)  ? "<font color='[grown_seed.get_trait(TRAIT_BIOLUM_COLOR)]'>bio-luminescent</font>" : "bio-luminescent"]."

	if(grown_seed.get_trait(TRAIT_PRODUCES_POWER))
		dat += "<br>The fruit will function as a battery if prepared appropriately."

	if(grown_seed.get_trait(TRAIT_STINGS))
		dat += "<br>The fruit is covered in stinging spines."

	if(grown_seed.get_trait(TRAIT_JUICY) == 1)
		dat += "<br>The fruit is soft-skinned and juicy."
		chem_exspection += 0.15
	else if(grown_seed.get_trait(TRAIT_JUICY) == 2)
		dat += "<br>The fruit is excessively juicy."
		chem_exspection += 0.25

	if(grown_seed.get_trait(TRAIT_CHEM_PRODUCTION))
		dat += "<br>The fruit is has more and larger vacuole cells."
		chem_exspection += 0.25

	if(grown_seed.get_trait(TRAIT_CHEM_SPRAYER))
		dat += "<br>Vines from this fruit contain pressurized stomas that open when they detect movement."
		chem_exspection += 0.50

	if(grown_seed.get_trait(TRAIT_EXPLOSIVE))
		dat += "<br>The fruit is internally unstable."

	if(grown_seed.get_trait(TRAIT_TELEPORTING))
		dat += "<br>The fruit is temporal/spatially unstable."

	if(grown_seed.exude_gasses && grown_seed.exude_gasses.len)
		dat += "<br>It will release gas into the environment."

	if(grown_seed.consume_gasses && grown_seed.consume_gasses.len)
		dat += "<br>It will remove gas from the environment."

	dat += "<br>Expected reagent production: [chem_exspection]x (i.e mult)."


	if(grown_seed.companions)
		for(var/friends in grown_seed.companions)
			dat += "<br>This plant has benefits when growing next to [friends]."


	return JOINTEXT(dat)

// A special paper that we can scan with the science tool
/obj/item/paper/plant_report
	var/datum/seed/scanned_seed
	var/datum/reagents/scanned_reagents

/obj/item/device/scanner/plant/print_report(var/mob/living/user)
	if(!scan_data)
		to_chat(user, "There is no scan data to print.")
		return
	var/obj/item/paper/plant_report/P = new(get_turf(src), scan_data, "paper - [scan_title]")
	P.scanned_seed = src.loaded_seed
	P.scanned_reagents = src.loaded_reagents
	user.put_in_hands(P)
	user.visible_message("\The [src] spits out a piece of paper.")
