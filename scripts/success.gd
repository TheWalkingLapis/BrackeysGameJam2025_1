extends ColorRect

@onready var bg = $BG

@export var meltdown_tex: Texture2D

func win():
	Global.time_manager.day_active = false
	Global.audio_manager.play_loop_sfx(AudioManager.SFX.ENDING_BEACH)
	Global.text_manager.show_text_in_menu("You did it! Thanks to you, earth was spared complete destruction. The aliens even healed everyone with their healing ray as they flew away, the pandemic is over. You are humanity's savior! Have a nice vacation on Gran Canaria with your wife!")

func _on_continue_pressed():
	Global.audio_manager.stop_loop_sfx()
	get_tree().reload_current_scene()
