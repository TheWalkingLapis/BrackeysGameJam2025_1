extends Task

@onready var active = $Active

func start_task():
	if get_task_completed():
		return
	active.visible = true
	started.emit()

func reset_task():
	super.reset_task()
	active.visible = false

func _on_leave_pressed():
	set_task_completed()
	active.visible = false
