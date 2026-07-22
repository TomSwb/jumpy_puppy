extends Resource
class_name InputResource

# Which input sources to use
@export var use_desktop_input: bool = true
@export var use_mobile_input: bool = false
@export var use_ai_input: bool = false

# Actions for input
@export var jump_action: String = "ui_accept"
@export var left_action: String = "ui_left"
@export var right_action: String = "ui_right"

# Mobile-specific actions (for UI buttons)
@export var mobile_jump_action: String = "jump"
@export var mobile_left_action: String = "move_left"
@export var mobile_right_action: String = "move_right"

# AI parameters (optional)
@export var ai_speed: float = 1.0
@export var ai_jump_probability: float = 0.2
