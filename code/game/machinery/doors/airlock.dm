GLOBAL_LIST_EMPTY(wedge_icon_cache)

/obj/machinery/door/airlock
	name = "Airlock"
	icon = 'icons/obj/doors/Doorint.dmi'
	icon_state = "door_closed"
	power_channel = STATIC_ENVIRON

	maxHealth = 400 //Makes it so you need to really shoot open a door

	explosion_resistance = 10

	var/aiControlDisabled = 0
	//If 1, AI control is disabled until the AI hacks back in and disables the lock.
	//If 2, the AI has bypassed the lock.
	//If -1, the control is enabled but the AI had bypassed it earlier, so if it is disabled again the AI would have no trouble getting back in.

	var/hackProof = 0 // if 1, this door can't be hacked by the AI
	var/electrified_until = 0			//World time when the door is no longer electrified. -1 if it is permanently electrified until someone fixes it.
	var/main_power_lost_until = 0	 	//World time when main power is restored.
	var/backup_power_lost_until = -1	//World time when backup power is restored.
	var/next_beep_at = 0				//World time when we may next beep due to doors being blocked by mobs
	var/spawnPowerRestoreRunning = 0

	var/locked = FALSE
	var/lights = TRUE // bolt lights show by default
	var/aiDisabledIdScanner = 0
	var/aiHacking = 0
	var/obj/machinery/door/airlock/closeOther = null
	var/closeOtherId = null
	var/lockdownbyai = 0
	autoclose = 1
	var/assembly_type = /obj/structure/door_assembly
	var/mineral = null
	var/justzap = 0
	var/safe = 1
	normalspeed = 1
	var/obj/item/airlock_electronics/electronics = null
	var/hasShocked = 0 //Prevents multiple shocks from happening
	var/secured_wires = 0
	var/datum/wires/airlock/wires = null
	var/open_sound_powered = 'sound/machines/airlock_open.ogg'
	var/close_sound = 'sound/machines/airlock_close.ogg'
	var/open_sound_unpowered = 'sound/machines/airlock_creaking.ogg'
	var/_wifi_id
	var/datum/wifi/receiver/button/door/wifi_receiver
	var/obj/item/wedged_item

	var/key_odds = 2 //How likely we are to guess the right key/lockpick

	damage_smoke = TRUE

/obj/machinery/door/airlock/attack_generic(mob/user, damage, attack_message, damagetype = BRUTE, attack_flag = ARMOR_MELEE, sharp = FALSE, edge = FALSE)
	if(stat & (BROKEN|NOPOWER))
		if(damage >= 10)
			if(density)
				visible_message(SPAN_DANGER("\The [user] forces \the [src] open!"))
				open(1)
			else
				visible_message(SPAN_DANGER("\The [user] forces \the [src] closed!"))
				close(1)
		else
			visible_message("<span class='notice'>\The [user] strains fruitlessly to force \the [src] [density ? "open" : "closed"].</span>")
		return
	..()

/obj/machinery/door/airlock/get_material()
	if(mineral)
		return get_material_by_name(mineral)
	return get_material_by_name(MATERIAL_STEEL)

/obj/machinery/door/airlock/command
	name = "Airlock"
	icon = 'icons/obj/doors/Doorcom.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_com
	key_odds = 0

/obj/machinery/door/airlock/security
	name = "Airlock"
	icon = 'icons/obj/doors/Doorsec.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_sec
	resistance = RESISTANCE_ARMORED
	key_odds = 1

/obj/machinery/door/airlock/engineering
	name = "Airlock"
	icon = 'icons/obj/doors/Dooreng.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_eng
	key_odds = 20

/obj/machinery/door/airlock/medical
	name = "Airlock"
	icon = 'icons/obj/doors/Doormed.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_med
	key_odds = 20

/obj/machinery/door/airlock/maintenance
	name = "Maintenance Access"
	icon = 'icons/obj/doors/Doormaint.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_mai
	key_odds = 70

/obj/machinery/door/airlock/external
	name = "External Airlock"
	icon = 'icons/obj/doors/Doorext.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_ext
	key_odds = 40
	opacity = 0
	glass = 0

/obj/machinery/door/airlock/glass
	name = "Glass Airlock"
	icon = 'icons/obj/doors/Doorglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	glass = 1
	key_odds = 40

/obj/machinery/door/airlock/glass/open
	icon_state = "door_open"
	density = 0

/obj/machinery/door/airlock/centcom
	name = "Airlock"
	icon = 'icons/obj/doors/Doorele.dmi'
	opacity = 1
	key_odds = 0

/obj/machinery/door/airlock/vault
	name = "Vault"
	icon = 'icons/obj/doors/vault.dmi'
	explosion_resistance = RESISTANCE_ARMORED
	resistance = RESISTANCE_VAULT
	opacity = 1
	key_odds = 0
	secured_wires = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_highsecurity //Until somebody makes better sprites.

/obj/machinery/door/airlock/vault/bolted
	icon_state = "door_locked"
	locked = 1

/obj/machinery/door/airlock/freezer
	name = "Freezer Airlock"
	icon = 'icons/obj/doors/Doorfreezer.dmi'
	key_odds = 50
	opacity = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_fre

/obj/machinery/door/airlock/hatch
	name = "Airtight Hatch"
	icon = 'icons/obj/doors/Doorhatchele.dmi'
	explosion_resistance = RESISTANCE_ARMORED
	resistance = RESISTANCE_ARMORED
	key_odds = 40
	opacity = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_hatch

/obj/machinery/door/airlock/maintenance_hatch
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doorhatchmaint2.dmi'
	explosion_resistance = RESISTANCE_ARMORED
	resistance = RESISTANCE_ARMORED
	key_odds = 70
	opacity = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_mhatch

/obj/machinery/door/airlock/glass_command
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doorcomglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	key_odds = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_com
	glass = 1

/obj/machinery/door/airlock/glass_engineering
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doorengglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	key_odds = 20
	assembly_type = /obj/structure/door_assembly/door_assembly_eng
	glass = 1

/obj/machinery/door/airlock/glass_security
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doorsecglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	key_odds = 2
	assembly_type = /obj/structure/door_assembly/door_assembly_sec
	glass = 1

/obj/machinery/door/airlock/glass_medical
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormedglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	key_odds = 10
	assembly_type = /obj/structure/door_assembly/door_assembly_med
	glass = 1

/obj/machinery/door/airlock/mining
	name = "Mining Airlock"
	icon = 'icons/obj/doors/Doormining.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_min
	key_odds = 20

/obj/machinery/door/airlock/atmos
	name = "Atmospherics Airlock"
	icon = 'icons/obj/doors/Dooratmo.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_atmo
	key_odds = 5 //no messes really their

