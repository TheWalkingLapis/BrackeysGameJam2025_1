extends Control
class_name UIManager

@onready var mainMenu = $MainMenu
@onready var debugUI = $DebugUI
@onready var preDayBG = $PreDayBG
@onready var taskUI = $TaskUI
@onready var postDayBG = $PostDayBG

func to_main_menu():
	disable_all()
	mainMenu.visible = true

func to_pre_day():
	disable_all()
	preDayBG.visible = true
	
func to_day():
	disable_all()
	taskUI.visible = true
	print("TODO")

func to_post_day():
	disable_all()
	postDayBG.visible = true

func disable_all():
	mainMenu.visible = false
	preDayBG.visible = false
	taskUI.visible = false
	postDayBG.visible = false
	#debugUI.visible = false
