extends CharacterBody2D

var jump_count = 0
var jump_max = 2

const SPEED = 200.0
const JUMP_VELOCITY = -200

@onready var sprite: Sprite2D = $Sprite2D  # Update this if your sprite is named differently

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jump_count = 0

	# Handle jump
	if Input.is_action_just_pressed("ui_accept") and jump_count < jump_max:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Handle movement
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		# Flip sprite based on movement direction
		if sprite:  # Ensure sprite is not null
			sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
