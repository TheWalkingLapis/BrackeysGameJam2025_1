extends Control

@onready var clock = $Clock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock.text = Utils.bbc_text(Global.time_manager.get_formated_ingame_time(), 50)
