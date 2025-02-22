extends Task

const color_dict = {
	1: Color(1,0,0,0.5),
	2: Color(0,1,0,0.5),
	3: Color(0,0,1,0.5)
}

@export var target_matching: Array[int] = [1, 2, 3]

@onready var active = $Active

@onready var outlet_1 = $Active/Outlet1
@onready var outlet_2 = $Active/Outlet2
@onready var outlet_3 = $Active/Outlet3
@onready var wire_1 = $Active/Wire1
@onready var wire_2 = $Active/Wire2
@onready var wire_3 = $Active/Wire3
@onready var target_1 = $Active/Target1
@onready var target_2 = $Active/Target2
@onready var target_3 = $Active/Target3

var connected_1 = false
var connected_2 = false
var connected_3 = false

var tracking_mode = false
var tracking_index = 0

func start_task():
	if get_task_completed():
		return
	reset_task()
	active.visible = true
	outlet_1.self_modulate = color_dict[1]
	outlet_2.self_modulate = color_dict[2]
	outlet_3.self_modulate = color_dict[3]
	target_1.self_modulate = color_dict[target_matching[0]]
	target_2.self_modulate = color_dict[target_matching[1]]
	target_3.self_modulate = color_dict[target_matching[2]]
	started.emit(self)
	if Global.auto_hide_on_task:
		Global.ui_manager.taskUI.hide_taskbar()

func reset_task():
	super.reset_task()
	active.visible = false
	tracking_mode = false
	tracking_index = 0
	wire_1.clear_points()
	wire_2.clear_points()
	wire_3.clear_points()
	connected_1 = false
	connected_2 = false
	connected_3 = false

func _on_outlet_1_pressed():
	if tracking_mode or connected_1:
		return
	tracking_mode = true
	tracking_index = 1

func _on_outlet_2_pressed():
	if tracking_mode or connected_2:
		return
	tracking_mode = true
	tracking_index = 2

func _on_outlet_3_pressed():
	if tracking_mode or connected_3:
		return
	tracking_mode = true
	tracking_index = 3

func _on_target_1_pressed():
	if !tracking_mode:
		return
	var idx = target_matching[0]
	if tracking_index != idx:
		return
	tracking_mode = false
	var wire = (wire_1 if tracking_index == 1 else (wire_2 if tracking_index == 2 else wire_3)) as Line2D
	wire.set_point_position(1, target_1.position + target_1.size * 0.5)
	if tracking_index == 1: connected_1 = true
	if tracking_index == 2: connected_2 = true
	if tracking_index == 3: connected_3 = true
	tracking_index = 0
	if connected_1 and connected_2 and connected_3:
		leave()

func _on_target_2_pressed():
	if !tracking_mode:
		return
	var idx = target_matching[1]
	if tracking_index != idx:
		return
	tracking_mode = false
	var wire = (wire_1 if tracking_index == 1 else (wire_2 if tracking_index == 2 else wire_3)) as Line2D
	wire.set_point_position(1, target_2.position + target_2.size * 0.5)
	if tracking_index == 1: connected_1 = true
	if tracking_index == 2: connected_2 = true
	if tracking_index == 3: connected_3 = true
	tracking_index = 0
	if connected_1 and connected_2 and connected_3:
		leave()

func _on_target_3_pressed():
	if !tracking_mode:
		return
	var idx = target_matching[2]
	if tracking_index != idx:
		return
	tracking_mode = false
	var wire = (wire_1 if tracking_index == 1 else (wire_2 if tracking_index == 2 else wire_3)) as Line2D
	wire.set_point_position(1, target_3.position + target_3.size * 0.5)
	if tracking_index == 1: connected_1 = true
	if tracking_index == 2: connected_2 = true
	if tracking_index == 3: connected_3 = true
	tracking_index = 0
	if connected_1 and connected_2 and connected_3:
		leave()

func _process(delta):
	if !tracking_mode or !self.visible:
		return
	var wire = (wire_1 if tracking_index == 1 else (wire_2 if tracking_index == 2 else wire_3)) as Line2D
	wire.clear_points()
	var tracking_point = Vector2(0,0)
	match tracking_index:
		1:
			tracking_point = outlet_1.position + outlet_1.size * 0.5
		2:
			tracking_point = outlet_2.position + outlet_2.size * 0.5
		3:
			tracking_point = outlet_3.position + outlet_3.size * 0.5
	wire.add_point(tracking_point)
	wire.add_point(get_global_mouse_position())

func leave():
	active.visible = false
	set_task_completed()


func _on_leave_pressed():
	active.visible = false
	quit.emit()
