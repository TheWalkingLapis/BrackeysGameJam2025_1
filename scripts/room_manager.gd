extends Control
class_name RoomManager

@onready var office: Control = $Office
var current_room = "Office"

var name_to_node_dict: Dictionary

func _ready():
	name_to_node_dict = {
		"Office": office
	}
	for room_name in name_to_node_dict:
		name_to_node_dict[room_name].visible = (current_room == room_name)

func setup_day(day):
	var tasks = {}
	for room_name in name_to_node_dict:
		var room_tasks = name_to_node_dict[room_name].get_tasks_for_day(day)
		tasks[room_name] = room_tasks
	Global.ui_manager.setup_tasks(tasks)

func change_room_to(room_name: String):
	name_to_node_dict[current_room].visible = false
	if not room_name in name_to_node_dict:
		printerr("Room name doesn't exist: %s" % [room_name])
		return
	current_room = room_name
	name_to_node_dict[current_room].visible = true

func _process(delta):
	pass
