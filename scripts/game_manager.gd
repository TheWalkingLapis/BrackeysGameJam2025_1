extends Control
class_name GameManager

@onready var room_manager: RoomManager = $RoomManager
@onready var time_manager: TimeManager = $TimeManager
@onready var ui_manager: UIManager = $UIManager
@onready var text_manager: TextManager = $TextManager

enum GameState {MAIN_MENU, PRE_DAY, IDLE, IN_TASK, POST_DAY, FAILED, SUCCESS}
var gameState: GameState = GameState.MAIN_MENU

var current_day = 0
var allow_interaction = true

func _ready():
	Global.game_manager = self
	Global.room_manager = room_manager
	Global.time_manager = time_manager
	Global.ui_manager = ui_manager
	Global.text_manager = text_manager
	
	time_manager.day_done.connect(_on_day_done)
	time_manager.break_time.connect(_on_break_time)
	time_manager.break_time_over.connect(_on_break_time_over)
	room_manager.task_started.connect(_on_task_in_progress)
	room_manager.task_ended.connect(_on_task_ended)
	text_manager.text_in_progress.connect(_on_text_in_progress)
	text_manager.finished_text.connect(_on_text_continue)
	
	time_manager.break_time_over.connect(room_manager._on_break_time_over)
	time_manager.evening.connect(room_manager._on_time_evening)
	
	ui_manager.to_main_menu()

func start_next_day():
	pre_start_day(current_day)

## Called before start_day to display news and mail w.o. waisting time
func pre_start_day(day):
	gameState = GameState.PRE_DAY
	ui_manager.to_pre_day()
	text_manager.display_news_and_mail(day)
	allow_interaction = true

func start_day(day):
	gameState = GameState.IDLE
	time_manager.start_day(day)
	room_manager.setup_day(day)
	ui_manager.to_day()

func _on_text_in_progress():
	allow_interaction = false

func _on_task_in_progress():
	allow_interaction = false
	gameState = GameState.IN_TASK

func _on_text_continue(force):
	if !force:
		match gameState:
			GameState.PRE_DAY:
				start_day(current_day)
			GameState.IDLE:
				print("Text done")
	if !time_manager.break_active:
		allow_interaction = true

func _on_task_ended():
	if !time_manager.break_active:
		allow_interaction = true
	gameState = GameState.IDLE

func _on_day_done():
	gameState = GameState.POST_DAY
	ui_manager.to_post_day()
	text_manager.clear_text()
	current_day += 1
	allow_interaction = false
	#pause_game(false, true) # always force pause

func _on_break_time():
	allow_interaction = false
	
func _on_break_time_over():
	allow_interaction = true

## calls get_tree().paused deferred
## @param toggle Whether the pause state is toggled
## @param pause Whether the game should be paused/unpaused (ignored if toggle = true)
func pause_game(toggle: bool = true, pause: bool = true):
	var val = !get_tree().paused if toggle else pause
	call_deferred("helper_pause_game", val)
func helper_pause_game(val: bool):
	get_tree().paused = val
