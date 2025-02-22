extends Task

@onready var active = $Active

@onready var signed = $Active/signed
@onready var sign_button = $Active/unsigned/sign_button
@onready var unsigned = $Active/unsigned

func reset_task():
	super.reset_task()
	active.visible = false

func start_task():
	if get_task_completed():
		return
	started.emit(self)
	active.visible = true
	unsigned.visible = true
	signed.visible = false
	if Global.auto_hide_on_task:
		Global.ui_manager.taskUI.hide_taskbar()

func _on_sign_button_pressed():
	unsigned.visible = false
	signed.visible = true
	Global.audio_manager.play_sfx(AudioManager.SFX.TASK_SIGN)

func _on_signed_pressed():
	signed.visible = false
	set_task_completed()
