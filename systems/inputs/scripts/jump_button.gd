extends TouchScreenButton
class_name JumpButton

@export var move = "jump"

func _ready():
	# Connect signals to methods in this node
	self.button_down.connect(_on_button_down)
	self.button_up.connect(_on_button_up)

func _on_button_down():
	if move != "":
		Input.action_press(move)
		print("jump")

func _on_button_up():
	if move != "":
		Input.action_release(move)
		print("jump")
