extends Node2D

var mouse_speed = 5.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	var mouse_rel = Input.get_vector("left", "right", "up", "down")
	position = position + mouse_rel * mouse_speed
#	this.position = get_global_mouse_position()

func _input(event):
	if Input.is_action_just_released("click"):
		print("click")
#		selecting = false
	if event is InputEventMouseMotion:
		position = get_global_mouse_position()
