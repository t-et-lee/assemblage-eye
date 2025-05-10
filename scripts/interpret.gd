extends Control

@onready var charname = $Character_Name
@onready var speech = $Speech
@onready var speechspeed = 0

func change_speaker(new: String):
	charname.text = new

func change_text(new: String, speed: int = 1):
	self.speechspeed = speed
	speech.text = new
	speech.visible_characters = 0

func _physics_process(delta: float) -> void:
	if speech.visible_ratio != 1.0:
		speech.visible_characters += speechspeed
		if speech.visible_ratio == 1.0:
			gameflags.flag_input_acceptable = true


func _on_click(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	gamehandler.emit_signal("text_accept")
