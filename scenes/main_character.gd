extends CharacterBody2D
var jump_count= 0
var jump_max=2
const SPEED = 200.0
const JUMP_VELOCITY = -200


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jump_count=0
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < jump_max:
		velocity.y = JUMP_VELOCITY 
		jump_count+=1
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
