extends Node
class_name InvincibilityComponent

@export var invincible_time := 1.5  # seconds of invincibility
@export var flicker_speed := 0.1    # seconds per toggle

@export var sprite: Node # adjust path to your sprite

var is_invincible: bool = false
var disabled := false

func invicible(delta):
	if disabled:
		return

func trigger_invincibility():
	if is_invincible:
		return
	is_invincible = true
	_start_flicker()

func _start_flicker():
	# Start a coroutine for flickering
	async_flicker()

func async_flicker() -> void:
	var elapsed := 0.0
	while elapsed < invincible_time:
		if sprite:
			sprite.visible = not sprite.visible
		await get_tree().create_timer(flicker_speed).timeout
		elapsed += flicker_speed
	if sprite:
		sprite.visible = true
	is_invincible = false