/obj/machinery/door/airlock/research
	name = "Airlock"
	icon = 'icons/obj/doors/Doorresearch.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_research
	key_odds = 20

/obj/machinery/door/airlock/glass_research
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doorresearchglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_research
	glass = 1
	key_odds = 20
	heat_proof = 1

/obj/machinery/door/airlock/glass_mining
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doorminingglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_min
	glass = 1
	key_odds = 20

/obj/machinery/door/airlock/glass_atmos
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Dooratmoglass.dmi'
	hitsound = 'sound/effects/Glasshit.ogg'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	explosion_resistance = 5
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_atmo
	glass = 1
	key_odds = 5

/* NEW AIRLOCKS BLOCK */

/obj/machinery/door/airlock/maintenance_cargo
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_cargo.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_cargo
	key_odds = 20

/obj/machinery/door/airlock/maintenance_command
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_command.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_command
	key_odds = 0

/obj/machinery/door/airlock/maintenance_engineering
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_engi.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_engi
	key_odds = 20

/obj/machinery/door/airlock/maintenance_medical
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_med.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_med
	key_odds = 20

/obj/machinery/door/airlock/maintenance_rnd
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_rnd.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_rnd
	key_odds = 20

/obj/machinery/door/airlock/maintenance_security
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_sec.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_sec
	key_odds = 2

/obj/machinery/door/airlock/maintenance_common
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_common.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_common
	key_odds = 50

/obj/machinery/door/airlock/maintenance_interior
	name = "Maintenance Hatch"
	icon = 'icons/obj/doors/Doormaint_int.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_maint_int
	key_odds = 20

/* NEW AIRLOCKS BLOCK END */

/obj/machinery/door/airlock/gold
	name = "Gold Airlock"
	icon = 'icons/obj/doors/Doorgold.dmi'
	mineral = MATERIAL_GOLD

/obj/machinery/door/airlock/silver
	name = "Silver Airlock"
	icon = 'icons/obj/doors/Doorsilver.dmi'
	mineral = MATERIAL_SILVER

/obj/machinery/door/airlock/diamond
	name = "Diamond Airlock"
	icon = 'icons/obj/doors/Doordiamond.dmi'
	mineral = MATERIAL_DIAMOND
	resistance = RESISTANCE_UNBREAKABLE

/obj/machinery/door/airlock/uranium
	name = "Uranium Airlock"
	desc = "And they said I was crazy."
	icon = 'icons/obj/doors/Dooruranium.dmi'
	mineral = MATERIAL_URANIUM
	var/last_event = 0

/obj/machinery/door/airlock/Process()
	return PROCESS_KILL

/obj/machinery/door/airlock/uranium/Initialize()
	..()
	AddRadSource(src, 15, 3) // Values taken from the radiate proc below

/obj/machinery/door/airlock/uranium/proc/radiate()
	for(var/mob/living/L in range (3,src))
		L.apply_effect(15,IRRADIATE,0)
	return

/obj/machinery/door/airlock/plasma
	name = "Plasma Airlock"
	desc = "No way this can end badly."
	icon = 'icons/obj/doors/Doorplasma.dmi'
	mineral = "plasma"

/obj/machinery/door/airlock/plasma/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/obj/machinery/door/airlock/plasma/proc/ignite(exposed_temperature)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/obj/machinery/door/airlock/plasma/proc/PlasmaBurn(temperature)
	for(var/turf/simulated/floor/target_tile in trange(2,loc))
		target_tile.assume_gas("plasma", 35, 400+T0C)
		spawn (0) target_tile.hotspot_expose(temperature, 400)
	for(var/turf/simulated/wall/W in trange(3,src))
		W.burn((temperature/4))//Added so that you can't set off a massive chain reaction with a small flame
	for(var/obj/machinery/door/airlock/plasma/D in range(3,src))
		D.ignite(temperature/4)
	new/obj/structure/door_assembly(loc )
	qdel(src)

/obj/machinery/door/airlock/sandstone
	name = "Sandstone Airlock"
	icon = 'icons/obj/doors/Doorsand.dmi'
	mineral = MATERIAL_SANDSTONE

/obj/machinery/door/airlock/science
	name = "Airlock"
	icon = 'icons/obj/doors/Doorsci.dmi'
	assembly_type = /obj/structure/door_assembly/door_assembly_science
	key_odds = 20

/obj/machinery/door/airlock/glass_science
	name = "Glass Airlocks"
	icon = 'icons/obj/doors/Doorsciglass.dmi'
	maxHealth = 300
	resistance = RESISTANCE_AVERAGE
	opacity = 0
	assembly_type = /obj/structure/door_assembly/door_assembly_science
	glass = 1
	key_odds = 20

/obj/machinery/door/airlock/highsecurity
	name = "Secure Airlock"
	icon = 'icons/obj/doors/hightechsecurity.dmi'
	explosion_resistance = 20
	resistance = RESISTANCE_ARMORED
	secured_wires = 1
	assembly_type = /obj/structure/door_assembly/door_assembly_highsecurity
	key_odds = 0

/*
About the new airlock wires panel:
*An airlock wire dialog can be accessed by the normal way or by using wirecutters or a multitool on the door while the wire-panel is open.
This would show the following wires, which you can either wirecut/mend or send a multitool pulse through.
There are 9 wires.
*	one wire from the ID scanner.
		Sending a pulse through this flashes the red light on the door (if the door has power).
		If you cut this wire, the door will stop recognizing valid IDs.
		(If the door has 0000 access, it still opens and closes, though)
*	two wires for power.
		Sending a pulse through either one causes a breaker to trip,
		disabling the door for 10 seconds if backup power is connected,
		or 1 minute if not (or until backup power comes back on, whichever is shorter).
		Cutting either one disables the main door power, but unless backup power is also cut,
		the backup power re-powers the door in 10 seconds.
		While unpowered, the door may be open, but bolts-raising will not work.
		Cutting these wires may electrocute the user.
*	one wire for door bolts.
		Sending a pulse through this drops door bolts (whether the door is powered or not) or raises them (if it is).
		Cutting this wire also drops the door bolts, and mending it does not raise them. If the wire is cut, trying to raise the door bolts will not work.
*	two wires for backup power.
		Sending a pulse through either one causes a breaker to trip,
		but this does not disable it unless main power is down too
		(in which case it is disabled for 1 minute or however long it takes main power to come back, whichever is shorter).
		Cutting either one disables the backup door power (allowing it to be crowbarred open, but disabling bolts-raising), but may electocute the user.
*	one wire for opening the door.
		Sending a pulse through this while the door has power makes it open the door if no access is required.
*	one wire for AI control.
		Sending a pulse through this blocks AI control for a second or so (which is enough to see the AI control light on the panel dialog go off and back on again).
		Cutting this prevents the AI from controlling the door unless it has hacked the door through the power connection (which takes about a minute).
		If both main and backup power are cut, as well as this wire, then the AI cannot operate or hack the door at all.
*	one wire for electrifying the door.
		Sending a pulse through this electrifies the door for 30 seconds.
		Cutting this wire electrifies the door, so that the next person to touch the door without insulated gloves gets electrocuted.
		(Currently it is also STAYING electrified until someone mends the wire)
*	one wire for controling door safetys.
		When active, door does not close on someone.  When cut, door will ruin someone's shit.
		When pulsed, door will immedately ruin someone's shit.
*	one wire for controlling door speed.
		When active, dor closes at normal rate.  When cut, door does not close manually.
		When pulsed, door attempts to close every tick.
*/



