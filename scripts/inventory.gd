extends Control
class_name Inventory

@export var watering_can_tex: Texture2D
@onready var slot_rect: TextureRect = $Slot

enum Items {NONE, WATERING_CAN}
var tex_dict = {} # init in ready bc godot

var slot: Items = Items.NONE

func _ready():
	tex_dict = {
	Items.NONE: null,
	Items.WATERING_CAN: watering_can_tex
}

func pick_up(item: Items) -> bool:
	if slot != Items.NONE and item != Items.NONE:
		Global.text_manager.display_interaction_text("I can't pick that up, I already have something in my hand")
		return false
	slot = item
	slot_rect.texture = tex_dict[item]
	slot_rect.visible = slot != Items.NONE
	return true

func drop():
	pick_up(Items.NONE)
	
func is_empty():
	return slot == Items.NONE

func has_item(item: Items):
	return slot == item
