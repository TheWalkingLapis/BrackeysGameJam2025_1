extends Control

@onready var start_button = $Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	# TODO change to 0 always
	var val = $SpinBox.value - 1
	Global.game_manager.current_day = val
	Global.game_manager.pre_start_day(val)
