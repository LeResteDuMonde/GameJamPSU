extends Node

var selecting = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _input(event):
	if Input.is_action_just_released("click"):
		selecting = false