/obj/machinery/door/airlock/bumpopen(mob/living/user) //Airlocks now zap you when you 'bump' them open when they're electrified. --NeoFite
	if(!issilicon(usr))
		if(isElectrified())
			if(!justzap)
				if(shock(user, 100))
					justzap = 1
					spawn (10)
						justzap = 0
					return FALSE
			else /*if(justzap)*/
				return FALSE
		else if(prob(10) && operating == 0)
			var/mob/living/carbon/C = user
			if(istype(C) && C.hallucination_power > 25)
				to_chat(user, "<span class='danger'>You feel a powerful shock course through your body!</span>")
				user.adjustHalLoss(10)
				//user.Stun(10) salt pr, this is bullshit never really tricks anyone and does nothing but unrealisticlly block you cuz hur dur im shocked! when not
				return FALSE
	..()

/obj/machinery/door/airlock/proc/isElectrified()
	if(electrified_until != 0)
		return TRUE
	return FALSE

/obj/machinery/door/airlock/proc/isWireCut(wireIndex)
	// You can find the wires in the datum folder.
	return wires.IsIndexCut(wireIndex)

/obj/machinery/door/airlock/proc/canAIControl()
	return ((aiControlDisabled!=1) && (!isAllPowerLoss()));

/obj/machinery/door/airlock/proc/canAIHack()
	return ((aiControlDisabled==1) && (!hackProof) && (!isAllPowerLoss()));

/obj/machinery/door/airlock/proc/arePowerSystemsOn()
	if (stat & (NOPOWER|BROKEN))
		return FALSE
	return (main_power_lost_until==0 || backup_power_lost_until==0)

/obj/machinery/door/airlock/requiresID()
	return !(isWireCut(AIRLOCK_WIRE_IDSCAN) || aiDisabledIdScanner)

/obj/machinery/door/airlock/proc/isAllPowerLoss()
	if(stat & (NOPOWER|BROKEN))
		return TRUE
	if(mainPowerCablesCut() && backupPowerCablesCut())
		return TRUE
	return FALSE

/obj/machinery/door/airlock/proc/mainPowerCablesCut()
	return isWireCut(AIRLOCK_WIRE_MAIN_POWER1) || isWireCut(AIRLOCK_WIRE_MAIN_POWER2)

/obj/machinery/door/airlock/proc/backupPowerCablesCut()
	return isWireCut(AIRLOCK_WIRE_BACKUP_POWER1) || isWireCut(AIRLOCK_WIRE_BACKUP_POWER2)

/obj/machinery/door/airlock/proc/loseMainPower()
	main_power_lost_until = mainPowerCablesCut() ? -1 : SecondsToTicks(60)
	if(main_power_lost_until > 0)
		addtimer(CALLBACK(src, PROC_REF(regainMainPower)), main_power_lost_until)

	// If backup power is permanently disabled then activate in 10 seconds if possible, otherwise it's already enabled or a timer is already running
	if(backup_power_lost_until == -1 && !backupPowerCablesCut())
		backup_power_lost_until = SecondsToTicks(10)
		addtimer(CALLBACK(src, PROC_REF(regainBackupPower)), backup_power_lost_until)

	// Disable electricity if required
	if(electrified_until && isAllPowerLoss())
		electrify(0)

/obj/machinery/door/airlock/proc/loseBackupPower()
	backup_power_lost_until = backupPowerCablesCut() ? -1 : SecondsToTicks(60)
	if(backup_power_lost_until > 0)
		addtimer(CALLBACK(src, PROC_REF(regainBackupPower)), backup_power_lost_until)

	// Disable electricity if required
	if(electrified_until && isAllPowerLoss())
		electrify(0)

/obj/machinery/door/airlock/proc/regainMainPower()
	if(!mainPowerCablesCut())
		main_power_lost_until = 0
		// If backup power is currently active then disable, otherwise let it count down and disable itself later
		if(!backup_power_lost_until)
			backup_power_lost_until = -1

/obj/machinery/door/airlock/proc/regainBackupPower()
	if(!backupPowerCablesCut())
		// Restore backup power only if main power is offline, otherwise permanently disable
		backup_power_lost_until = main_power_lost_until == 0 ? -1 : 0

/obj/machinery/door/airlock/proc/electrify(duration, feedback = 0)
	var/message = ""
	if(isWireCut(AIRLOCK_WIRE_ELECTRIFY) && arePowerSystemsOn())
		message = text("The electrification wire is cut - Door permanently electrified.")
		electrified_until = -1
	else if(duration && !arePowerSystemsOn())
		message = text("The door is unpowered - Cannot electrify the door.")
		electrified_until = 0
	else if(!duration && electrified_until != 0)
		message = "The door is now un-electrified."
		electrified_until = 0
	else if(duration)	//electrify door for the given duration seconds
		if(usr)
			shockedby += text("\[[time_stamp()]\] - [usr](ckey:[usr.ckey])")
			usr.attack_log += text("\[[time_stamp()]\] <font color='red'>Electrified the [name] at [x] [y] [z]</font>")
		else
			shockedby += text("\[[time_stamp()]\] - EMP)")
		message = "The door is now electrified [duration == -1 ? "permanently" : "for [duration] second\s"]."
		electrified_until = duration == -1 ? -1 : SecondsToTicks(duration)
		if(electrified_until > 0)
			addtimer(CALLBACK(src, PROC_REF(electrify)), electrified_until)

	if(feedback && message)
		to_chat(usr, message)

/obj/machinery/door/airlock/proc/set_idscan(activate, feedback = 0)
	var/message = ""
	if(isWireCut(AIRLOCK_WIRE_IDSCAN))
		message = "The IdScan wire is cut - IdScan feature permanently disabled."
	else if(activate && aiDisabledIdScanner)
		aiDisabledIdScanner = 0
		message = "IdScan feature has been enabled."
	else if(!activate && !aiDisabledIdScanner)
		aiDisabledIdScanner = 1
		message = "IdScan feature has been disabled."

	if(feedback && message)
		to_chat(usr, message)

