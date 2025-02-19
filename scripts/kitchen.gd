extends Room

var watering_can_pickup_task = null

func setup_day(day, post_break):
	match day:
		0:
			pass
		1:
			pass
		2:
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day3/Task_Pick_up_Watering_Can
		3:
			pass
		4:
			pass
		5:
			pass

func _on_leave_room_pressed():
	Global.room_manager.change_room_to("Main_Hallway")


func _on_watering_can_hitbox_pressed():
	if Global.game_manager.allow_interaction:
		if watering_can_pickup_task != null and !(watering_can_pickup_task as Task).get_task_completed():
			watering_can_pickup_task.start_task()
		elif Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
			pass #TODO set can back
