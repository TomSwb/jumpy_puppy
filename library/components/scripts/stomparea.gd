extends Area2D

@export var bounce : int
@export var damages_taken : int

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if not body is CharacterBody2D:
		return
	
	if body.velocity.y > 0:
		
		var parent_node = get_parent()
		
		# Disable THIS stomp area to prevent re-trigger
		set_deferred("monitoring", false)
		
		# Disable the damage area BEFORE dying
		var damage_area = parent_node.get_node_or_null("AttackArea")
		if damage_area:
			damage_area.monitoring = false   # stops detecting overlaps
		
		if parent_node.health and parent_node.health.has_method("take_damage"):
			parent_node.health.take_damage(damages_taken)
			print("enemy takes damage")
			
			#bounce off enemy
			body.velocity.y = -bounce
			
			# enemy attack restored
			await get_tree().create_timer(1.0).timeout
			set_deferred("monitoring", true)
			damage_area.monitoring = true