/obj/machinery/door/airlock/proc/set_safeties(activate, feedback = 0)
	var/message = ""
	// Safeties!  We don't need no stinking safeties!
	if (isWireCut(AIRLOCK_WIRE_SAFETY))
		message = text("The safety wire is cut - Cannot enable safeties.")
	else if (!activate && safe)
		safe = 0
	else if (activate && !safe)
		safe = 1

	if(feedback && message)
		to_chat(usr, message)

// shock user with probability prb (if all connections & power are working)
// returns TRUE (1) if shocked, FALSE (0) otherwise
// The preceding comment was borrowed from the grille's shock script
/obj/machinery/door/airlock/shock(mob/user, prb)
	if(!arePowerSystemsOn())
		return FALSE
	if(hasShocked)
		return FALSE	//Already shocked someone recently?
	if(..())
		hasShocked = TRUE
		sleep(10)
		hasShocked = FALSE
		return TRUE
	else
		return FALSE

/obj/machinery/door/airlock/proc/force_wedge_item(obj/item/tool/T)
	T.forceMove(src)
	wedged_item = T
	update_icon()
	verbs -= /obj/machinery/door/airlock/proc/try_wedge_item
	verbs += /obj/machinery/door/airlock/proc/take_out_wedged_item

/obj/machinery/door/airlock/proc/try_wedge_item()
	set name = "Wedge item"
	set category = "Object"
	set src in view(1)

	if(!isliving(usr))
		to_chat(usr, SPAN_WARNING("You can't do this."))
		return
	var/obj/item/tool/T = usr.get_active_hand()
	if(istype(T) && T.w_class >= ITEM_SIZE_NORMAL && !istype(T,/obj/item/tool/psionic_omnitool) && !istype(T,/obj/item/tool/knife/psionic_blade)) // We do the checks before proc call, because see "proc overhead".
		if(istype(T,/obj/item/tool/psionic_omnitool) || istype(T,/obj/item/tool/knife/psionic_blade))
			to_chat(usr, SPAN_NOTICE("You can't wedge your psionic item in."))
			return
		if(!density)
			usr.drop_item()
			force_wedge_item(T)
			to_chat(usr, SPAN_NOTICE("You wedge [T] into [src]."))
		else
			to_chat(usr, SPAN_NOTICE("[T] can't be wedged into [src], while [src] is closed."))

/obj/machinery/door/airlock/proc/take_out_wedged_item()
	set name = "Remove Blockage"
	set category = "Object"
	set src in view(1)

	if(!isliving(usr) || usr.incapacitated())
		return

	if(wedged_item)
		wedged_item.forceMove(drop_location())
		if(usr)
			usr.put_in_hands(wedged_item)
			to_chat(usr, SPAN_NOTICE("You took [wedged_item] out of [src]."))
		wedged_item = null
		verbs -= /obj/machinery/door/airlock/proc/take_out_wedged_item
		verbs += /obj/machinery/door/airlock/proc/try_wedge_item
		update_icon()

/obj/machinery/door/airlock/AltClick(mob/user)
	if(Adjacent(user))
		wedged_item ? take_out_wedged_item() : try_wedge_item()

/obj/machinery/door/airlock/MouseDrop(obj/over_object)
	if(ishuman(usr) && usr == over_object && !usr.incapacitated() && Adjacent(usr))
		take_out_wedged_item(usr)
		return
	return ..()

/obj/machinery/door/airlock/examine(mob/user)
	..()
	if(wedged_item)
		to_chat(user, "You can see \icon[wedged_item] [wedged_item] wedged into it.")

/obj/machinery/door/airlock/proc/generate_wedge_overlay()
	var/cache_string = "[wedged_item.icon]||[wedged_item.icon_state]||[wedged_item.overlays.len]||[wedged_item.underlays.len]"

	if(!GLOB.wedge_icon_cache[cache_string])
		var/icon/I = getFlatIcon(wedged_item, SOUTH)

		// #define COOL_LOOKING_SHIFT_USING_CROWBAR_RIGHT 14, #define COOL_LOOKING_SHIFT_USING_CROWBAR_DOWN 6 - throw a rock at me if this looks less magic.
		I.Shift(SOUTH, 6) // These numbers I got by sticking the crowbar in and looking what will look good.
		I.Shift(EAST, 14)
		I.Turn(45)

		GLOB.wedge_icon_cache[cache_string] = I
		underlays += I
	else
		underlays += GLOB.wedge_icon_cache[cache_string]

/obj/machinery/door/airlock/update_icon()
	set_light(0)
	if(overlays.len)
		cut_overlays()
	if(underlays.len)
		underlays.Cut()
	if(density)
		if(locked && lights && arePowerSystemsOn())
			icon_state = "door_locked"
			set_light(1.5, 0.5, COLOR_RED_LIGHT)
		else
			icon_state = "door_closed"
		if(p_open || welded)
			cut_overlays()
			if(p_open)
				add_overlay(image(icon, "panel_open"))
			if (!(stat & NOPOWER))
				if(stat & BROKEN)
					add_overlay(image(icon, "sparks_broken"))
				else if (health < maxHealth * 3/4)
					add_overlay(image(icon, "sparks_damaged"))
			if(welded)
				add_overlay(image(icon, "welded"))
		else if (health < maxHealth * 3/4 && !(stat & NOPOWER))
			add_overlay(image(icon, "sparks_damaged"))
	else
		icon_state = "door_open"
		if((stat & BROKEN) && !(stat & NOPOWER))
			add_overlay(image(icon, "sparks_open"))
	if(wedged_item)
		generate_wedge_overlay()

/obj/machinery/door/airlock/do_animate(animation)
	switch(animation)
		if("opening")
			if(overlays.len)
				cut_overlays()
			if(p_open)
				flick("o_door_opening", src)  //can not use flick due to BYOND bug updating over-lays right before flicking
				update_icon()
			else
				flick("door_opening", src)//[stat ? "_stat":]
				update_icon()
		if("closing")
			if(overlays.len)
				cut_overlays()
			if(p_open)
				flick("o_door_closing", src)
				update_icon()
			else
				flick("door_closing", src)
				update_icon()
		if("spark")
			if(density)
				flick("door_spark", src)
		if("deny")
			if(density && arePowerSystemsOn())
				flick("door_deny", src)
				playsound(loc, 'sound/machines/Custom_deny.ogg', 50, 1, -2)
	return

