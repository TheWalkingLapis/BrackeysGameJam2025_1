extends Control
class_name AudioManager

enum SFX {TEST}
var sfx_dict = {}

@onready var music_player := $MusicPlayer
@onready var break_player := $BreakPlayer
@onready var alarm_player := $AlarmPlayer
@onready var sfx_player_1 := $SFX_Player
@onready var sfx_player_2 := $SFX_Player2

@export var music_track_chill: AudioStream

@export var sfx_test: AudioStream

# fill sfx dict
func _on_ready():
	sfx_dict = {
		SFX.TEST: sfx_test
	}

func play_music():
	if music_player.playing:
		return
	music_player.stream = music_track_chill
	music_player.play()

func stop_music():
	music_player.stop()

func play_break_sound():
	break_player.play()

func play_sfx(sfx: SFX):
	if sfx_player_1.playing:
		sfx_player_2.stream = sfx_dict[sfx]
		sfx_player_2.play()
	else:
		sfx_player_1.stream = sfx_dict[sfx]
		sfx_player_1.play()
