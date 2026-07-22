extends Control
class_name HealthUI

@export var heart_texture: Texture2D
@export var heart_container: GridContainer

# Array to keep track of heart nodes
var hearts: Array = []

# Sets max hearts and adds new hearts if needed
func set_max_hearts(max_health: int) -> void:
	# Add hearts until we reach the desired max
	while hearts.size() < max_health:
		var heart = TextureRect.new()
		heart.texture = heart_texture
		heart.stretch_mode = TextureRect.STRETCH_KEEP
		heart_container.add_child(heart)
		hearts.append(heart)

# Update which hearts are visible based on current health
func update_hearts(current_health: int) -> void:
	for i in range(hearts.size()):
		hearts[i].visible = i < current_health
