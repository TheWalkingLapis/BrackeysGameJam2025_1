extends Task

func start_task():
	if get_task_completed():
		return
	if !Global.inventory.has_item(Global.inventory.Items.COFFEE_CUP):
		return
	Global.inventory.drop()
	Global.coffee_cup_delivered = true
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
