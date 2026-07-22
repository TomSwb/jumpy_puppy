# stomp_attack_component.gd
extends Area2D
class_name StompAttackComponent

@export var damage: int = 1
@export var bounce_strength: float = 400
@export var effect_scene: PackedScene
@export var attack_sound: AudioStream

signal attacked(target)

func _ready():
	monitoring = true
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Only affect enemies with HealthRat component
	var health = body.get_node_or_null("Components/HealthRat")
	if not health:
		return

	# Only trigger if player is falling
	var player = get_parent()
	if not player.has_method("velocity"):
		return

	if player.velocity.y <= 0:
		return

	# Deal damage
	health.take_damage(damage)
	emit_signal("attacked", body)

	# Bounce the player
	player.velocity.y = -bounce_strength

	# Optional: effect
	if effect_scene:
		var e = effect_scene.instantiate()
		get_parent().add_child(e)
		e.global_position = body.global_position

	# Optional: sound
	if attack_sound:
		var sfx = AudioStreamPlayer2D.new()
		sfx.stream = attack_sound
		get_parent().add_child(sfx)
		sfx.global_position = body.global_position
		sfx.play()
