extends Node
class_name HealthComponent

signal died

@export var health_ui: HealthUI
@export var max_health: int = 3
@export var health: int = 3

# Initialize max health for level start
func set_max_health(new_max: int) -> void:
	max_health = new_max
	health = new_max
	if health_ui:
		health_ui.set_max_hearts(max_health)
		health_ui.update_hearts(health)

# Called when player collects 5 bones
func add_health_ui() -> void:
	if health < max_health:
		# Heal 1 if not full
		health += 1
	else:
		# Already full, increase max health by 1 and add 1 heart
		max_health += 1
		health += 1

	if health_ui:
		health_ui.set_max_hearts(max_health) # add new heart if needed
		health_ui.update_hearts(health)

# Called when player takes damage
func take_damage(amount: int = 1) -> void:
	health -= amount
	health = max(0, health)

	if health_ui:
		health_ui.update_hearts(health)

	if health <= 0:
		died.emit()
