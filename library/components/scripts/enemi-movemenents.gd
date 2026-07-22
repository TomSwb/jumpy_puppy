extends CharacterBody2D
class_name EnemiController

@export var SPEED := 60.0
@export var GRAVITY := 400.0
@export var damage := 1
@export var player: Node = null  # drag the player node in the editor

var direction := 1
var is_dead := false

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	# Move horizontally
	velocity.x = direction * SPEED
	move_and_slide()

	# Flip on walls
	if is_on_wall():
		direction *= -1
		animation.flip_h = direction == -1

func die():
	if is_dead:
		return
	is_dead = true

	# Stop movement immediately
	velocity = Vector2.ZERO
	
	# Disable physics processing
	set_physics_process(false)
	
	# Disable main body collision
	var collision = $CollisionShape2D
	if collision:
		collision.set_deferred("disabled", true)
	
	# Play death animation
	animation.play("dying")
	
	await get_tree().create_timer(1.0).timeout
	queue_free()
