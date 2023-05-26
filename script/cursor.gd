extends Node2D

var mouse_speed = 3.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	var mouse_rel = Vector2.ZERO
	if Input.is_action_pressed("up"):
		mouse_rel += Vector2.UP * mouse_speed
	elif Input.is_action_pressed("down"):
		mouse_rel += Vector2.DOWN * mouse_speed
	elif Input.is_action_pressed("left"):
		mouse_rel += Vector2.LEFT * mouse_speed
	elif Input.is_action_pressed("right"):
		mouse_rel += Vector2.RIGHT * mouse_speed
	if mouse_rel != Vector2.ZERO:
		Input.warp_mouse_position(position + mouse_rel)
	this.position = get_global_mouse_position()

func _input(event):
	if Input.is_action_just_released("click"):
		selecting = false
	if event is InputEventMouseMotion:
		mouse_pos = event.position
