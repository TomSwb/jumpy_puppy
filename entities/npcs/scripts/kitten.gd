extends Area2D

@onready var meow: AudioStreamPlayer = $SFX/meow
@onready var meow_timer: Timer = $SFX/Timer
@onready var range_timer: Timer = $RangeCheckTimer
@onready var found_me: RichTextLabel = $found_me
@onready var next: RichTextLabel = $next
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var meow_range: float = 2000.0

signal kitten_picked_up

var player: Node2D
var player_in_range := false
var current_distance := 0.0  # store distance to player
var picked_up := false

func _ready():
	player = get_tree().get_first_node_in_group("player")
	meow_timer.timeout.connect(_on_meow_timer_timeout)
	range_timer.timeout.connect(_check_distance)
	animated_sprite_2d.play("idle")


func _check_distance():
	if not player:
		return

	current_distance = global_position.distance_to(player.global_position)

	if current_distance <= meow_range:
		if not player_in_range:
			player_in_range = true
			meow_timer.start()
	else:
		if player_in_range:
			player_in_range = false
			meow_timer.stop()


func _on_meow_timer_timeout():
	if player_in_range and not picked_up:
		meow.pitch_scale = randf_range(0.95, 1.05)

		# Map distance to volume_db (-20 = far, 0 = very close)
		var t = clamp(current_distance / meow_range, 0, 1)
		meow.volume_db = lerp(5, -15, t)  # closer = louder, farther = quieter

		meow.play()
		print("meow_play")
		meow_timer.wait_time = randf_range(2.0, 4.0)

func _on_body_entered(_body: Node2D) -> void:
	if picked_up:
		return
	
	picked_up = true
	kitten_picked_up.emit()
	found_me.show()
	await get_tree().create_timer(3.0).timeout
	found_me.hide()
	next.show()
	await get_tree().create_timer(5.0).timeout
	queue_free()
