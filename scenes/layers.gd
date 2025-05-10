extends Node2D
@onready var bg = $bg
@onready var fx = $fx
var tween

func _on_child_entered_tree(node: Node) -> void:
	tween = get_tree().create_tween()
	tween.tween_property(node, "self_modulate", Color(1,1,1,1), 0.8)
