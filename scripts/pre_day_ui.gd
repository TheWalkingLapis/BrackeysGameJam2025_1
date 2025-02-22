extends Control

@export var newspapers_aliens: Texture2D
@export var newspapers_pandemic: Texture2D

@onready var mail: Control = $Mail
@onready var mail_txt: RichTextLabel = $Mail/Text
@onready var news: TextureRect = $News

@onready var monologue = $Monologue

@onready var news_continue_button: Button = $News_to_Mail
@onready var mail_continue_button: Button = $Start_day

var has_news = false

var mail_1 = ""
var mail_2 = ""
var mail_3 = ""
var mail_4 = ""
var mail_5 = ""
var mail_6 = ""

var mono_1 = "AMOGUS AMOGUS AMOUGS"
var mono_2 = ""
var mono_3 = ""
var mono_4 = ""
var mono_5 = ""
var mono_6 = "AMOGUS AMOGUS"

var signal_connected = false
	
func day(day):
	if !signal_connected:
		Global.text_manager.finished_menu_text.connect(_on_monologue_done)
		signal_connected = true

	if day == 3:
		news.texture = newspapers_pandemic
		has_news = true
	elif day == 4:
		news.texture = newspapers_aliens
		has_news = true
	else:
		has_news = false
	news.visible = has_news
	news_continue_button.visible = has_news
	mail.visible = !has_news
	mail_continue_button.visible = !has_news
	monologue.visible = true
	var mono_txt = "AMOGUS AMOGUS"
	match day:
		0:
			mono_txt = mono_1
			mail_txt.text = mail_1
		1:
			mono_txt = mono_2
			mail_txt.text = mail_2
		2:
			mono_txt = mono_3
			mail_txt.text = mail_3
		3:
			mono_txt = mono_4
			mail_txt.text = mail_5
		4:
			mono_txt = mono_5
			mail_txt.text = mail_5
		5:
			mono_txt = mono_6
			mail_txt.text = mail_6
	Global.text_manager.show_text_in_menu(mono_txt, Color(1,1,1,0.2))

func _on_monologue_done():
	print("done")
	monologue.visible = false

func _on_news_to_mail_pressed():
	news.visible = false
	news_continue_button.visible = false
	mail.visible = true
	mail_continue_button.visible = true


func _on_start_day_pressed():
	Global.game_manager.start_day()
