extends Room

var allowed_rooms = {
	0: ["Plan", "Office"],
	1: ["Plan", "Office"],
	2: ["Plan", "Office", "Kitchen", "Passage", "Storage"],
	3: ["Plan", "Office", "Kitchen", "Passage", "Storage"],
	4: ["Plan", "Office", "Kitchen", "Passage", "Storage"],
	5: ["Plan", "Office", "Kitchen", "Storage", "Boss"]
}

var room_not_allowed_txt = "I shouldn't go there."
var break_txt = "I should take a break first."

var watering_task = null
var drop_coffee_task = null

func setup_day(day, post_break):
	match day:
		0:
			watering_task = null
			drop_coffee_task = null
		1:
			watering_task = null
			drop_coffee_task = null
		2:
			watering_task = $Tasks/Day3/Task_water_Hallway_Plant
			drop_coffee_task = $Tasks/Day3/Task_drop_Coffee_boss
		3:
			watering_task = $Tasks/Day4/Task_water_Hallway_Plant
			drop_coffee_task = $Tasks/Day4/Task_drop_Coffee_boss
		4:
			watering_task = $Tasks/Day5/Task_water_Hallway_Plant
			drop_coffee_task = $Tasks/Day5/Task_drop_Coffee_boss
		5:
			watering_task = null
			drop_coffee_task = null

func try_enter_room(room, break_active_txt=break_txt, not_allowed_txt=room_not_allowed_txt):
	if Global.game_manager.current_day == 5:
		if Global.talked_to_aliens_task_received == 0 and room != "Kitchen":
			Global.text_manager.display_interaction_text("I should hurry to the kitchen!")
			return
	if Global.game_manager.current_day >= 3 and Global.time_manager.break_active and room == "Kitchen":
		Global.room_manager.change_room_to(room)
		return
	if Global.game_manager.current_day >= 3 and !Global.time_manager.day_active and room == "Office":
		Global.room_manager.change_room_to(room)
		return
	if Global.game_manager.allow_interaction:
		if room in allowed_rooms[Global.game_manager.current_day]:
			Global.room_manager.change_room_to(room)
		elif Global.time_manager.break_active:
			Global.text_manager.display_interaction_text(break_txt)
		else:
			Global.audio_manager.play_sfx(AudioManager.SFX.DOOR_LOCKED)
			Global.text_manager.display_interaction_text(room_not_allowed_txt)

func _on_hr_pressed():
	try_enter_room("Office")

func _on_boss_pressed():
	if drop_coffee_task != null and !(drop_coffee_task as Task).get_task_completed():
		if Global.inventory.has_item(Global.inventory.Items.COFFEE_CUP):
			drop_coffee_task.start_task()
		else:
			Global.text_manager.display_interaction_text("I need to bring Big D his coffee.")
		return
	try_enter_room("Boss")

func _on_kitchen_pressed():
	try_enter_room("Kitchen")

func _on_storage_pressed():
	try_enter_room("Storage")

func _on_passage_pressed():
	try_enter_room("Passage")

func _on_plan_pressed():
	try_enter_room("Plan")

func _on_restaurant_pressed():
	if !Global.time_manager.day_active:
		if Global.game_manager.current_day < 3:
			Global.room_manager.post_day.emit()
		else:
			Global.text_manager.display_interaction_text("I will sleep on the couch in my office today.")
		return
	if Global.game_manager.current_day >= 3:
		if Global.game_manager.current_day != 5 and Global.time_manager.break_active:
			Global.text_manager.display_interaction_text("I should just grab something from the kitchen.")
			return
		Global.text_manager.display_interaction_text("I don't have time to leave.")
		return
	if Global.time_manager.break_active:
		Global.ui_manager.taskUI.visible = false
		Global.room_manager.change_room_to("Restaurant")
		Global.audio_manager.play_loop_sfx(AudioManager.SFX.RESTAURANT)
	else:
		Global.text_manager.display_interaction_text("I don't have time to leave.")

func _on_plant_pressed():
	if !Global.game_manager.allow_interaction: return
	if watering_task != null:
		if (watering_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already watered this plant today.")
		elif !Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
			Global.text_manager.display_interaction_text("I need the watering can for this.")
		else:
			watering_task.start_task()
			Global.audio_manager.play_sfx(AudioManager.SFX.TASK_WATER)
	else:
		Global.text_manager.display_interaction_text("I don't need to water the plant.")
