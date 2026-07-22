# movements_resource.gd
extends Resource
class_name MovementResource

enum MovementType { GROUND, FLYING }

@export var movement_type: MovementType = MovementType.GROUND
@export var gravity: float 
@export var fall_multiplier: float 
@export var snap_length: float  
@export var speed: float 
@export var is_idle_timer: float
@export var is_running_timer: float 
@export var run_multiplier: float 
@export var jump_velocity: float
@export var low_jump_multiplier: float
@export var acceleration: float
@export var friction: float
