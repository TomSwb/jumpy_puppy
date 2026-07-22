extends Node
class_name InputComponent

@export var input_var: InputResource

var direction: float = 0
var jump_pressed: bool = false
var jump_held: bool = false

# AI callbacks
var ai_direction_function: Callable
var ai_jump_function: Callable 

func update_input(_delta: float) -> void:
	direction = 0
	jump_pressed = false
	jump_held = false

	# Desktop input
	if input_var.use_desktop_input:
		direction += Input.get_axis(input_var.left_action, input_var.right_action)
		jump_pressed = jump_pressed or Input.is_action_just_pressed(input_var.jump_action)
		jump_held = jump_held or Input.is_action_pressed(input_var.jump_action)

	# Mobile input
	if input_var.use_mobile_input:
		direction += Input.get_axis(input_var.left_action, input_var.right_action)
		jump_pressed = jump_pressed or Input.is_action_just_pressed(input_var.jump_action)
		jump_held = jump_held or Input.is_action_pressed(input_var.jump_action)

	# AI input
	if input_var.use_ai_input and ai_direction_function != null:
		direction += ai_direction_function.call()
		if ai_jump_function != null:
			var jump = ai_jump_function.call()
			jump_pressed = jump_pressed or jump
			jump_held = jump_held or jump
