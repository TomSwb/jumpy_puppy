# brownie.gd
extends CharacterBody2D
class_name Brownie

@onready var inputs: InputComponent = $Components/Inputs
@onready var movement: MovementComponent = $Components/Movement
@onready var health: HealthComponent = $Components/Health
@onready var states: StateComponent = $Components/States
@onready var invincibility: InvincibilityComponent = $Components/Invincibility

@export var spawn_position: Vector2
@export var respawn_delay := 0.5
@export var counter_control: CounterControl

var last_checkpoint_pos: Vector2
var is_dead: bool = false
var bones_collected: int = 0
var kittens_collected: int = 0

signal kitten_count_changed

func _ready():
	# mark this as respawnable
	set_meta("respawnable", true)
	global_position = spawn_position
	last_checkpoint_pos = global_position
	health.died.connect(_on_player_died)
	connect_bones()
	connect_kittens()
	

func _physics_process(delta):
	if is_dead:
		return
	inputs.update_input(delta)
	movement.handle_movement(self, delta, inputs)
	
func connect_bones():
	for bone in get_tree().get_nodes_in_group("bones"):
		bone.bone_picked_up.connect(_on_bone_picked_up)

func _on_bone_picked_up():
	collect_bone()

func collect_bone():
	bones_collected += 1
	counter_control.collect_bone()
	if bones_collected % 5 == 0:
		health.add_health_ui()

func connect_kittens():
	for kittens in get_tree().get_nodes_in_group("kittens"):
		kittens.kitten_picked_up.connect(_on_kitten_picked_up)

func _on_kitten_picked_up():
	collect_kitten()
	print("kitten pickecked up")

func collect_kitten():
	kittens_collected += 1
	print("kitten collected")
	counter_control.collect_kitten()
	kitten_count_changed.emit(kittens_collected)

# Optional method for generic checkpoint
func set_last_checkpoint(pos: Vector2) -> void:
	last_checkpoint_pos = pos
	

func respawn():
	if is_dead:
		return

	await get_tree().create_timer(respawn_delay).timeout
	global_position = last_checkpoint_pos
	states.reset_state()

func _on_player_died():
	if is_dead:
		return
	is_dead = true
	
	print("Player died")
	
	await get_tree().create_timer(respawn_delay).timeout
	global_position = last_checkpoint_pos
	
	states.reset_state()
	states.set_state("dying")
	
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()
