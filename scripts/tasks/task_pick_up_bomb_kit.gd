extends Task

@onready var bomb_kit = $bomb_kit

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.BOMB_KIT)
	if !success:
		return
	bomb_kit.visible = false
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	bomb_kit.visible = Global.bomb_delivered
