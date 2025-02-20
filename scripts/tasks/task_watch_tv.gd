extends Task

@onready var active = $Active

func start_task():
	active.visible = true
	Global.time_manager.change_time_speed(20)
	started.emit(self)

func _on_leave_pressed():
	active.visible = false
	set_task_completed() # emits signal without making the tv unclickable, since the task in uncompletable
	Global.time_manager.change_time_speed(1)
