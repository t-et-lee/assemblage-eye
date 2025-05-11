extends Control


func _on_area_close_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		gamehandler.emit_signal("close_save_menu")
		accept_event()


func _on_area_save_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		match shape_idx:
			0:
				gamehandler.emit_signal("save_1")
				accept_event()
				print("saving slot 1")
			1:
				gamehandler.emit_signal("save_2")
				accept_event()
				print("saving slot 2")
			2:
				gamehandler.emit_signal("save_3")
				accept_event()
				print("saving slot 3")
