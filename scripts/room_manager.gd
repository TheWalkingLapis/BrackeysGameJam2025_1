extends Control
class_name RoomManager

@onready var office: Control = $Office
@onready var office2: Control = $Office2
var current_room = "Office2"

var name_to_node_dict: Dictionary

func _ready():
	name_to_node_dict = {
		"Office": office,
		"Office2": office2
	}
	for room_name in name_to_node_dict:
		name_to_node_dict[room_name].visible = (current_room == room_name)

func change_room_to(room_name: String):
	name_to_node_dict[current_room].visible = false
	if not room_name in name_to_node_dict:
		printerr("Room name doesn't exist: %s" % [room_name])
		return
	current_room = room_name
	name_to_node_dict[current_room].visible = true

func _process(delta):
	pass
