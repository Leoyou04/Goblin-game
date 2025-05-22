extends CharacterBody2D


@export var follow_speed :=100
@export var player_path :=NodePath("")

var player = null
var should_follow := false

func _ready():
	player = get_node_or_null(player_path)
	$Detection_area.body_entered.connect(_on_body_entered)
	$Detection_area.body_exited.connect(_on_body_exited)
	
	
func _physics_process(delta):
	if player == null:
		return
		
	var direction = (player.global_position - global_position).normlaized()
	velocity = direction * follow_speed
	move_and_slide()
	
func _on_body_entered(body):
	if body.name =="player":
		should_follow = true
		print("player detected")
		
func _on_body_exited(body):
	if body.name =="player":
		should_follow = false
		print("player lost")
	

func _on_detection_area_body_entered(body):
	pass # Replace with function body.
