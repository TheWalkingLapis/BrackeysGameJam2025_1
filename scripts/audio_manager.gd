extends Control
class_name AudioManager

enum SFX {ENDING_MELTDOWN, ENDING_PLANET, ENDING_BEACH, RESTAURANT, TASK_TV, DAY_END, DOOR_LOCKED, DOOR_OPEN, EAT, TASK_SUCCESS, TASK_WATER, TASK_SIGN, TASK_WIRE, CLICK}
var sfx_dict = {}

@onready var music_player := $MusicPlayer
@onready var break_player := $BreakPlayer
@onready var alarm_player := $AlarmPlayer
@onready var sfx_player_1 := $SFX_Player
@onready var sfx_player_2 := $SFX_Player2
@onready var sfx_player_3 := $SFX_Player3
@onready var sfx_loop_player := $SFX_Loop_Player

@export var music_track_chill: AudioStream
@export var break_sound: AudioStream
@export var alarm_sound: AudioStream

@export var sfx_ending_beach: AudioStream
@export var sfx_ending_meltdown: AudioStream
@export var sfx_ending_planet_boom: AudioStream

@export var sfx_day_end: AudioStream
@export var sfx_door_locked: AudioStream
@export var sfx_door_open: AudioStream
@export var sfx_eat_snack: AudioStream
@export var sfx_restaurant: AudioStream
@export var sfx_task_success: AudioStream

@export var sfx_task_tv: AudioStream
@export var sfx_task_water: AudioStream
@export var sfx_task_sign: AudioStream
@export var sfx_task_electric: AudioStream
@export var sfx_click: AudioStream

# fill sfx dict
func _ready():
	sfx_dict = {
		SFX.ENDING_MELTDOWN: sfx_ending_meltdown,
		SFX.ENDING_PLANET: sfx_ending_planet_boom, 
		SFX.DAY_END: sfx_day_end, 
		SFX.DOOR_LOCKED: sfx_door_locked, 
		SFX.DOOR_OPEN: sfx_door_open, 
		SFX.EAT: sfx_eat_snack, 
		SFX.TASK_SUCCESS: sfx_task_success, 
		SFX.TASK_WATER: sfx_task_water, 
		SFX.TASK_SIGN: sfx_task_sign, 
		SFX.TASK_WIRE: sfx_task_electric,
		SFX.ENDING_BEACH: sfx_ending_beach,
		SFX.RESTAURANT: sfx_restaurant, 
		SFX.TASK_TV: sfx_task_tv,
		SFX.CLICK: sfx_click
	}
	break_player.stream = break_sound
	alarm_player.stream = alarm_sound
	music_player.stream = music_track_chill

func play_music():
	if music_player.playing:
		return
	music_player.stream = music_track_chill
	music_player.play()

func stop_music():
	music_player.stop()

func play_break_sound():
	break_player.play()

func play_alarm_sound():
	alarm_player.play()
func stop_alarm_sound():
	alarm_player.stop()

func play_sfx(sfx: SFX):
	if sfx_player_1.playing:
		if sfx_player_2.playing:
			sfx_player_3.stream = sfx_dict[sfx]
			sfx_player_3.play()
		else:
			sfx_player_2.stream = sfx_dict[sfx]
			sfx_player_2.play()
	else:
		sfx_player_1.stream = sfx_dict[sfx]
		sfx_player_1.play()
		
func play_loop_sfx(sfx: SFX):
	sfx_loop_player.stream = sfx_dict[sfx]
	sfx_loop_player.play()

func stop_loop_sfx():
	sfx_loop_player.stop()

func stop_all():
	music_player.stop()
	break_player.stop()
	alarm_player.stop()
	sfx_player_1.stop()
	sfx_player_2.stop()
	sfx_player_3.stop()
	sfx_loop_player.stop()
