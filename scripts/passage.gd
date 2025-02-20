extends Room

var uranium_task = null
var hazmat_task = null
var wire_task = null

func setup_day(day, post_break):
	match day:
		0:
			uranium_task = null
			hazmat_task = null
			wire_task = null
		1:
			uranium_task = null
			hazmat_task = null
			wire_task = null
		2:
			if uranium_task != null and (uranium_task as Task).get_task_completed():
				uranium_task = null
			else:
				uranium_task = $Tasks/Day3/Task_drop_Uranium
			if hazmat_task != null and (hazmat_task as Task).get_task_completed():
				hazmat_task = null
			else:
				hazmat_task = $Tasks/Day3/Task_drop_Hazmat_Suit
			wire_task = null
		3:
			if uranium_task != null and (uranium_task as Task).get_task_completed():
				uranium_task = null
			else:
				uranium_task = $Tasks/Day4/Task_drop_Uranium
			if hazmat_task != null and (hazmat_task as Task).get_task_completed():
				hazmat_task = null
			else:
				hazmat_task = $Tasks/Day4/Task_drop_Hazmat_Suit
			wire_task = null
		4:
			if uranium_task != null and (uranium_task as Task).get_task_completed():
				uranium_task = null
			else:
				uranium_task = $Tasks/Day5/Task_drop_Uranium
			if hazmat_task != null and (hazmat_task as Task).get_task_completed():
				hazmat_task = null
			else:
				hazmat_task = $Tasks/Day5/Task_drop_Hazmat_Suit
			wire_task = null
		5:
			if uranium_task != null and (uranium_task as Task).get_task_completed():
				uranium_task = null
			else:
				uranium_task = $Tasks/Day6/Task_drop_Uranium
			if hazmat_task != null and (hazmat_task as Task).get_task_completed():
				hazmat_task = null
			else:
				hazmat_task = $Tasks/Day6/Task_drop_Hazmat_Suit
			wire_task = null

var allowed_rooms = {
	0: [],
	1: [],
	2: [],
	3: ["Control", "Reactor"],
	4: ["Control", "Reactor"],
	5: ["Control", "Reactor"]
}

var room_not_allowed_txt = "I shouldn't go there"
var break_txt = "I should take a break first"

func try_enter_room(room, break_active_txt=break_txt, not_allowed_txt=room_not_allowed_txt):
	if Global.game_manager.current_day >= 4 and Global.time_manager.break_active and room == "Kitchen":
		Global.room_manager.change_room_to(room)
		return
	if Global.game_manager.allow_interaction:
		if room in allowed_rooms[Global.game_manager.current_day]:
			Global.room_manager.change_room_to(room)
		elif Global.time_manager.break_active:
			Global.text_manager.display_interaction_text(break_txt)
		else:
			Global.text_manager.display_interaction_text(room_not_allowed_txt)

func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	Global.room_manager.change_room_to("Main_Hallway")


func _on_control_pressed():
	try_enter_room("Control")


func _on_reactor_pressed():
	try_enter_room("Reactor")

func _on_hazmat_hitbox_pressed():
	if !Global.game_manager.allow_interaction: return
	if hazmat_task != null and !(hazmat_task as Task).get_task_completed():
		if Global.inventory.has_item(Global.inventory.Items.HAZMAT_SUIT):
			hazmat_task.start_task()
		else:
			Global.text_manager.display_interaction_text("I need the bring the hazmat suit here")
	else:
		Global.text_manager.display_interaction_text("I already brought the hazmat suit")


func _on_uranium_hitbox_pressed():
	if !Global.game_manager.allow_interaction: return
	if uranium_task != null and !(uranium_task as Task).get_task_completed():
		if Global.inventory.has_item(Global.inventory.Items.URANIUM):
			uranium_task.start_task()
		else:
			Global.text_manager.display_interaction_text("I need the bring the uranium here")
	else:
		Global.text_manager.display_interaction_text("I already brought the uranium")


func _on_wirebox_pressed():
	if !Global.game_manager.allow_interaction: return
	if wire_task != null:
		if (wire_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already fixed these wires")
		else:
			wire_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I think this one is not broken")
