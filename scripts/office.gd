extends Control

#@onready var PCScreenButton = $Clickables/PCScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pc_screen_pressed():
	Global.time_manager.change_time_speed(2.0)
