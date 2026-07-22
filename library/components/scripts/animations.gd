# animation_component.gd

extends Node
class_name AnimationComponent

@export var animated_sprite: AnimatedSprite2D
@export var state_component: StateComponent
@onready var bark_player: AudioStreamPlayer = $"../../SFX/bark"
@onready var death_player: AudioStreamPlayer = $"../../SFX/death"

var bark_played := false
var last_state := ""

func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)
	animated_sprite.frame_changed.connect(_on_frame_changed)

func _process(_delta):

	# Handle flip
	animated_sprite.flip_h = state_component.facing_direction < 0

	# Handle animation
	var current = state_component.current_state
	
	if current != "" and current != last_state:
		animated_sprite.play(current)
		last_state = current
		bark_played = false

func _on_animation_finished() -> void:
	if state_component.current_state == state_component.state_resource.idle_long:
		state_component.set_state(state_component.state_resource.idle)

func _on_frame_changed():
	if state_component.current_state == state_component.state_resource.idle_long:
		if animated_sprite.frame == 5 and not bark_played:
			bark_player.pitch_scale = randf_range(0.95, 1.05)
			bark_player.play()
			bark_played = true
	elif state_component.current_state == state_component.state_resource.dying:
		if animated_sprite.frame == 1 and not bark_played:
			death_player.pitch_scale = randf_range(0.95, 1.05)
			death_player.play()
			bark_played = true
