extends Node2D

@export var speed := 200
@onready var area = $Area2D

var player: Node2D = null
var following := false

func _ready():
	area.connect("body_entered", _on_body_entered)
	area.connect("body_exited", _on_body_exited)

func _process(delta):
	if following and player:
		var direction = (player.global_position - global_position).normalized()
		position += direction * speed * delta

func _on_body_entered(body):
	if body.name == "Player":
		player = body
		following = true

func _on_body_exited(body):
	if body == player:
		following = false
		player = null
