extends Control
class_name UIManager

@onready var mainMenu = $MainMenu
@onready var debugUI = $DebugUI
@onready var preDayBG = $PreDayBG

func to_main_menu():
	disable_all()
	mainMenu.visible = true

func to_pre_day():
	disable_all()
	preDayBG.visible = true
	
func to_day():
	disable_all()
	print("TODO")

func to_post_day():
	disable_all()
	print("TODO")

func disable_all():
	mainMenu.visible = false
	preDayBG.visible = false
	#debugUI.visible = false