// AIs being able to actually use buttons is handled in ui_act
// we want it to remain STATUS_INTERACTIVE so they can hit the hack button
/obj/machinery/door/airlock/CanUseTopic(mob/user)
	if(operating < 0)
		to_chat(user, SPAN_WARNING("Unable to interface: Internal error."))
		return STATUS_CLOSE
	if(isAllPowerLoss())
		to_chat(user, SPAN_WARNING("Unable to interface: Connection timed out."))
		return STATUS_CLOSE
	. = ..()

/obj/machinery/door/airlock/attack_ai(mob/user as mob)
	ui_interact(user)

/obj/machinery/door/airlock/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AiAirlock", name)
		ui.open()

/obj/machinery/door/airlock/ui_data(mob/user)
	var/list/data = list()

	// Allow silicons to hack into an airlock via the UI
	data["allowed"] = user_allowed_ai(user) || isghost(user) // Ghosts can see the full UI but not touch it
	data["aiHacking"] = aiHacking
	data["canHack"] = canAIHack()

	var/list/power = list()
	power["main"] = main_power_lost_until > 0 ? 0 : 2
	power["main_timeleft"] = round(main_power_lost_until > 0 ? max(main_power_lost_until - world.time,	0) / 10 : main_power_lost_until, 1)
	power["backup"] = backup_power_lost_until > 0 ? 0 : 2
	power["backup_timeleft"] = round(backup_power_lost_until > 0 ? max(backup_power_lost_until - world.time, 0) / 10 : backup_power_lost_until, 1)
	data["power"] = power

	data["shock"] = (electrified_until == 0) ? 2 : 0
	data["shock_timeleft"] = round(electrified_until > 0 ? max(electrified_until - world.time, 	0) / 10 : electrified_until, 1)
	data["id_scanner"] = !aiDisabledIdScanner
	data["locked"] = locked // bolted
	data["lights"] = lights // bolt lights
	data["safe"] = safe // safeties
	data["speed"] = normalspeed // safe speed
	data["welded"] = welded // welded
	data["opened"] = !density // opened

	var/list/wire = list()
	wire["main_1"] = !wires.IsIndexCut(AIRLOCK_WIRE_MAIN_POWER1)
	wire["main_2"] = !wires.IsIndexCut(AIRLOCK_WIRE_MAIN_POWER2)
	wire["backup_1"] = !wires.IsIndexCut(AIRLOCK_WIRE_BACKUP_POWER1)
	wire["backup_2"] = !wires.IsIndexCut(AIRLOCK_WIRE_BACKUP_POWER2)
	wire["shock"] = !wires.IsIndexCut(AIRLOCK_WIRE_ELECTRIFY)
	wire["id_scanner"] = !wires.IsIndexCut(AIRLOCK_WIRE_IDSCAN)
	wire["bolts"] = !wires.IsIndexCut(AIRLOCK_WIRE_DOOR_BOLTS)
	wire["lights"] = !wires.IsIndexCut(AIRLOCK_WIRE_LIGHT)
	wire["safe"] = !wires.IsIndexCut(AIRLOCK_WIRE_SAFETY)
	wire["timing"] = !wires.IsIndexCut(AIRLOCK_WIRE_SPEED)
	data["wires"] = wire

	return data

/obj/machinery/door/airlock/proc/user_allowed_ai(mob/user)
	var/allowed = (issilicon(user) && canAIControl(user))
	if(!allowed && isAdminGhostAI(user))
		allowed = TRUE
	return allowed

/obj/machinery/door/airlock/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(issilicon(usr))
		switch(action)
			if("hack")
				if(canAIHack())
					hack(usr)
				else
					to_chat(usr, SPAN_WARNING("Unable to hack airlock."))
				// Play directly into their head
				usr.playsound_local(null, 'sound/machines/synth_buttonpress.ogg', 100, is_global = TRUE)
				return TRUE

	if(!user_allowed_ai(usr))
		return TRUE

	switch(action)
		if("disrupt-main")
			if(!main_power_lost_until)
				loseMainPower()
			else
				to_chat(usr, "<span class='warning'>Main power is already offline.</span>")
			. = TRUE
		if("disrupt-backup")
			if(!backup_power_lost_until)
				loseBackupPower()
			else
				to_chat(usr, "<span class='warning'>Backup power is already offline.</span>")
			. = TRUE
		if("shock-restore")
			electrify(0, 1)
			. = TRUE
		if("shock-temp")
			electrify(30, 1)
			. = TRUE
		if("shock-perm")
			electrify(-1, 1)
			. = TRUE
		if("idscan-toggle")
			set_idscan(aiDisabledIdScanner, 1)
			. = TRUE
		if("bolt-toggle")
			toggle_bolt(usr)
			. = TRUE
		if("light-toggle")
			if(wires.IsIndexCut(AIRLOCK_WIRE_LIGHT))
				to_chat(usr, "The bolt lights wire is cut - The door bolt lights are permanently disabled.")
				return TRUE
			lights = !lights
			update_icon()
			. = TRUE
		if("safe-toggle")
			set_safeties(!safe, 1)
			. = TRUE
		if("speed-toggle")
			if(wires.IsIndexCut(AIRLOCK_WIRE_SPEED))
				to_chat(usr, "The timing wire is cut - Cannot alter timing.")
				return TRUE
			normalspeed = !normalspeed
			. = TRUE
		if("open-close")
			user_toggle_open(usr)
			. = TRUE

	if(.)
		// Play directly into their head
		usr.playsound_local(null, 'sound/machines/synth_buttonpress.ogg', 100, is_global = TRUE)
		update_icon()

/obj/machinery/door/airlock/proc/toggle_bolt(mob/user)
	if(!user_allowed_ai(user))
		return
	if(wires.IsIndexCut(AIRLOCK_WIRE_DOOR_BOLTS))
		to_chat(user, SPAN_WARNING("The door bolt drop wire is cut - you can't toggle the door bolts."))
		return
	if(locked)
		if(!arePowerSystemsOn())
			to_chat(user, SPAN_WARNING("The door has no power - you can't raise the door bolts."))
		else
			unlock()
			to_chat(user, SPAN_NOTICE("The door bolts have been raised."))
	else
		lock()
		to_chat(user, SPAN_WARNING("The door bolts have been dropped."))

/obj/machinery/door/airlock/proc/user_toggle_open(mob/user)
	if(!user_allowed_ai(user))
		return
	if(welded)
		to_chat(user, SPAN_WARNING("The airlock has been welded shut!"))
	else if(locked)
		to_chat(user, SPAN_WARNING("The door bolts are down!"))
	else if(!density)
		close()
	else
		open()

