extends Room

@onready var watering_can_sprite = $Watering_Can_Hitbox/Watering_Can_Sprite

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
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day4/Task_Pick_up_Watering_Can
			if watering_can_drop_task != null and (watering_can_drop_task as Task).get_task_completed():
				watering_can_drop_task = null
			else:
				watering_can_drop_task = $Tasks/Day4/Task_drop_Watering_Can
		4:
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day5/Task_Pick_up_Watering_Can
			if watering_can_drop_task != null and (watering_can_drop_task as Task).get_task_completed():
				watering_can_drop_task = null
			else:
				watering_can_drop_task = $Tasks/Day5/Task_drop_Watering_Can
		5:
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day6/Task_Pick_up_Watering_Can
			if watering_can_drop_task != null and (watering_can_drop_task as Task).get_task_completed():
				watering_can_drop_task = null
			else:
				watering_can_drop_task = $Tasks/Day6/Task_drop_Watering_Can

func _on_leave_room_pressed():
	if !Global.game_manager.allow_interaction and !Global.time_manager.break_active: return
	if Global.game_manager.current_day == 4 and Global.time_manager.break_active: return
	Global.room_manager.change_room_to("Main_Hallway")

func _on_watering_can_hitbox_pressed():
	if Global.game_manager.allow_interaction:
		if watering_can_pickup_task != null and !(watering_can_pickup_task as Task).get_task_completed():
			if Global.inventory.is_empty():
				watering_can_pickup_task.start_task()
				watering_can_sprite.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up")
		elif watering_can_drop_task != null and !(watering_can_drop_task as Task).get_task_completed():
			if Global.watering_task_allow_discard_watering_can:
				if Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
					watering_can_drop_task.start_task()
					watering_can_sprite.visible = true
				else:
					Global.text_manager.display_interaction_text("I already watered the plants")
			else:
				Global.text_manager.display_interaction_text("I have to water the plants before I can put this back")


func _on_snack_pressed():
	if Global.game_manager.current_day == 4:
		if Global.time_manager.break_active:
			Global.time_manager.resume_after_break()
			return
		if Global.game_manager.allow_interaction:
			if Global.time_manager.post_break:
				Global.text_manager.display_interaction_text("I already had my lunch break")
			else:
				Global.text_manager.display_interaction_text("It's not time to eat something yet")
	elif Global.game_manager.current_day == 5:
		if Global.game_manager.allow_interaction:
			Global.text_manager.display_interaction_text("I really don't have time to eat something")
	else:
		if Global.game_manager.allow_interaction:
			Global.text_manager.display_interaction_text("I don't want to eat anything from the fridge")
