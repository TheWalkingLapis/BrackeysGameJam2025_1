extends Room

@onready var watering_can_sprite = $Watering_Can_Hitbox/Watering_Can_Sprite
@onready var watering_can_hitbox = $Watering_Can_Hitbox

@export var normal_bg: Texture2D
@export var alien_bg: Texture2D

var watering_can_pickup_task = null
var watering_can_drop_task = null
var drop_cereal_task = null
var task_final = null

var signal_setup = false

func setup_day(day, post_break):
	if !signal_setup:
		signal_setup = true
		$Tasks/Day6/Task_Tetrominos.final_task_complete.connect(Global.game_manager._on_final_task_complete)
	Global.talked_to_aliens_task_received = 0
	if day != 5:
		$Background.texture = normal_bg
		$Aliens.visible = false
	else:
		$Background.texture = alien_bg
		$Aliens.visible = true
	match day:
		0:
			watering_can_pickup_task = null
			watering_can_drop_task = null
			drop_cereal_task = null
			task_final = null
		1:
			watering_can_pickup_task = null
			watering_can_drop_task = null
			drop_cereal_task = null
			task_final = null
		2:
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day3/Task_Pick_up_Watering_Can
			if watering_can_drop_task != null and (watering_can_drop_task as Task).get_task_completed():
				watering_can_drop_task = null
			else:
				watering_can_drop_task = $Tasks/Day3/Task_drop_Watering_Can
			drop_cereal_task = $Tasks/Day3/Task_drop_Cereal
			task_final = null
		3:
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day4/Task_Pick_up_Watering_Can
			if watering_can_drop_task != null and (watering_can_drop_task as Task).get_task_completed():
				watering_can_drop_task = null
			else:
				watering_can_drop_task = $Tasks/Day4/Task_drop_Watering_Can
			drop_cereal_task = $Tasks/Day4/Task_drop_Cereal
			task_final = null
		4:
			if watering_can_pickup_task != null and (watering_can_pickup_task as Task).get_task_completed():
				watering_can_pickup_task = null
			else:
				watering_can_pickup_task = $Tasks/Day5/Task_Pick_up_Watering_Can
			if watering_can_drop_task != null and (watering_can_drop_task as Task).get_task_completed():
				watering_can_drop_task = null
			else:
				watering_can_drop_task = $Tasks/Day5/Task_drop_Watering_Can
			drop_cereal_task = $Tasks/Day5/Task_drop_Cereal
			task_final = null
		5:
			watering_can_pickup_task = null
			watering_can_drop_task = null
			drop_cereal_task = null
			task_final = $Tasks/Day6/Task_Tetrominos
	watering_can_hitbox.visible = watering_can_drop_task != null

func _on_watering_can_hitbox_pressed():
	if Global.game_manager.allow_interaction:
		if watering_can_pickup_task != null and !(watering_can_pickup_task as Task).get_task_completed():
			if Global.inventory.is_empty():
				watering_can_pickup_task.start_task()
				watering_can_sprite.visible = false
			else:
				Global.text_manager.display_interaction_text("I have to empty my hands before I can pick this up.")
		elif watering_can_drop_task != null and !(watering_can_drop_task as Task).get_task_completed():
			if Global.watering_task_allow_discard_watering_can == 2:
				if Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
					watering_can_drop_task.start_task()
					watering_can_sprite.visible = true
				else:
					Global.text_manager.display_interaction_text("I already watered the plants.")
			else:
				Global.text_manager.display_interaction_text("I have to water the plants before I can put this back.")


func _on_snack_pressed():
	if Global.game_manager.current_day == 3:
		if Global.time_manager.break_active:
			Global.time_manager.resume_after_break()
			return
		if Global.game_manager.allow_interaction:
			if Global.time_manager.post_break:
				Global.text_manager.display_interaction_text("I already had my lunch break.")
			else:
				Global.text_manager.display_interaction_text("It's not time to eat something yet.")
	elif Global.game_manager.current_day == 4 or Global.game_manager.current_day == 5:
		if Global.game_manager.allow_interaction:
			Global.text_manager.display_interaction_text("I really don't have time to eat something.")
	else:
		if Global.game_manager.allow_interaction:
			Global.text_manager.display_interaction_text("I don't want to eat anything from the fridge.")


func _on_drawer_pressed():
	if Global.game_manager.allow_interaction:
		if drop_cereal_task != null and !(drop_cereal_task as Task).get_task_completed():
			if Global.inventory.has_item(Global.inventory.Items.CEREAL_BAR):
				drop_cereal_task.start_task()
			else:
				Global.text_manager.display_interaction_text("I have to bring the cereal bars here.")
		else:
			if Global.game_manager.current_day != 5:
				Global.text_manager.display_interaction_text("I already brought the cereal bars here.")

func _on_leave_pressed():
	if !Global.game_manager.allow_interaction and !Global.time_manager.break_active: return
	if Global.game_manager.current_day == 3 and Global.time_manager.break_active: return
	Global.room_manager.change_room_to("Main_Hallway")


func _on_aliens_pressed():
	if Global.inventory.has_item(Inventory.Items.PLUTONIUM):
		Global.inventory.drop()
		Global.plutonium_delivered = true
		Global.text_manager.display_interaction_text("Thank you earthling, but plutonium in it's raw form is useless for us. Please build us three fuel cores on the desk by assembling the raw plutonium into the given shape.")
		await Global.text_manager.finished_text
		$Aliens.visible = false
		Global.ui_manager.taskUI.ui_final_task()
		task_final.start_task()
	else:
		Global.text_manager.display_interaction_text("\"Hello lowly worker, we need your help. Bring us plutonium as fuel for our ship!
Otherwise we'll have to destroy your planet and use the force of the explosion to propel us into space to get to our home planet.
Make it quick, I'll give you 8 hours or earth will be exterminated!\"")
		await  Global.text_manager.finished_text
		Global.text_manager.display_interaction_text("Oh god, what should I do? I remember that I can order plutonium on my PC, but I need the code from the safe in Big D's office to unlock it.")
		await  Global.text_manager.finished_text
		Global.talked_to_aliens_task_received = 1
		Global.ui_manager.taskUI.update_task_display()
