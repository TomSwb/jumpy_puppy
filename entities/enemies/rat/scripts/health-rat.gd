extends Node
class_name HealthRat

signal died

@export var health: int = 3

# Initialize max health for level start
func set_health(new_health: int) -> void:
	health = new_health

# Called when player takes damage
func take_damage(amount: int = 1) -> void:
	health -= amount
	health = max(0, health)

	if health <= 0:
		died.emit()
