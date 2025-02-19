extends Room

@export var bg_texture_day: Texture2D
@export var bg_texture_evening: Texture2D
@export var bg_texture_night: Texture2D
@export var bg_texture_night_aliens: Texture2D

var sign_task = null
var tv_task = null
var order_task = null
var watering_task = null

# define this in a room for per-day (or break time) setup of tasks or visiblity
# (task visiblity itself is handled by the room manager)
func setup_day(day, post_break):
	$Background.texture = bg_texture_day
	match day:
		0:
			sign_task = $Tasks/Day1/Task_Document_Sign_Post if post_break else $Tasks/Day1/Task_Document_Sign_Pre
			tv_task = $Tasks/Day1/Task_watch_TV_post if post_break else $Tasks/Day1/Task_watch_TV_pre
			order_task = null
			watering_task = null
		1:
			sign_task = $Tasks/Day2/Task_Document_Sign_Post if post_break else $Tasks/Day2/Task_Document_Sign_Pre
			tv_task = $Tasks/Day2/Task_watch_TV_post if post_break else $Tasks/Day2/Task_watch_TV_pre
			order_task = null if post_break else $Tasks/Day2/Task_Order
			watering_task = null
		2:
			sign_task = $Tasks/Day3/Task_Document_Sign_Post if post_break else $Tasks/Day3/Task_Document_Sign_Pre
			tv_task = $Tasks/Day3/Task_watch_TV_post if post_break else $Tasks/Day3/Task_watch_TV_pre
			order_task = null if post_break else $Tasks/Day3/Task_Order
			watering_task = $Tasks/Day3/Task_water_Office_Plant
		3:
			sign_task = null
			tv_task = null
			order_task = null
			watering_task = null
		4:
			sign_task = null
			tv_task = null
			order_task = null
			watering_task = null
		5:
			sign_task = null
			tv_task = null
			order_task = null
			watering_task = null

func _on_pc_screen_pressed():
	if !Global.game_manager.allow_interaction: return
	if order_task != null:
		if (order_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already ordered the required supplies") #never happens
		else:
			order_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I don't need anything from my PC")

func _on_door_pressed():
	if !Global.game_manager.allow_interaction and !Global.time_manager.break_active: return
	Global.room_manager.change_room_to("Main_Hallway")

func _on_tv_pressed():
	if !Global.game_manager.allow_interaction: return
	if tv_task != null:
		if (tv_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I can't watch tv now") #never happens
		else:
			tv_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I don't have time to watch TV right now")

func _on_document_signing_pressed():
	if !Global.game_manager.allow_interaction: return
	if sign_task != null:
		if (sign_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already signed this")
		else:
			sign_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I don't need to sign anything right now")

func _on_couch_pressed():
	if !Global.game_manager.allow_interaction: return
	print("COUCH TODO")
	
func _on_time_evening():
	$Background.texture = bg_texture_evening

func _on_plant_pressed():
	if !Global.game_manager.allow_interaction: return
	if watering_task != null:
		if (watering_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already watered this plant")
		elif !Global.inventory.has_item(Global.inventory.Items.WATERING_CAN):
			Global.text_manager.display_interaction_text("I need the waternig can for this")
		else:
			watering_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I don't need to water the plant")
