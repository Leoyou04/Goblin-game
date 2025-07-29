extends CharacterBody2D

var jump_count = 0
var jump_max = 2

const SPEED = 200.0
const JUMP_VELOCITY = -200.0  # Adjust jump strength as you want
const GRAVITY = 1000  
 
@onready var sprite: Sprite2D = $Sprite2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		jump_count = 0

	# Handle jump input
	if Input.is_action_just_pressed("ui_accept") and jump_count < jump_max:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

	# Horizontal movement input
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		anim_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Animation handling
	if not is_on_floor():
		if velocity.y < 0:
			anim_sprite.play("jump")
	else:
		if abs(velocity.x) > 10:
			anim_sprite.play("run")
		else:
			anim_sprite.play("idle")
