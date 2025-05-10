extends Sprite2D

@onready var timr_reset = 0
@onready var texture_1 = preload("res://backgrounds/fx rain1.png")
@onready var texture_2 = preload("res://backgrounds/fx rain2.png")
@onready var texture_3 = preload("res://backgrounds/fx rain3.png")
	

func _physics_process(delta: float) -> void:
	timr_reset += 1
	if timr_reset >= 270:
		self.position.y = -1080
		timr_reset = 0
	else:
		self.position.y += 4
	if timr_reset%5 == 0:
		match self.texture:
			texture_1:
				self.texture = texture_2
			texture_2:
				self.texture = texture_3
			texture_3:
				self.texture = texture_1
