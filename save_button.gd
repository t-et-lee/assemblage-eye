extends Control



func _on_area_save_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_pressed():
		match gameflags.flag_savemenu_open:
			false:
				gamehandler.emit_signal("open_save_menu")
