extends Control
class_name TimeManager

signal break_time()
signal break_time_over()
signal day_done()
signal daytime()
signal evening()
signal night()

const ingame_hour_in_seconds: float = 15.0
const night_morning_hour: int = 4
const daytime_hour: int = 6
const evening_hour: int = 16
const night_late_hour: int = 20

var day_start_hour: int = 0
var day_end_hour: int = 0
var day_break_hour: int = 0
var post_break: bool = false
var day_break_duration: int = 0
var day_time = "day"

var current_ingame_time: float = 0.0
var current_ingame_hour: int = 0
var current_real_time: float = 0.0
var time_fac: float = 1.0

var day_active = false
var break_active = false

# used only for the not break case (since break time is not emited)
var _12h_flag = false

@export var ingame_day_times: Array[DayDurationTimes]

func _ready():
	pass

func start_day(day: int):
	day_start_hour = ingame_day_times[day].start_hour
	day_end_hour = ingame_day_times[day].end_hour
	day_break_hour = ingame_day_times[day].break_hour
	day_break_duration = ingame_day_times[day].break_duration
	current_ingame_time = day_start_hour
	current_ingame_hour = floor(current_ingame_time)
	current_real_time = 0.0
	time_fac = 1.0
	_12h_flag = false
	day_active = true
	break_active = false
	post_break = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !day_active or break_active: 
		return
	if Global.game_manager.current_day == 5 and !Global.talked_to_aliens_task_received:
		return
	var prev_hour = floor(current_ingame_time)
	current_real_time += delta * time_fac
	current_ingame_time = day_start_hour + (current_real_time / ingame_hour_in_seconds)
	current_ingame_hour = floor(current_ingame_time)
	if !post_break and current_ingame_hour == day_break_hour:
		current_ingame_time = day_break_hour
		current_real_time = (current_ingame_time - day_start_hour) * ingame_hour_in_seconds
		break_active = true
		time_fac = 1.0
		break_time.emit()
	if Global.game_manager.current_day == 4 and current_ingame_hour == 12 and !_12h_flag:
		_12h_flag = true
		Global.audio_manager.play_break_sound()
		Global.text_manager.show_text_in_menu("I don't think I have time for a break today")
	if current_ingame_hour == night_morning_hour and day_time != "night":
		night.emit()
		day_time = "night"
	if current_ingame_hour == daytime_hour and day_time != "day":
		daytime.emit()
		day_time = "day"
	if current_ingame_hour == evening_hour and day_time != "evening":
		evening.emit()
		day_time = "evening"
	if current_ingame_hour == night_late_hour and day_time != "night":
		night.emit()
		day_time = "night"
	if current_ingame_hour == day_end_hour:
		current_ingame_time = day_end_hour
		current_real_time = (current_ingame_time - day_start_hour) * ingame_hour_in_seconds
		day_active = false
		day_done.emit()

func resume_after_break():
	current_ingame_time = day_break_hour + day_break_duration
	current_real_time = (current_ingame_time - day_start_hour) * ingame_hour_in_seconds
	break_active = false
	post_break = true
	break_time_over.emit()

func get_formated_ingame_time():
	var hours = current_ingame_hour
	var minutes = floor(60 * (current_ingame_time - current_ingame_hour))
	return "%02d:%02d" % [hours, minutes]

func get_working_hours():
	return [day_start_hour, day_end_hour]

func change_time_speed(new_fac: float):
	time_fac = new_fac
