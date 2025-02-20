extends Task

@onready var cereal_bar = $Cereal_Bar

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.CEREAL_BAR)
	if !success:
		return
	cereal_bar.visible = false
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	cereal_bar.visible = Global.cereal_bar_ordered
