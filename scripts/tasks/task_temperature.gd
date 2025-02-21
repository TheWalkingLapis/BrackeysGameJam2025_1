extends Task

signal decrease_temperature

@onready var active = $Active
@onready var temp = $Active/ProgressBar

func _process(delta):
	if active.visible and self.visible:
		temp.value = Global.room_manager.control.temperature

func start_task():
	active.visible = true
	started.emit(self)

func reset_task():
	super.reset_task()
	active.visible = false

func _on_button_pressed():
	decrease_temperature.emit()


func _on_leave_pressed():
	active.visible = false
	set_task_completed()
