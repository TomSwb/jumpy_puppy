extends TouchScreenButton
class_name JumpButton

@export var action = "jump"

func _ready():
	# Connect signals to methods in this node
	self.button_down.connect(_on_button_down)
	self.button_up.connect(_on_button_up)

func _on_button_down():
	if action != "":
		Input.action_press(action)
		print("jump")

func _on_button_up():
	if action != "":
		Input.action_release(action)
		print("jump")