/obj/machinery/door/airlock/proc/hack(mob/user as mob)
	if(!aiHacking)
		aiHacking = TRUE
		spawn(20)
			//TODO: Make this take a minute
			to_chat(user, "Airlock AI control has been blocked. Beginning fault-detection.")
			sleep(50)
			if(canAIControl())
				to_chat(user, "Alert cancelled. Airlock control has been restored without our assistance.")
				aiHacking = FALSE
				return
			else if(!canAIHack(user))
				to_chat(user, "We've lost our connection! Unable to hack airlock.")
				aiHacking = FALSE
				return
			to_chat(user, "Fault confirmed: airlock control wire disabled or cut.")
			sleep(20)
			to_chat(user, "Attempting to hack into airlock. This may take some time.")
			sleep(200)
			if(canAIControl())
				to_chat(user, "Alert cancelled. Airlock control has been restored without our assistance.")
				aiHacking = FALSE
				return
			else if(!canAIHack(user))
				to_chat(user, "We've lost our connection! Unable to hack airlock.")
				aiHacking = FALSE
				return
			to_chat(user, "Upload access confirmed. Loading control program into airlock software.")
			sleep(170)
			if(canAIControl())
				to_chat(user, "Alert cancelled. Airlock control has been restored without our assistance.")
				aiHacking = FALSE
				return
			else if(!canAIHack(user))
				to_chat(user, "We've lost our connection! Unable to hack airlock.")
				aiHacking = FALSE
				return
			to_chat(user, "Transfer complete. Forcing airlock to execute program.")
			sleep(50)
			//disable blocked control
			aiControlDisabled = 2
			to_chat(user, "Receiving control information from airlock.")
			sleep(10)
			//bring up airlock dialog
			aiHacking = FALSE
			if (user)
				attack_ai(user)

/obj/machinery/door/airlock/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if (isElectrified())
		if (istype(mover, /obj/item))
			var/obj/item/i = mover
			if (i.matter && (MATERIAL_STEEL in i.matter) && i.matter[MATERIAL_STEEL] > 0)
				var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
				s.set_up(5, 1, src)
				s.start()
	return ..()

/obj/machinery/door/airlock/attack_hand(mob/user as mob)
	if(!issilicon(usr))
		if(isElectrified())
			if(shock(user, 100))
				return

	if(user.a_intent == I_GRAB && wedged_item && !user.get_active_hand())
		take_out_wedged_item(user)
		return

	if(p_open)
		user.set_machine(src)
		wires.Interact(user)
	else
		..(user)
	return

/obj/machinery/door/airlock/attackby(obj/item/I, mob/user)
	if(!issilicon(usr))
		if(isElectrified())
			if(shock(user, 75))
				return
	if(istype(I, /obj/item/taperoll))
		return
	add_fingerprint(user)

	//Harm intent overrides other actions
	if(density && user.a_intent == I_HURT && !I.GetIdCard())
		hit(user, I)
		return

	if(istype(I, /obj/item/keys))
		if(used_now)
			to_chat(user, SPAN_WARNING("You are already looking for the key!")) //don't want people stacking odds
			return
		used_now = TRUE
		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(istype(I, /obj/item/keys/lockpicks))
				playsound(loc, 'sound/items/keychainrattle.ogg', 30, 1, -2)
			else
				playsound(loc, 'sound/items/keychainrattle.ogg', 700, 1, -2)
			if(do_after(user, 250, src)) //in ms so half a min of sitting their trying
				used_now = FALSE
				if(locked)
					to_chat(user, SPAN_NOTICE("Even with the right key you can't open \"deadbolts\"!"))
					used_now = FALSE
					return
				if(prob(key_odds+1) && H.stats.getPerk(PERK_JINGLE_JANGLE)) //minmium 1%
					to_chat(user, SPAN_NOTICE("You found the correct key!"))
					open(0)
					key_odds = 100 //If we open it we know the combo
					used_now = FALSE
					return
				to_chat(user, SPAN_NOTICE("Damn wrong key!"))
				key_odds += 1 //We dont try the same key over and over!
				used_now = FALSE
			else
				to_chat(user, SPAN_DANGER("Key code punch cancelled"))
				used_now = FALSE
				return
			used_now = FALSE
			return
		return

	var/tool_type = I.get_tool_type(user, list(QUALITY_PRYING, QUALITY_SCREW_DRIVING, QUALITY_WELDING, p_open ? QUALITY_PULSING : null, p_open ? QUALITY_HAMMERING : null), src)
	switch(tool_type)
		if(QUALITY_PRYING)
			if(!repairing)
				if(I.use_tool(user, src, WORKTIME_FAST, tool_type, FAILCHANCE_VERY_EASY,  required_stat = list(STAT_MEC, STAT_ROB)))
					if(p_open && (operating < 0 || (!operating && welded && !arePowerSystemsOn() && density && (!locked || (stat & BROKEN)))) )
						to_chat(user, SPAN_NOTICE("You removed the airlock electronics!"))

						var/obj/structure/door_assembly/da = new assembly_type(loc)
						if (istype(da, /obj/structure/door_assembly/multi_tile))
							da.set_dir(dir)

		 				da.anchored = TRUE
						if(mineral)
							da.glass = mineral
						else if(glass && !da.glass)
							da.glass = 1
						da.state = 1
						da.created_name = name
						da.update_state()

						if(operating == -1 || (stat & BROKEN))
							new /obj/item/circuitboard/broken(loc)
							operating = FALSE
						else
							if (!electronics) create_electronics()

							electronics.loc = loc
							electronics = null

						qdel(src)
						return
					else if(arePowerSystemsOn())
						to_chat(user, SPAN_NOTICE("The airlock's motors resist your efforts to force it."))
					else if(locked)
						to_chat(user, SPAN_NOTICE("The airlock's bolts prevent it from being forced."))
					else
						if(density)
							spawn(0)
								open(I)
						else
							spawn(0)
								close(I)
			else
				..()
			return

		if(QUALITY_SCREW_DRIVING)
			var/used_sound = p_open ? 'sound/machines/Custom_screwdriveropen.ogg' :  'sound/machines/Custom_screwdriverclose.ogg'
			if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC, instant_finish_tier = 30, forced_sound = used_sound))
				if (p_open)
					if (stat & BROKEN)
						to_chat(usr, SPAN_WARNING("The panel is broken and cannot be closed."))
					else
						p_open = FALSE
				else
					p_open = TRUE
				update_icon()
			return

		if(QUALITY_WELDING)
			if(!repairing && !(operating > 0 ) && density)
				if(I.use_tool(user, src, WORKTIME_NEAR_INSTANT, tool_type, FAILCHANCE_VERY_EASY, required_stat = STAT_MEC))
					if(!welded)
						welded = TRUE
					else
						welded = FALSE
					update_icon()
			else
				..()
			return

		if(QUALITY_HAMMERING)
			if(stat & NOPOWER && locked)
				to_chat(user, SPAN_NOTICE("You start hammering the bolts into the unlocked position"))
				// long time and high chance to fail.
				if(I.use_tool(user, src, WORKTIME_LONG, tool_type, FAILCHANCE_VERY_HARD, required_stat = STAT_MEC))
					to_chat(user, SPAN_NOTICE("You unbolt the door."))
					locked = FALSE
			else
				to_chat(user, SPAN_NOTICE("You can\'t hammer away the bolts if the door is powered or not bolted."))
				return

		if(ABORT_CHECK)
			return

	if(istype(I, /obj/item/tool))
		return attack_hand(user)
	else if(istype(I, /obj/item/device/assembly/signaler))
		return attack_hand(user)
	else if(istype(I, /obj/item/pai_cable))	// -- TLE
		var/obj/item/pai_cable/cable = I
		cable.plugin(src, user)

	else
		..()
	return

