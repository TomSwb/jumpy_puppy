# state_component.gd
extends Node
class_name StateComponent

@export var state_resource: StateResource

var current_state: String = ""
var facing_direction: int = 1  # 1 = right, -1 = left

func set_state(new_state: String) -> void:
	if current_state == new_state:
		return  # Prevent spamming the same animation
	current_state = new_state

func set_facing(direction: float):
	if direction != 0:
		facing_direction = sign(direction)
		
func reset_state():
	current_state = ""  # or "idle" if you want a default animation
	facing_direction = 1
	# if you have other flags like jumping, running, etc., reset them here too
