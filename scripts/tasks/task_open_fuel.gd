extends Task

@onready var active = $Active
@onready var button = $Active/Button

func start_task():
	if Global.fuel_task_progress != 0: return
	active.visible = true
	started.emit(self)
	if Global.auto_hide_on_task:
		Global.ui_manager.taskUI.hide_taskbar()

func reset_task():
	super.reset_task()
	active.visible = false

func _on_button_pressed():
	active.visible = false
	Global.fuel_task_progress = 1
	set_task_completed()

func _on_leave_pressed():
	active.visible = false
	quit.emit()
