extends Task

@onready var active = $Active

@export var opera_1: Texture2D
@export var opera_2: Texture2D
@export var opera_3: Texture2D

var idx = 0
var operas = []
var counter = 0
var swap_speed = 0.75

func start_task():
	operas = [opera_1, opera_2, opera_3]
	$Active/TV_BG.texture = operas[idx]
	counter = 0
	active.visible = true
	Global.time_manager.change_time_speed(20)
	started.emit(self)
	if Global.auto_hide_on_task:
		Global.ui_manager.taskUI.hide_taskbar()
	Global.audio_manager.play_loop_sfx(AudioManager.SFX.TASK_TV)

func reset_task():
	active.visible = false

func _process(delta):
	if !active.visible or len(operas) == 0:
		return
	counter += delta
	if counter > swap_speed:
		counter -= swap_speed
		idx = (idx + 1) % len(operas)
		$Active/TV_BG.texture = operas[idx]

func _on_leave_pressed():
	active.visible = false
	Global.audio_manager.stop_loop_sfx()
	quit.emit() # emits signal without making the tv unclickable, since the task in uncompletable
	Global.time_manager.change_time_speed(1)
