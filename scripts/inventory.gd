extends Control
class_name Inventory

@export var watering_can_tex: Texture2D
@export var cereal_bar_tex: Texture2D
@export var coffee_cup_tex: Texture2D
@export var uranium_tex: Texture2D
@export var hazmat_suit_tex: Texture2D
@export var bomb_kit_tex: Texture2D
@export var plutonium_tex: Texture2D
@onready var slot_rect: TextureRect = $Slot

enum Items {NONE, WATERING_CAN, HAZMAT_SUIT, URANIUM, COFFEE_CUP, CEREAL_BAR, PLUTONIUM, BOMB_KIT}
var tex_dict = {} # init in ready bc godot

var slot: Items = Items.NONE

func _ready():
	tex_dict = {
	Items.NONE: null,
	Items.WATERING_CAN: watering_can_tex,
	Items.CEREAL_BAR: cereal_bar_tex,
	Items.COFFEE_CUP: coffee_cup_tex,
	Items.URANIUM: uranium_tex,
	Items.HAZMAT_SUIT: hazmat_suit_tex,
	Items.BOMB_KIT: bomb_kit_tex,
	Items.PLUTONIUM: plutonium_tex
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
