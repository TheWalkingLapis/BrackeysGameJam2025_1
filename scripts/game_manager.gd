extends Control
class_name GameManager

@onready var room_manager: RoomManager = $RoomManager
@onready var time_manager: TimeManager = $TimeManager
@onready var ui_manager: UIManager = $UIManager
@onready var text_manager: TextManager = $TextManager
@onready var inventory: Inventory = $Inventory
@onready var audio_manager: AudioManager = $AudioManager

enum GameState {MAIN_MENU, PRE_DAY, IDLE, IN_TASK, POST_DAY, FAILED, SUCCESS}
var gameState: GameState = GameState.MAIN_MENU

var current_day: int = 4
var allow_interaction = true

func _ready():
	Global.game_manager = self
	Global.room_manager = room_manager
	Global.time_manager = time_manager
	Global.ui_manager = ui_manager
	Global.text_manager = text_manager
	Global.inventory = inventory
	Global.audio_manager = audio_manager
	
	time_manager.day_done.connect(_on_day_done)
	time_manager.break_time.connect(_on_break_time)
	time_manager.break_time_over.connect(_on_break_time_over)
	room_manager.task_started.connect(_on_task_in_progress)
	room_manager.task_ended.connect(_on_task_ended)
	room_manager.post_day.connect(_on_post_day)
	text_manager.text_in_progress.connect(_on_text_in_progress)
	text_manager.finished_text.connect(_on_text_continue)
	room_manager.control.meltdown.connect(_on_meltdown)
	room_manager.control.start_alarm.connect(_on_start_meltdown_alarm)
	room_manager.control.stop_alarm.connect(_on_stop_meltdown_alarm)
	
	time_manager.break_time_over.connect(room_manager._on_break_time_over)
	time_manager.evening.connect(room_manager._on_time_evening)
	time_manager.daytime.connect(room_manager._on_time_daytime)
	time_manager.night.connect(room_manager._on_time_night)
	
	ui_manager.to_main_menu()

func start_next_day():
	pre_start_day(current_day)

## Called before start_day to display news and mail w.o. waisting time
func pre_start_day(day):
	gameState = GameState.PRE_DAY
	inventory.drop()
	ui_manager.to_pre_day(day)
	allow_interaction = true

func start_day():
	var day = current_day
	gameState = GameState.IDLE
	time_manager.start_day(day)
	room_manager.setup_day(day)
	ui_manager.to_day()
	audio_manager.play_music()
	if day == 5:
		text_manager.display_interaction_text("\"Hello earthling, we're communicating through telepathy, we are inside your mind. I order you to come to the kitchen to receive our demands!\"")
	
func _on_text_in_progress():
	allow_interaction = false

func _on_task_in_progress():
	allow_interaction = false
	gameState = GameState.IN_TASK

func _on_text_continue(force):
	if !time_manager.break_active and time_manager.day_active:
		allow_interaction = true

func _on_task_ended():
	if !time_manager.break_active and time_manager.day_active:
		allow_interaction = true
	gameState = GameState.IDLE

func _on_day_done():
	text_manager.clear_text()
	room_manager.clear_active_tasks()
	if !room_manager.get_tasks_completed(true):
		audio_manager.stop_music()
		ui_manager.to_failure()
		return
	if current_day < 3:
		text_manager.display_interaction_text("Time to go home to my wife!")
	else:
		text_manager.display_interaction_text("Time to sleep, I guess I'll stay in my office.")
	allow_interaction = false

func _on_post_day():
	gameState = GameState.POST_DAY
	ui_manager.to_post_day()
	text_manager.clear_text()
	audio_manager.stop_music()
	current_day += 1
	allow_interaction = false

func _on_meltdown():
	text_manager.clear_text()
	room_manager.clear_active_tasks()
	audio_manager.stop_music()
	audio_manager.stop_alarm_sound()
	ui_manager.to_failure()
	return

func _on_start_meltdown_alarm():
	text_manager.clear_text()
	text_manager.show_text_in_menu("!!! Imminnent Reactor Meltdown, hurry to the control room !!!")
	audio_manager.play_alarm_sound()
	ui_manager.taskUI.show_alarm()

func _on_stop_meltdown_alarm():
	audio_manager.stop_alarm_sound()
	ui_manager.taskUI.hide_alarm()

func _on_break_time():
	allow_interaction = false
	ui_manager.taskUI._on_break_time()
	audio_manager.play_break_sound()
	text_manager.clear_text()
	room_manager.clear_active_tasks()
	if !room_manager.get_tasks_completed(false):
		audio_manager.stop_music()
		ui_manager.to_failure()
		return
	text_manager.display_interaction_text("Time to take my break")
	
func _on_break_time_over():
	allow_interaction = true

func _on_final_task_complete():
	audio_manager.stop_music()
	ui_manager.to_success()

## calls get_tree().paused deferred
## @param toggle Whether the pause state is toggled
## @param pause Whether the game should be paused/unpaused (ignored if toggle = true)
func pause_game(toggle: bool = true, pause: bool = true):
	var val = !get_tree().paused if toggle else pause
	call_deferred("helper_pause_game", val)
func helper_pause_game(val: bool):
	get_tree().paused = val
