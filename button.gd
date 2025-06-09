extends Button

# Button's script

func _on_button_pressed():
	get_tree().change_scene_to_file("res://path/to/main.tscn")
