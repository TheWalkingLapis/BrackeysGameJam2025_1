extends Task

@onready var active = $Active

var checkpoints = 0

func start_task():
	active.visible = true
	Input.warp_mouse($Active/MouseStartPos.position)
	$Active/Checkpoint.visible = true
	$Active/Checkpoint2.visible = true
	checkpoints = 0
	started.emit(self)

func reset_task():
	super.reset_task()
	active.visible = false


func _on_walls_mouse_entered():
	Input.warp_mouse($Active/MouseStartPos.position)
	$Active/Checkpoint.visible = true
	$Active/Checkpoint2.visible = true
	checkpoints = 0

func _on_checkpoint_mouse_entered():
	checkpoints += 1
	$Active/Checkpoint.visible = false

func _on_checkpoint_2_mouse_entered():
	checkpoints += 1
	$Active/Checkpoint2.visible = false


func _on_continue_pressed():
	if checkpoints < 2:
		print("cheat detection")
		_on_walls_mouse_entered()
		return
	active.visible = false
	set_task_completed()

func _on_leave_pressed():
	active.visible = false
	quit.emit()
