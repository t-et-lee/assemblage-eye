extends Control

@onready var textbox = $Textbox
@onready var layers = $Layers

func _ready() -> void:
	gamehandler.connect("text_accept", next_text)

func next_text():
	if gameflags.flag_input_acceptable:
		gameflags.flag_input_acceptable = false
		
