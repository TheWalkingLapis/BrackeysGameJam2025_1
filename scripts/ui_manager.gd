extends Control
class_name UIManager

@onready var debug_clock = $Debuger/Clock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	debug_clock.text = bbc_text(Global.time_manager.get_formated_ingame_time(), 50)


func bbc_text(txt, font_size=20):
	return "[font_size=%d]%s[/font_size]" % [font_size, txt]
