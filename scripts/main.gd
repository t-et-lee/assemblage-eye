extends Control

@onready var textbox = $Textbox
@onready var layers = $Layers
var currenttext
var currentmenu
var list_texts = []

func _ready() -> void:
	list_texts.append("res://texts/rainscene.txt")
	load_text(0)
	gamehandler.connect("text_accept", next_text)
	gamehandler.connect("open_save_menu", open_save_menu)
	gamehandler.connect("close_save_menu", close_save_menu)

func close_save_menu():
	# queue free the save menu
	gameflags.flag_savemenu_open = false
func open_save_menu():
	# Instance the save menu here as currentmenu
	gameflags.flag_savemenu_open = true

func next_text():
	if gameflags.flag_input_acceptable:
		gameflags.flag_input_acceptable = false
		#First read the name of the speaker.
		var newline = self.currenttext.get_line()
		textbox.change_speaker(newline)
		#Then read their dialogue and send it over.
		newline = currenttext.get_line()
		textbox.change_text(newline)
		#Close the game if there's nothing left.
		if currenttext.eof_reached():
			get_tree().quit()
		#Then read the miscellaneous commands
		newline = currenttext.get_line()
		match newline:
			"bg welcome":
				layers.bg.queue_free()
				layers.bg = load("res://scenes/layers/bg_beckoning.tscn").instantiate()
				layers.add_child(layers.bg)
			"fx rain":
				layers.fx.queue_free()
				layers.fx = load("res://scenes/layers/fx_rain.tscn").instantiate()
				layers.add_child(layers.fx)
				layers.fx.z_index += 1

func load_text(filenum: int):
	self.currenttext = FileAccess.open(list_texts[filenum],FileAccess.READ)