/obj/machinery/door/airlock/plasma/attackby(C as obj, mob/user as mob)
	if(C)
		ignite(is_hot(C))
	..()

/obj/machinery/door/airlock/set_broken()
	p_open = TRUE
	stat |= BROKEN

	//If the door has been violently smashed open
	if (health <= 0)
		visible_message("<span class = 'warning'>\The [name] breaks open!</span>")
		unlock() //Then it is open
		open(TRUE)
	else if (secured_wires)
		lock()

	for (var/mob/O in viewers(src, null))
		if ((O.client && !( O.blinded )))
			O.show_message("[name]'s control panel bursts open, sparks spewing out!")

	var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
	s.set_up(5, 1, src)
	s.start()

	update_icon()
	return

/obj/machinery/door/airlock/open(forced=0)
	if(!can_open(forced))
		return FALSE
	use_power(360)	//360 W seems much more appropriate for an actuator moving an industrial door capable of crushing people

	//if the door is unpowered then it doesn't make sense to hear the woosh of a pneumatic actuator
	if(arePowerSystemsOn())
		playsound(loc, open_sound_powered, 70, 1, -2)
	else
		var/obj/item/tool/T = forced
		if (istype(T) && T.item_flags & SILENT)
			playsound(loc, open_sound_unpowered, 3, 1, -5) //Silenced tools can force open airlocks silently
		else if (istype(T) && T.item_flags & LOUD)
			playsound(loc, open_sound_unpowered, 500, 1, 10) //Loud tools can force open airlocks LOUDLY
		else
			playsound(loc, open_sound_unpowered, 70, 1, -1)

	var/obj/item/tool/T = forced
	if (istype(T) && T.item_flags & HONKING)
		playsound(loc, WORKSOUND_HONK, 70, 1, -2)

	if(closeOther != null && istype(closeOther, /obj/machinery/door/airlock/) && !closeOther.density)
		closeOther.close()
	return ..()

/obj/machinery/door/airlock/can_open(forced=0)
	if(!forced)
		if(!arePowerSystemsOn() || isWireCut(AIRLOCK_WIRE_OPEN_DOOR))
			return FALSE

	if(locked || welded)
		return FALSE
	return ..()

/obj/machinery/door/airlock/can_close(forced=0)
	if(locked || welded)
		return FALSE

	if(wedged_item)
		shake_animation(12)
		wedged_item.airlock_crush(DOOR_CRUSH_DAMAGE)
		return FALSE

	if(!forced)
		//despite the name, this wire is for general door control.
		if(!arePowerSystemsOn() || isWireCut(AIRLOCK_WIRE_OPEN_DOOR))
			return FALSE

	return ..()

/atom/movable/proc/blocks_airlock()
	return density

/obj/machinery/door/blocks_airlock()
	return FALSE

/obj/structure/window/blocks_airlock()
	return FALSE

/obj/machinery/mech_sensor/blocks_airlock()
	return FALSE

/mob/living/blocks_airlock()
	return TRUE

/mob/living/simple/blocks_airlock() //Airlocks crush cockroahes and mouses.
	return mob_size > MOB_SMALL

/atom/movable/proc/airlock_crush(crush_damage)
	return FALSE

/obj/structure/window/airlock_crush(crush_damage)
	ex_act(2)//Smashin windows

/obj/machinery/portable_atmospherics/canister/airlock_crush(crush_damage)
	. = ..()
	health -= crush_damage
	healthCheck()

/obj/structure/closet/airlock_crush(crush_damage)
	..()
	damage(crush_damage)
	for(var/atom/movable/AM in src)
		AM.airlock_crush()
	return TRUE

/obj/item/tool/airlock_crush(crush_damage)
	. = ..() // Perhaps some function to this was planned, however currently this proc's return is not used anywhere, how peculiar. ~Luduk
	// #define MAGIC_NANAKO_CONSTANT 0.4
	health -= crush_damage * degradation * (1 - get_tool_quality(QUALITY_PRYING) * 0.01) * 0.4

/mob/living/airlock_crush(crush_damage)
	. = ..()

	damage_through_armor(0.2 * crush_damage, BRUTE, BP_HEAD, ARMOR_MELEE)
	damage_through_armor(0.4 * crush_damage, BRUTE, BP_CHEST, ARMOR_MELEE)
	damage_through_armor(0.1 * crush_damage, BRUTE, BP_L_LEG, ARMOR_MELEE)
	damage_through_armor(0.1 * crush_damage, BRUTE, BP_R_LEG, ARMOR_MELEE)
	damage_through_armor(0.1 * crush_damage, BRUTE, BP_L_ARM, ARMOR_MELEE)
	damage_through_armor(0.1 * crush_damage, BRUTE, BP_R_ARM, ARMOR_MELEE)

	SetStunned(5)
	SetWeakened(5)
	var/turf/T = get_turf(src)
	T?.add_blood(src)

/mob/living/carbon/airlock_crush(crush_damage)
	. = ..()
	if(!((species?.flags & NO_PAIN) || (PAIN_LESS in mutations)))
		emote("painscream")

/mob/living/silicon/robot/airlock_crush(crush_damage)
	adjustBruteLoss(crush_damage)
	return FALSE

