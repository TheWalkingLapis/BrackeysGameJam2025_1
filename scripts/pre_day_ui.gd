extends Control

@export var newspapers_aliens: Texture2D
@export var newspapers_pandemic: Texture2D

@onready var mail: Control = $Mail
@onready var mail_txt: RichTextLabel = $Mail/Text
@onready var news: TextureRect = $News

@onready var weekday_node = $Weekday
@onready var monologue = $Monologue

@onready var news_continue_button: Button = $News_to_Mail
@onready var mail_continue_button: Button = $Start_day
@onready var weekday_continue_button = $Weekday/Weekday_continue

var has_news = false

var mail_1 = "Hi Jeremy,

this is your last working week after 40 years of hard labour for our nuclear power plant.
You always did an amazing job. I will miss you sincerely both as a colleague and a friend.

Remember that you can use the plan in the hallway if you're ever lost.
I will give you tasks that are shown on the right in your taskbar, you have to do them until you shift ends in the evening. Click on the eye in the upper right corner to show or hide your taskbar.

All endings are also a new beginning, I heard you will be going to Gran Canaria with Josephine. That's nice.
To a successful last week, old sport.

Best regards,
Big D"
var mail_2 = "Hi Jeremy,

Sophia from orders is sick today. Could you please fill in for her? 
It should be really easy, you just have to click the  \"Order\" Button for all our needed supplies on your PC.

Thank you for doing this.

Best regards,
Big D
"
var mail_3 = "Hi Jeremy,

maybe you've already heard, but there's a pandemic going around. 
Our janitor Fernando and Fred from logistics both called in sick today. Could you please help out and also do their work?

Fernando as a janitor always watered the plant in your office and in the hallway. This should be easy, there's a watering can in the kitchen. He also reconnected the circuits in the power boxes when they were broken. You can do this by simply wiring the matching colors.

You have to do a little bit of walking for Fred's logistics tasks. He delivered everything Sophia ordered to it's place. This should be straightforward, just collect the things you've ordered in the storage and put them to the right place.

To do all of this, you can now access the kitchen, storage and the passage to the reactor.

Thank you Jeremy.

Best regards,
Big D"
var mail_4 = "Hello Jeremy,

this pandemic situation worries me. My wife is sick, she's not in a good condition.

Max from the Reactor and Alan from the Control room are sick as well.
I know it's a lot to ask, but please keep the electricity running for our city by doing their tasks.
I will give you access to the reactor and the control room.

Max was responsible for the amount of uranium fuel in the rods. You can lift the rods by pressing the up button in the control room, under the fuel meter. Simply touch the rods in the reactor room to refill them. Afterwards you have to lower the rods again in the control room.

Alan kept the temperature of the reactor in check by supplying new cooling water to it. You can do this at the temperature gauge in the control room, repeatedly press the button until there's enough cooling water for the temperature to be low.

You have to keep the temperature below 1000°C and the fuel above 0%, otherwise there will be a nuclear meltdown!
Our hope rests in you to keep our electricity up and running. I believe in you.

Best regards,
Big D"
var mail_5 = "Hi Jeremy,

apparently there's aliens visiting us on earth and everyone's going crazy?
Our government ordered us to produce atom bombs now?!

I know you have a lot on your plate already but you have to do this as well, no one else can do it.
I have the assembly manual here, it reads as follows:
You have to order a atom bomb kit from your PC, go to the storage and put it on the workbench there.
Then assemble the bomb by simply picking up the pieces and putting them to the right space.

I'm starting to get sick too, I have a really bad cough. If I continue to get sicker at this rate, I won't be able to come in tomorrow.
Just to remind you, in case of an emergency, if you have to unlock the plutonium in the shop, the code is in the safe in my office.

The future of our nation depends on you! You can do this!

Best regards,
Big D"
var mail_6 = ""

var mono_1 = "5 days. That's all I have left until I can finally retire and me and my wife can go to our well deserved vacation in Gran Canaria. Damn I love my wife.
Honestly those days should pass quickly, all I have to do is sign one document per day. At this point, nothing can go wrong..."
var mono_2 = "Only 4 days remaining, easy as always. I'm looking forward to Gran Canaria!"
var mono_3 = "Damn, yesterday I actually had to work for once. I'll just have to persevere and think of my lovely wife!"
var mono_4 = "Damn, yesterday I worked more than in the last three years combined!
I hope I won't get more work, this is exhausting! 
Well, it's just today and tomorrow, nothing can go wrong..."
var mono_5 = "Good lord, I'm working my ass off here. This is my last day until I get my well deserved vacation, I have to endure it!
God am I looking forward to see my wife this evening."
var mono_6 = "Wha- What's happening? Is that a UFO outside?"

var signal_connected = false
var mono_txt = ""

func day(day):
	if !signal_connected:
		Global.text_manager.finished_menu_text.connect(_on_monologue_done)
		signal_connected = true

	if day == 2:
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
	var weekday = "NONE"
	match int(day):
		0:
			mono_txt = mono_1
			mail_txt.text = mail_1
			weekday = "Monday"
		1:
			mono_txt = mono_2
			mail_txt.text = mail_2
			weekday = "Tuesday"
		2:
			mono_txt = mono_3
			mail_txt.text = mail_3
			weekday = "Wednesday"
		3:
			mono_txt = mono_4
			mail_txt.text = mail_4
			weekday = "Thursday"
		4:
			mono_txt = mono_5
			mail_txt.text = mail_5
			weekday = "Friday"
		5:
			mono_txt = mono_6
			mail_txt.text = mail_6
			weekday = "Saturday"
	$Weekday/day.text = "[center]%s[/center]" % weekday
	weekday_node.visible = true
	Global.text_manager.show_text_in_menu(mono_txt, Color(1,1,1,0.1))

func _on_monologue_done():
	monologue.visible = false
	weekday_node.visible = false
	if Global.game_manager.current_day == 5:
		Global.game_manager.start_day()

func _on_news_to_mail_pressed():
	news.visible = false
	news_continue_button.visible = false
	mail.visible = true
	mail_continue_button.visible = true


func _on_start_day_pressed():
	Global.game_manager.start_day()
