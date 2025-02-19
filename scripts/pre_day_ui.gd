extends Control

@export var newspapers: Array[Texture2D]

@onready var mail: TextureRect = $Mail
@onready var mail_txt: RichTextLabel = $Mail/Mail_Text
@onready var news: TextureRect = $News

@onready var news_continue_button: Button = $News_to_Mail
@onready var mail_continue_button: Button = $Start_day

func day(day):
	news.texture = newspapers[day]
	news.visible = true
	news_continue_button.visible = true
	mail.visible = false
	mail_continue_button.visible = false

func _on_news_to_mail_pressed():
	news.visible = false
	news_continue_button.visible = false
	mail.visible = true
	mail_continue_button.visible = true


func _on_start_day_pressed():
	Global.game_manager.start_day()
