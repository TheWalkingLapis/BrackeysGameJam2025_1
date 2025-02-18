extends Room

@export var bg_texture_day: Texture2D
@export var bg_texture_evening: Texture2D
@export var bg_texture_night: Texture2D
@export var bg_texture_night_aliens: Texture2D


func _on_pc_screen_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.text_manager.display_interaction_text("What a nice screen UwU")
	Global.time_manager.change_time_speed(5.0)


func _on_door_pressed():
	if !Global.game_manager.allow_interaction: return
	Global.room_manager.change_room_to("Main_Hallway")


func _on_document_signing_pressed():
	if !Global.game_manager.allow_interaction: return
	#TODO
