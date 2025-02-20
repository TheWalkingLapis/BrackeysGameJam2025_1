extends Node

var game_manager: GameManager = null
var room_manager: RoomManager = null
var time_manager: TimeManager = null
var ui_manager: UIManager = null
var text_manager: TextManager = null
var inventory: Inventory = null
var audio_manager: AudioManager = null

# TASKS
var watering_task_allow_discard_watering_can = 0

var cereal_bar_ordered = false
var coffee_cup_ordered = false
var uranium_ordered = false
var hazmat_suit_ordered = false
var bomb_ordered = false
var plutonium_ordered = false

var plutonium_code = [1,2,3,4]
