extends Control
class_name RoomManager

@onready var office: Control = $Office
var current_room = "Office"

var name_to_node_dict: Dictionary

func _ready():
	name_to_node_dict = {
		"Office": office
	}


func _process(delta):
	pass
