extends Task

@onready var coffe_cup = $Coffee_Cup

func start_task():
	if get_task_completed():
		return
	var success = Global.inventory.pick_up(Global.inventory.Items.COFFEE_CUP)
	if !success:
		return
	coffe_cup.visible = false
	started.emit(self)
	set_task_completed()

func reset_task():
	super.reset_task()
	coffe_cup.visible = !Global.coffee_cup_delivered and Global.coffee_cup_ordered
