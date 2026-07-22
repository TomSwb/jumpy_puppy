extends Node2D
class_name Level1

@onready var player: Brownie = $brownie
@onready var background: AudioStreamPlayer = $music/background
@onready var victory: AudioStreamPlayer = $music/victory
@onready var rats = get_tree().get_nodes_in_group("rats")


@export var bone_goal: int 
@export var kitten_goal: int 
@export var starting_health: int 
@export var all_rats_health: int 
@export var next_level: PackedScene

func _ready() -> void:
	# start music
	background.play()
	# set starting health
	player.health.set_max_health(starting_health)
	for rat in rats:
		var rat_health = rat.get_node_or_null("HealthRat")
		if rat_health:
			rat_health.health = all_rats_health 
	# set scores goals
	if player.counter_control:
		player.counter_control.set_level_counts(bone_goal, kitten_goal)
	
	player.kitten_count_changed.connect(_on_kitten_count_changed)
	
		
	# Connect to the player's Health died signal
	var health = player.get_node_or_null("Components/Health")
	if health:
		health.died.connect(_on_player_died)

func _on_player_died() -> void:
	background.stop()

func _on_kitten_count_changed(amount: int):
	if amount >= kitten_goal:
		end_level()

func end_level() -> void:
	if player.kittens_collected >= kitten_goal:
		print("level complete")
		background.stop()
		victory.play()
		await get_tree().create_timer(10.0).timeout
		get_tree().change_scene_to_packed(next_level)
