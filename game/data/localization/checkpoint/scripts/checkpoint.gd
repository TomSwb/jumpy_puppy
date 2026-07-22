extends Area2D
class_name CheckPoint

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.last_checkpoint_pos = global_position
