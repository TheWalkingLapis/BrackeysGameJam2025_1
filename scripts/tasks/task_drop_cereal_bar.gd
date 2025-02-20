extends Task

func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.CEREAL_BAR):
		return
	Global.inventory.drop()
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
