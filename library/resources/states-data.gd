# state_resource.gd
extends Resource
class_name StateResource

@export var idle: String = "idle"
@export var idle_long: String = "idle_long"
@export var walk: String = "walk"
@export var run_start: String = "run_start"
@export var run: String = "run"
@export var run_end: String = "run_end"
@export var jump_up: String = "jump_up"
@export var jump_down: String = "jump_down"
@export var dying: String = "dying"
