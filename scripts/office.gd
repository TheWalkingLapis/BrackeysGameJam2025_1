extends Room

@export var bg_texture_day: Texture2D
@export var bg_texture_evening: Texture2D
@export var bg_texture_night: Texture2D
@export var bg_texture_night_aliens: Texture2D

var sign_task = null

# define this in a room for per-day (or break time) setup of tasks or visiblity
# (task visiblity itself is handled by the room manager)
func setup_day(day, post_break):
	match day:
		0:
			sign_task = $Tasks/Day1/Task_Document_Sign_Post if post_break else $Tasks/Day1/Task_Document_Sign_Pre
		1:
			pass
		2:
			pass
		3:
			pass
		4:
			pass
		5:
			pass

func _on_pc_screen_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.text_manager.display_interaction_text("What a nice screen UwU")
	Global.time_manager.change_time_speed(5.0)


func _on_door_pressed():
	if !Global.game_manager.allow_interaction and !Global.time_manager.break_active: return
	Global.room_manager.change_room_to("Main_Hallway")


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
