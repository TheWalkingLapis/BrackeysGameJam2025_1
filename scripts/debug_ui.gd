extends Control

@onready var clock = $Clock
@onready var gameState = $GameState

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clock.text = Utils.bbc_text(Global.time_manager.get_formated_ingame_time(), 30)
	var state = Global.game_manager.gameState
	var string = "null"
	match state:
		GameManager.GameState.MAIN_MENU:
			string = "MAIN_MENU"
		GameManager.GameState.PRE_DAY:
			string = "PRE_DAY" 
		GameManager.GameState.IDLE:
			string = "IDLE" 
		GameManager.GameState.IN_TASK:
			string = "IN_TASK" 
		GameManager.GameState.POST_DAY:
			string = "POST_DAY" 
		GameManager.GameState.FAILED:
			string = "FAILED" 
		GameManager.GameState.SUCCESS:
			string = "SUCCESS" 
	gameState.text = Utils.bbc_text(string, 30)
	
