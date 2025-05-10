extends Control

@onready var textbox = $Textbox
@onready var layers = $Layers
var currenttext
var list_texts = []

func _ready() -> void:
	list_texts.append("res://texts/rainscene.txt")
	currenttext = load_text(0)
	gamehandler.connect("text_accept", next_text)

func next_text():
	if gameflags.flag_input_acceptable:
		gameflags.flag_input_acceptable = false
		#First read the name of the speaker.
		var newline = currenttext.get_line()
		textbox.change_speaker(newline)
		#Then read their dialogue and send it over.
		newline = currenttext.get_line()
		textbox.change_text(newline)

func load_text(filenum: int):
	currenttext = FileAccess.open(list_texts[filenum],FileAccess.READ)
