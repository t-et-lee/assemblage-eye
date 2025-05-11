extends Control


func _on_area_close_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		gamehandler.emit_signal("close_save_menu")
		accept_event()
