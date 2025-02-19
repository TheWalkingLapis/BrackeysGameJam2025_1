extends Control
class_name UIManager

@onready var mainMenu = $MainMenu
@onready var debugUI = $DebugUI
@onready var preDayUI = $PreDayUI
@onready var taskUI = $TaskUI
@onready var postDayUI = $PostDayUI

func to_main_menu():
	disable_all()
	mainMenu.visible = true

func to_pre_day(day):
	disable_all()
	preDayUI.day(day)
	preDayUI.visible = true
	
func to_day():
	disable_all()
	taskUI.visible = true

func to_post_day():
	disable_all()
	postDayUI.visible = true

func setup_tasks(tasks):
	taskUI.set_tasks(tasks)

func update_tasks():
	taskUI.update_task_display()

func disable_all():
	mainMenu.visible = false
	preDayUI.visible = false
	taskUI.visible = false
	postDayUI.visible = false
	#debugUI.visible = false
