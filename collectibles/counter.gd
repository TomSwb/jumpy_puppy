extends Control
class_name Counter

@export var icon_texture: Texture2D  # still export so you can assign bone/kitten icon in editor

@onready var icon: TextureRect = $VBoxContainer/HBoxContainer/TextureRect
@onready var label: Label = $VBoxContainer/HBoxContainer/Label

var current_count: int = 0
var max_count: int = 0  # no longer exported

func _ready():
	icon.texture = icon_texture
	update_label()

func increment(amount: int = 1):
	current_count = clamp(current_count + amount, 0, max_count)
	update_label()

func set_count(count: int):
	current_count = clamp(count, 0, max_count)
	update_label()

func set_max_count(new_max: int):
	max_count = new_max
	# optional: reset current count if desired
	set_count(current_count)
	
func update_label():
	label.text = "%d / %d" % [current_count, max_count]
