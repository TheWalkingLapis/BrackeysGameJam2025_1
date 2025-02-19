extends Room

var watering_can_pickup_task = null
var watering_can_drop_task = null

func setup_day(day, post_break):
	match day:
		0:
			watering_can_pickup_task = null
			watering_can_drop_task = null
		1:
			watering_can_pickup_task = null
			watering_can_drop_task = null
		2:
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day3/Task_Pick_up_Watering_Can
			if watering_can_drop_task != null and (watering_can_drop_task as Task).get_task_completed():
				watering_can_drop_task = null
			else:
				watering_can_drop_task = $Tasks/Day3/Task_drop_Watering_Can
		3:
			watering_can_pickup_task = null
			watering_can_drop_task = null
		4:
			watering_can_pickup_task = null
			watering_can_drop_task = null
		5:
			watering_can_pickup_task = null
			watering_can_drop_task = null

func _on_leave_room_pressed():
	Global.room_manager.change_room_to("Main_Hallway")

func _on_watering_can_hitbox_pressed():
	if Global.game_manager.allow_interaction:
		if watering_can_pickup_task != null and !(watering_can_pickup_task as Task).get_task_completed():
			if Global.inventory.is_empty():
				watering_can_pickup_task.start_task()
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")
		elif Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
			pass #TODO set can back
