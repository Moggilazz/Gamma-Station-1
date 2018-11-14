var/list/fire_controls = list()

/obj/machinery/computer/space_defence
	name = "Station Alert Console"
	desc = "Used to access the station's automated alert system."
	icon = 'code/modules/event/computers.dmi'
	icon_state = "tracker"
	light_color = "#e6ffff"
//	circuit = /obj/item/weapon/circuitboard/stationalert
//	var/alarms = list("Fire"=list(), "Atmosphere"=list(), "Power"=list())
/*
/obj/machinery/computer/space_defence/atom_init()
	. = ..()
	if(!invasion_controller)
		invasion_controller = locate()
*/
/obj/machinery/computer/space_defence/ui_interact(mob/user)
	var/dat = "<html><head><title>[station_name()] Space Defence</title><META HTTP-EQUIV='Refresh' CONTENT='10'></head><body>"

	dat += "<span>Current contacts:</span><a href='?src=\ref[src];lockon=1'>Lock on</a><br>"
	dat += {"<table style="text-align:center;" cellspacing="0" width="100%">"}
	dat += "<tr><th>Contact number</th><th>Target name</th><th>Target class</th><th>Target coordinates</th></tr>"
	if(SSinvasion.processing_intruders.len)
		for(var/S in SSinvasion.processing_intruders)
			var/datum/intruder/I = S
			dat += "<tr><td text-align:center><a href='?src=\ref[src];kekon=\ref[I]'>[I.un_id]</a></td><td text-align:center> [I.contact_name]</td><td text-align:center>[I.class]</td><td text-align:center>X-[I.current_x];Y-[I.current_y]</td></tr>"
	dat += "</table>"
//			var/state = image(icon = 'code/modules/event/intruders.dmi', icon_state = "[I.content.image_state]")

/*
	var/datum/intruder_type/I = new /datum/intruder_type/zero

	dat += "[bicon(state)]"
	dat += "[I.name]"
	dat += "[I.class]"
*/
//	for (var/datum/intruder_type/I in invasion_controller.intruders_list)
//		dat += "[I.contact_name]"
//		dat += ""
/*	dat += "<A HREF='?src=\ref[user];mach_close=alerts'>Close</A><br><br>"
	for (var/cat in src.alarms)
		dat += text("<B>[]</B><BR>\n", cat)
		var/list/L = src.alarms[cat]
		if (L.len)
			for (var/alarm in L)
				var/list/alm = L[alarm]
				var/area/A = alm[1]
				var/list/sources = alm[3]
				dat += "<NOBR>"
				dat += "&bull; "
				dat += "[A.name]"
				if (sources.len > 1)
					dat += text(" - [] sources", sources.len)
				dat += "</NOBR><BR>\n"
		else
			dat += "-- All Systems Nominal<BR>\n"
		dat += "<BR>\n"
		*/
//	user << browse(entity_ja(dat), "window=alerts")
//	onclose(user, "alerts")

	var/datum/browser/popup = new(user, "tome_notes", "", 420, 520)
	popup.set_content(dat)
	popup.open()
	return 1

/obj/machinery/computer/space_defence/Topic(href, href_list)
	. = ..()
	if(!.)
		return

	if(href_list["lockon"])
		if(SSinvasion.processing_intruders.len)
			var/input = input("Please select a turret:") as null|anything in SSinvasion.processing_intruders
			to_chat(usr,"ti pidor")
	else if (href_list["kekon"])
		var/datum/intruder/I = locate(href_list["kekon"])
		if(I)
			to_chat(usr,"ti pidor")

	//	var/number = href_list["id"]
	//	var/input = input("Please select a turret:") as null|anything in fire_controls
	//	if(input)
	//		var/obj/machinery/computer/turret_control/T = input
	//		T.locked = number

	updateUsrDialog()