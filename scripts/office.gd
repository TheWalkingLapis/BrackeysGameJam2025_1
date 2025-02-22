extends Room

signal ordered()

@export var bg_texture_day: Texture2D
@export var bg_texture_evening: Texture2D
@export var bg_texture_night: Texture2D
@export var bg_texture_night_aliens: Texture2D

var sign_task = null
var tv_task = null
var order_task = null
var watering_task = null
var drop_coffee_task = null

# define this in a room for per-day (or break time) setup of tasks or visiblity
# (task visiblity itself is handled by the room manager)
func setup_day(day, post_break):
	$Background.texture = bg_texture_day if day < 5 else bg_texture_night_aliens
	#$Clickables/Coffee.visible = (day == 5)
	match day:
		0:
			sign_task = $Tasks/Day1/Task_Document_Sign_Post
			tv_task = $Tasks/Day1/Task_watch_TV_post if post_break else $Tasks/Day1/Task_watch_TV_pre
			order_task = null
			watering_task = null
			drop_coffee_task = null
		1:
			sign_task = $Tasks/Day2/Task_Document_Sign_Post
			tv_task = $Tasks/Day2/Task_watch_TV_post if post_break else $Tasks/Day2/Task_watch_TV_pre
			order_task = $Tasks/Day2/Task_Order
			watering_task = null
			drop_coffee_task = null
		2:
			sign_task = $Tasks/Day3/Task_Document_Sign_Post
			tv_task = $Tasks/Day3/Task_watch_TV_post if post_break else $Tasks/Day3/Task_watch_TV_pre
			order_task = $Tasks/Day3/Task_Order
			watering_task = $Tasks/Day3/Task_water_Office_Plant
			drop_coffee_task = null
			
		3:
			sign_task = $Tasks/Day4/Task_Document_Sign_Post
			tv_task = $Tasks/Day4/Task_watch_TV_post if post_break else $Tasks/Day4/Task_watch_TV_pre
			order_task = $Tasks/Day4/Task_Order
			watering_task = $Tasks/Day4/Task_water_Office_Plant
			drop_coffee_task = null
		4:
			sign_task = $Tasks/Day5/Task_Document_Sign_Post
			tv_task = $Tasks/Day5/Task_watch_TV_post if post_break else $Tasks/Day5/Task_watch_TV_pre
			order_task = $Tasks/Day5/Task_Order
			watering_task = $Tasks/Day5/Task_water_Office_Plant
			drop_coffee_task = null
		5:
			sign_task = null
			tv_task = null
			order_task = $Tasks/Day6/Task_Order
			watering_task = null
			drop_coffee_task = null

func _on_pc_screen_pressed():
	if !Global.game_manager.allow_interaction: return
	if Global.game_manager.current_day == 5 and Global.talked_to_aliens_task_received == 0:
		Global.text_manager.display_interaction_text("I don't need anything from my PC.")
		return
	if order_task != null:
		if (order_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already ordered the required supplies.") #never happens
		else:
			order_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I don't need anything from my PC.")

func _on_door_pressed():
	if !Global.game_manager.allow_interaction and (!Global.time_manager.break_active and Global.time_manager.day_active): return
	Global.room_manager.change_room_to("Main_Hallway")
	ordered.emit() # update storage room when leaving office (this fucking sucks but well what can I do)

func _on_tv_pressed():
	if !Global.game_manager.allow_interaction: return
	if tv_task != null:
		if (tv_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I can't watch tv now.") #never happens
		else:
			tv_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I don't have time to watch TV right now.")

func _on_document_signing_pressed():
	if !Global.game_manager.allow_interaction: return
	if sign_task != null:
		if (sign_task as Task).get_task_completed():
			Global.text_manager.display_interaction_text("I already signed this.")
		else:
			sign_task.start_task()
	else:
		Global.text_manager.display_interaction_text("I don't need to sign anything right now.")

func _on_couch_pressed():
	if Global.game_manager.current_day >= 3 and !Global.time_manager.day_active:
		Global.room_manager.post_day.emit()
		return
	if !Global.game_manager.allow_interaction: return
	Global.text_manager.display_interaction_text("This is my couch where I sometimes take a little nap while working. But I have no time to sleep now.")

func _on_time_daytime():
	$Background.texture = bg_texture_day

func _on_time_evening():
	$Background.texture = bg_texture_evening

func _on_time_night():
	$Background.texture = bg_texture_night

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


func _on_coffee_pressed():
	if drop_coffee_task != null and !(drop_coffee_task as Task).get_task_completed():
		if Global.inventory.has_item(Global.inventory.Items.COFFEE_CUP):
			drop_coffee_task.start_task()
			$Clickables/Coffee.visible = false
		else:
			Global.text_manager.display_interaction_text("I need the bring the coffee here.")
	else:
		Global.text_manager.display_interaction_text("I don't actually have time to drink this... :(")
