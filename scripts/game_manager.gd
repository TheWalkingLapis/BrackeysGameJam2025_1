extends Control
class_name GameManager

@onready var room_manager: RoomManager = $RoomManager
@onready var time_manager: TimeManager = $TimeManager
@onready var ui_manager: UIManager = $UIManager
@onready var text_manager: TextManager = $TextManager

enum GameState {MAIN_MENU, PAUSE_MENU, PRE_DAY, IDLE, IN_TASK, POST_DAY, FAILED, SUCESS}
var gameState: GameState = GameState.MAIN_MENU

var current_day = 0

func _ready():
	Global.game_manager = self
	Global.room_manager = room_manager
	Global.time_manager = time_manager
	Global.ui_manager = ui_manager
	Global.text_manager = text_manager
	
	time_manager.day_done.connect(_on_day_done)
	text_manager.finished_text.connect(_on_text_continue)
	
	ui_manager.to_main_menu()

func _process(delta):
	pass

## Called before start_day to display news and mail w.o. waisting time
func pre_start_day(day):
	gameState = GameState.PRE_DAY
	ui_manager.to_pre_day()
	text_manager.display_news_and_mail(day)

func start_day(day):
	gameState = GameState.IDLE
	room_manager.setup_day(day)
	ui_manager.to_day()
	time_manager.start_day(day)

func _on_text_continue():
	match gameState:
		GameState.PRE_DAY:
			start_day(current_day)

func _on_day_done():
	gameState = GameState.POST_DAY
	ui_manager.to_post_day()
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
