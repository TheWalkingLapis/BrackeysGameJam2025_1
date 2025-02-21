extends Room

var wire_task = null

func setup_day(day, post_break):
	match day:
		0:
			wire_task = null
		1:
			wire_task = null
		2:
			wire_task = null
		3:
			wire_task = null
		4:
			wire_task = $Tasks/Day5/Task_Fix_Wires
		5:
			wire_task = $Tasks/Day6/Task_Fix_Wires

func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	Global.room_manager.change_room_to("Passage")


func _on_wirebox_pressed():
	if !Global.game_manager.allow_interaction: return
	if wire_task != null:
		if (wire_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already fixed these wires")
		else:
			wire_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I think this one is not broken")
