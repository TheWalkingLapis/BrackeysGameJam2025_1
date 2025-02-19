extends Control
class_name AudioManager

@onready var music_player := $MusicPlayer

@export var music_track_chill: AudioStream


func play_music():
	if music_player.playing:
		return
	music_player.stream = music_track_chill
	music_player.play()

func stop_music():
	music_player.stop()
