extends Control

@onready var charname = $Character_Name
@onready var speech = $Speech
@onready var speechspeed = 0

func change_speaker(new: String):
	charname.text = new

func change_text(new: String):
	self.speechspeed = gameflags.flag_globalspeed
	speech.text = new
	speech.visible_characters = 0

func _physics_process(delta: float) -> void:
	if speech.visible_ratio != 1.0 and gameflags.flag_savemenu_open == false:
		speech.visible_characters += speechspeed
		if speech.visible_ratio >= 1.0:
			gameflags.flag_input_acceptable = true


func _on_click(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		gamehandler.emit_signal("text_accept")	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("Progress"):
		gamehandler.emit_signal("text_accept")
