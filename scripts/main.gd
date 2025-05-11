extends Control

@onready var textbox = $Textbox
@onready var layers = $Layers
var currenttext
var currentmenu
var list_texts = []
var text_index
var passage_name

func _ready() -> void:
	var userdir = DirAccess.open("user://")
	if userdir.dir_exists("saves"):
		print("you've already got a save directory, bud!")
	else:
		userdir.make_dir("saves")
	
	list_texts.append("res://texts/rainscene.txt")
	load_text(0)
	gamehandler.connect("text_accept", next_text)
	gamehandler.connect("open_save_menu", open_save_menu)
	gamehandler.connect("close_save_menu", close_save_menu)
	gamehandler.connect("save_1", Callable(save_game).bind(1))
	gamehandler.connect("save_2", Callable(save_game).bind(2))
	gamehandler.connect("save_3", Callable(save_game).bind(3))

func save_game(slot):
	var bookmark = currenttext.get_position()
	var savefull = PackedStringArray([str(text_index), str(bookmark), passage_name, layers.bg.texture.resource_path])
	var packedslot = FileAccess.open("user://saves/slot"+str(slot)+".csv",FileAccess.WRITE)
	packedslot.store_csv_line(savefull)
	packedslot.close()
	close_save_menu()

func load_game(slot):
	currenttext.close()
	var packedslot = FileAccess.open("user://saves/slot"+str(slot)+".csv",FileAccess.READ)
	var filenum = packedslot.get_csv_line()
	self.currenttext = FileAccess.open(list_texts[int(filenum[0])],FileAccess.READ)
	self.currenttext.seek(int(filenum[1]))

func close_save_menu():
	# queue free the save menu
	currentmenu.queue_free()
	gameflags.flag_savemenu_open = false
	
func open_save_menu():
	print("Opening save menu!")
	currentmenu = load("res://scenes/save_menu.tscn").instantiate()
	var directory = DirAccess.open("user://saves/")
	for i in range(1, 3):
		if directory.file_exists("slot"+str(i)+".csv"):
			var slot = FileAccess.open("user://saves/slot"+str(i)+".csv", FileAccess.READ)
			var slottrue = slot.get_csv_line()
			currentmenu.get_node("Slot"+str(i)).get_node("Icon").texture = load(slottrue[3])
			currentmenu.get_node("Slot"+str(i)).get_node("Scene Name").text = slottrue[2]
			slot.close()
	self.add_child(currentmenu)
	self.move_child(currentmenu, 0)
	gameflags.flag_savemenu_open = true

func next_text():
	if gameflags.flag_input_acceptable and gameflags.flag_savemenu_open == false:
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
	text_index = filenum
	passage_name = "Rainy Eve"
