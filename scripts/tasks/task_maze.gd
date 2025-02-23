extends Task

@onready var active = $Active
@onready var maze = $Active/Maze
@onready var start = $Active/Start

@onready var cp1 = $Active/Maze/Checkpoint
@onready var cp2 = $Active/Maze/Checkpoint2

signal done()

var checkpoints = 0

func start_task():
	active.visible = true
	start.visible = true
	maze.visible = false
	cp1.visible = true
	cp2.visible = true
	checkpoints = 0
	started.emit(self)
	if Global.auto_hide_on_task:
		Global.ui_manager.taskUI.hide_taskbar()

func reset_task():
	super.reset_task()
	active.visible = false


func _on_walls_mouse_entered():
	start.visible = true
	maze.visible = false
	cp1.visible = true
	cp2.visible = true
	checkpoints = 0

func _on_checkpoint_mouse_entered():
	checkpoints += 1
	cp1.visible = false

func _on_checkpoint_2_mouse_entered():
	checkpoints += 1
	cp2.visible = false


func _on_continue_pressed():
	if checkpoints < 2:
		print("cheat detection (you skipped the checkpoint zones)")
		_on_walls_mouse_entered()
		return
	active.visible = false
	set_task_completed()
	done.emit()

func _on_leave_pressed():
	active.visible = false
	quit.emit()

func _on_start_pressed():
	start.visible = false
	maze.visible = true
