# damage_area.gd
extends Area2D
class_name DamageArea

@export var damage: int = 1


func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:

	var health = body.get_node_or_null("Components/Health")
	var invincibility = body.get_node_or_null("Components/Invincibility")
	var parent_node = get_parent()
	# If enemy is already dying, do nothing
	if parent_node.has_method("is_dead") and parent_node.is_dead:
		return
	# Only damage entities with Health component


	if invincibility and invincibility.is_invincible:
		# Body is invincible, just return
		return

	if health and health.has_method("take_damage"):
		health.take_damage(damage)
		
	# Decide behavior based on what DamageArea lives in
	
	if parent_node is CharacterBody2D:
		# Trigger flicker
		if invincibility:
			invincibility.trigger_invincibility()
		return
	else:
		# Respawn for hazards
		if body.has_method("respawn"):
			body.respawn()
