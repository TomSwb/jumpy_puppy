extends Control
class_name MainMenu

@onready var mobile: Button = $MarginContainer/HBoxContainer/mobile
@onready var desktop: Button = $MarginContainer/HBoxContainer/desktop


const LEVEL_1 = preload("res://game/levels/level1-grass/level_1.tscn") as PackedScene

func _ready() -> void:
	handle_connecting_signals()

func handle_connecting_signals() -> void:
	mobile.pressed.connect(self.on_mobile_up)
	desktop.pressed.connect(self.on_desktop_up)

func on_mobile_up() -> void:
	GameSettings.mobile_mode = true
	get_tree().change_scene_to_packed(LEVEL_1)

func on_desktop_up() -> void:
	GameSettings.mobile_mode = false
	get_tree().change_scene_to_packed(LEVEL_1)
