extends Task

func start_task():
	if Global.fuel_task_progress != 1: return
	started.emit(self)
	Global.fuel_task_progress = 2
	set_task_completed()
	
