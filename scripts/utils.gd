extends Node

func bbc_text(txt, font_size=20):
	return "[font_size=%d]%s[/font_size]" % [font_size, txt]

func bbc_strikethrough(txt):
	return "[s]%s[/s]" % [txt]

func bbc_underline(txt):
	return "[u]%s[/u]" % [txt]
