extends Control
class_name GameManager

@onready var room_manager: RoomManager = $RoomManager
@onready var time_manager: TimeManager = $TimeManager
@onready var ui_manager: UIManager = $UIManager

var current_day = 0

func _ready():
	Global.game_manager = self
	Global.room_manager = room_manager
	Global.time_manager = time_manager
	
	time_manager.start_day(current_day)
	time_manager.day_done.connect(_on_day_done)

func _process(delta):
	pass

func _on_day_done():
	current_day += 1
	pause_game(false, true) # always force pause

## calls get_tree().paused deferred
## @param toggle Whether the pause state is toggled
## @param pause Whether the game should be paused/unpaused (ignored if toggle = true)
func pause_game(toggle: bool = true, pause: bool = true):
	var val = !get_tree().paused if toggle else pause
	call_deferred("helper_pause_game", val)
func helper_pause_game(val: bool):
	get_tree().paused = val
