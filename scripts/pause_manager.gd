extends Control

@onready var auto_hide_status = $ColorRect/auto_hide/auto_hide_status
@onready var music_txt = $Music/music_txt
@onready var sound_txt = $Sound/sound_txt
@onready var music_slider = $Music/music_slider
@onready var sound_slider = $Sound/sound_slider

func set_auto_hide(val):
	Global.auto_hide_on_task = val
	if val:
		auto_hide_status.text = "[center][color=#ffffffff]ON"
	else:
		auto_hide_status.text = "[center][color=#505050ff]OFF"

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_slider.value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), linear_to_db(sound_slider.value))
	set_auto_hide(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.game_manager.gameState != GameManager.GameState.MAIN_MENU:
		if Input.is_action_just_pressed("pause"):
			get_tree().paused = !get_tree().paused
			visible = get_tree().paused
			#Global.game_manager.current_day += 1
			#Global.game_manager.pre_start_day(Global.game_manager.current_day)


func _on_auto_hide_pressed():
	set_auto_hide(!Global.auto_hide_on_task)


func _on_unpause_pressed():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused


func _on_music_slider_value_changed(value):
	if value == music_slider.min_value: value = 0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sound_slider_value_changed(value):
	if value == sound_slider.min_value: value = 0
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), linear_to_db(value))
