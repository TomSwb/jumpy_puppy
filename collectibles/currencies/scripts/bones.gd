extends Area2D

@onready var pick_up_player: AudioStreamPlayer = $SFX/pick_up
@onready var timer: Timer = $Timer

signal bone_picked_up

func _on_body_entered(_body: Node2D) -> void:
	pick_up_player.play()
	await get_tree().create_timer(0.1).timeout
	bone_picked_up.emit()
	queue_free()
