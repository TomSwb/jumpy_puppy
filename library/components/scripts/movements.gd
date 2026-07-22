extends Node
class_name MovementComponent

@export var movement_var: MovementResource
@export var state_component: StateComponent

# 👇 Snap length now editable directly in inspector
@export var snap_length: float = 12.0

var was_running := false
var run_timer := 0.0
var idle_timer := 0.0

# normal movement logic

func handle_movement(body: CharacterBody2D, delta: float, input_comp: InputComponent):

	var direction = input_comp.direction
	var jump_pressed = input_comp.jump_pressed
	var jump_held = input_comp.jump_held

	# ==================================================
	# 1️⃣ GROUND MOVEMENT LOGIC
	# ==================================================
	if movement_var.movement_type == MovementResource.MovementType.GROUND:

		# --------------------------
		# Apply gravity
		# --------------------------
		if not body.is_on_floor():
			var gravity_force = movement_var.gravity

			# Falling faster
			if body.velocity.y > 0:
				gravity_force *= movement_var.fall_multiplier

			# Short hop (jump released early)
			elif body.velocity.y < 0 and not jump_held:
				gravity_force *= movement_var.low_jump_multiplier

			body.velocity.y += gravity_force * delta


		# --------------------------
		# Jump
		# --------------------------
		if jump_pressed and body.is_on_floor():
			body.velocity.y = movement_var.jump_velocity


	# ==================================================
	# 2️⃣ FLYING MOVEMENT
	# ==================================================
	elif movement_var.movement_type == MovementResource.MovementType.FLYING:
		body.velocity.y = input_comp.direction_y * movement_var.speed


	# ==================================================
	# 3️⃣ HORIZONTAL MOVEMENT
	# ==================================================
	if direction != 0:

		idle_timer = 0.0
		run_timer += delta

		var is_running = run_timer >= movement_var.is_running_timer
		var target_speed = movement_var.speed

		if is_running:
			target_speed *= movement_var.run_multiplier

		body.velocity.x = move_toward(
			body.velocity.x,
			direction * target_speed,
			movement_var.acceleration * delta
		)

		state_component.set_facing(direction)
		was_running = is_running

	else:
		run_timer = 0.0

		body.velocity.x = move_toward(
			body.velocity.x,
			0,
			movement_var.friction * delta
		)

		was_running = false


	# ==================================================
	# 4️⃣ APPLY FLOOR SNAP
	# ==================================================
	if movement_var.movement_type == MovementResource.MovementType.GROUND:
		body.floor_snap_length = snap_length
	else:
		body.floor_snap_length = 0


	# ==================================================
	# 5️⃣ APPLY MOVEMENT (IMPORTANT POSITION)
	# ==================================================
	body.move_and_slide()


	# ==================================================
	# 6️⃣ STATE / ANIMATION (AFTER MOVE)
	# ==================================================
	if movement_var.movement_type == MovementResource.MovementType.GROUND:

		if not body.is_on_floor():

			if body.velocity.y < 0:
				state_component.set_state(
					state_component.state_resource.jump_up
				)
			else:
				state_component.set_state(
					state_component.state_resource.jump_down
				)

		elif direction != 0:

			state_component.set_state(
				state_component.state_resource.run
				if was_running
				else state_component.state_resource.walk
			)

		else:
			idle_timer += delta

			if idle_timer >= movement_var.is_idle_timer:
				state_component.set_state(
					state_component.state_resource.idle_long
				)
			else:
				state_component.set_state(
					state_component.state_resource.idle
				)
