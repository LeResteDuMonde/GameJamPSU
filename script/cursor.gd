extends Node2D

var mouse_speed = 5.0

func _process(delta):
	var mouse_rel = Input.get_vector("left", "right", "up", "down")
	position = position + mouse_rel * mouse_speed
	print(position.x, ";", position.y)
#	this.position = get_global_mouse_position()

func _input(event):
	if event is InputEventMouseMotion:
		position = get_global_mouse_position()
