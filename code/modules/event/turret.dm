/obj/machinery/computer/turret_control
	name = "Turret Control "
	desc = ""
	icon = 'code/modules/event/computers.dmi'
	icon_state = "turret"
	light_color = "#e6ffff"
	var/obj/machinery/space_turret/linked_turret
	var/id = ""
	var/datum/intruder/locked

/obj/machinery/computer/turret_control/atom_init()
	. = ..()
	fire_controls |= src
	if(id)
		for(var/obj/machinery/space_turret/T in machines)
			if(T.comp_id == id)
				linked_turret = T

/obj/machinery/computer/turret_control/Destroy()
	fire_controls -= src
	return ..()

/obj/machinery/computer/turret_control/ui_interact(mob/user)
	var/dat = "<html><head><title>Turret [id] fire control</title><META HTTP-EQUIV='Refresh' CONTENT='10'></head><body>"
	dat += "<span>Locked contact:</span><br>"
	if(locked)
		dat += "<span>[locked.contact_name]</span><br>"

	var/datum/browser/popup = new(user, "fire control", "", 420, 520)
	popup.set_content(dat)
	popup.open()
	return 1
/obj/machinery/space_turret
	name = "turret"
	icon = 'code/modules/event/turret_small.dmi'
	icon_state = "ts"
	anchored = TRUE

	density = FALSE
	use_power = TRUE				//this turret uses and requires power
	idle_power_usage = 50		//when inactive, this turret takes up constant 50 Equipment power
	active_power_usage = 300	//when active, this turret takes up constant 300 Equipment power
	power_channel = EQUIP	//drains power from the EQUIPMENT channel
/*
	bound_width = 68
	bound_height = 68
*/

	var/comp_id = ""