/obj/machinery/door/airlock/close(forced=0)
	if(!can_close(forced))
		return FALSE

	if(safe)
		for(var/turf/turf in locs)
			for(var/atom/movable/AM in turf)
				if(AM.blocks_airlock())
					if(autoclose && tryingToLock)
						addtimer(CALLBACK(src, PROC_REF(close)), 30 SECONDS)
					if(world.time > next_beep_at)
						playsound(loc, 'sound/machines/buzz-two.ogg', 30, 1, -1)
						next_beep_at = world.time + SecondsToTicks(120)
					return
				if(istype(AM, /obj/item/tool))
					var/obj/item/tool/T = AM
					if(T.w_class >= ITEM_SIZE_NORMAL)
						operating = TRUE
						density = TRUE
						do_animate("closing")
						sleep(7)
						force_wedge_item(AM)
						playsound(loc, 'sound/machines/airlock_creaking.ogg', 75, 1)
						shake_animation(12)
						sleep(7)
						playsound(loc, 'sound/machines/buzz-two.ogg', 30, 1, -1)
						density = FALSE
						do_animate("opening")
						operating = FALSE
						return

	for(var/turf/turf in locs)
		for(var/atom/movable/AM in turf)
			if(AM.airlock_crush(DOOR_CRUSH_DAMAGE))
				take_damage(DOOR_CRUSH_DAMAGE)

	use_power(360)	//360 W seems much more appropriate for an actuator moving an industrial door capable of crushing people
	tryingToLock = FALSE
	if(arePowerSystemsOn())
		playsound(loc, close_sound, 70, 1, -2)
	else
		var/obj/item/tool/T = forced
		if (istype(T) && T.item_flags & SILENT)
			playsound(loc, open_sound_unpowered, 3, 1, -5) //Silenced tools can force airlocks silently
		else if (istype(T) && T.item_flags & LOUD)
			playsound(loc, open_sound_unpowered, 500, 1, 10) //Loud tools can force open airlocks LOUDLY
		else
			playsound(loc, open_sound_unpowered, 70, 1, -2)

	var/obj/item/tool/T = forced
	if (istype(T) && T.item_flags & HONKING)
		playsound(loc, WORKSOUND_HONK, 70, 1, -2)

	..()

/obj/machinery/door/airlock/proc/lock(forced=0)
	if(locked)
		return FALSE

	if (operating && !forced)
		return FALSE

	locked = TRUE
	playsound(loc, 'sound/machines/Custom_bolts.ogg', 40, 1, 5)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return TRUE

/obj/machinery/door/airlock/proc/unlock(forced=0)
	if(!locked)
		return

	if (!forced)
		if(operating || !arePowerSystemsOn() || isWireCut(AIRLOCK_WIRE_DOOR_BOLTS))
			return

	locked = FALSE
	playsound(loc, 'sound/machines/Custom_boltsup.ogg', 40, 1, 5)
	for(var/mob/M in range(1,src))
		M.show_message("You hear a click from the bottom of the door.", 2)
	update_icon()
	return TRUE

/obj/machinery/door/airlock/allowed(mob/M)
	if(locked)
		return FALSE
	return ..(M)

/obj/machinery/door/airlock/New(newloc, obj/structure/door_assembly/assembly=null)
	..()

	//if assembly is given, create the new door from the assembly
	if (assembly && istype(assembly))
		assembly_type = assembly.type

		electronics = assembly.electronics
		electronics.loc = src

		//update the door's access to match the electronics'
		secured_wires = electronics.secure
		if(electronics.one_access)
			LAZYNULL(req_access)
			req_one_access = electronics.conf_access
		else
			LAZYNULL(req_one_access)
			req_access = electronics.conf_access

		//get the name from the assembly
		if(assembly.created_name)
			name = assembly.created_name
		else
			name = "[istext(assembly.glass) ? "[assembly.glass] airlock" : assembly.base_name]"

		//get the dir from the assembly
		set_dir(assembly.dir)

	//wires
	if(isOnAdminLevel(newloc))
		secured_wires = 1
	if (secured_wires)
		wires = new/datum/wires/airlock/secure(src)
	else
		wires = new/datum/wires/airlock(src)

/obj/machinery/door/airlock/Initialize()
	if(closeOtherId != null)
		for (var/obj/machinery/door/airlock/A in world)
			if(A.closeOtherId == closeOtherId && A != src)
				closeOther = A
				break
	verbs += /obj/machinery/door/airlock/proc/try_wedge_item
	. = ..()

/obj/machinery/door/airlock/Destroy()
	qdel(wires)
	wires = null
	qdel(wifi_receiver)
	wifi_receiver = null
	return ..()

// Most doors will never be deconstructed over the course of a round,
// so as an optimization defer the creation of electronics until
// the airlock is deconstructed
/obj/machinery/door/airlock/proc/create_electronics()
	//create new electronics
	if (secured_wires)
		electronics = new/obj/item/airlock_electronics/secure(loc)
	else
		electronics = new/obj/item/airlock_electronics(loc)

	//update the electronics to match the door's access
	if(!req_access)
		check_access()
	if(LAZYLEN(req_access))
		electronics.conf_access = req_access
	else if (LAZYLEN(req_one_access))
		electronics.conf_access = req_one_access
		electronics.one_access = TRUE

/obj/machinery/door/airlock/emp_act(severity)
	if(prob(20/severity))
		spawn(0)
			open()
	if(prob(40/severity))
		var/duration = SecondsToTicks(30 / severity)
		if(electrified_until > -1 && (duration + world.time) > electrified_until)
			electrify(duration)
	..()

/obj/machinery/door/airlock/power_change() //putting this is obj/machinery/door itself makes non-airlock doors turn invisible for some reason
	..()
	if(stat & NOPOWER)
		// If we lost power, disable electrification
		// Keeping door lights on, runs on internal battery or something.
		electrified_until = 0
	update_icon()

/obj/machinery/door/airlock/proc/prison_open()
	if(arePowerSystemsOn())
		unlock()
		open()
		lock()
	return


//Override to check locked var
/obj/machinery/door/airlock/hit(mob/user, obj/item/I)
	var/obj/item/W = I
	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN*1.5)
	var/calc_damage = W.force*W.structure_damage_factor
	var/quiet = FALSE
	if (istool(I))
		var/obj/item/tool/T = I
		quiet = T.item_flags & SILENT

	if (locked)
		calc_damage *= 0.66
	calc_damage -= resistance
	user.do_attack_animation(src)
	if(calc_damage <= 0)
		user.visible_message(SPAN_DANGER("\The [user] hits \the [src] with \the [W] with no visible effect."))
		quiet ? null : playsound(loc, hitsound, 20, 1)
	else
		user.visible_message(SPAN_DANGER("\The [user] forcefully strikes \the [src] with \the [W]!"))
		playsound(loc, hitsound, quiet? 3: calc_damage*2.0, 1, 3,quiet?-5 :2)
		take_damage(W.force)


/obj/machinery/door/airlock/take_damage(damage)
	if (isnum(damage) && locked)
		damage *= 0.66 //The bolts reinforce the door, reducing damage taken

	return ..(damage)
