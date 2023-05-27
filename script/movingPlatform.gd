extends CharacterBody2D

@export var speed : float = 0.01
@export var amplitude : float = 100
var direction : float = 1
var zero
@export var angle : float = 0
var deleteNumber = 0
func _ready():
	angle = deg_to_rad(angle)
	zero = global_position;
func _physics_process(delta):
	# var velocity = get_velocity()
	var move = Vector2(cos(angle)* direction * speed * amplitude,sin(angle)*direction * speed * amplitude)
	var deltax = cos(angle)*(global_position.x - zero.x) +  sin(angle)*(global_position.y - zero.y)
	#print_debug(move,deltax)
	if deltax > amplitude:
		direction = -1
	if deltax < -amplitude: 
		direction = 1
		
	var collision = move_and_collide(move)
	if collision:
		var collider = collision.get_collider()
		var collName = collider.name
		if collName == "StarShip":
			pass
		elif collName == "Player":
			collider.move_and_collide(move)
			move_and_collide(move)
		else:
			direction = -direction	
		
	
func highlight(g):
	if deleteNumber == 0:
		get_node("HighlightMoving").visible = true
	else:
		get_node("HighlightStatic").visible = true
	
func unhighlight(g):
	get_node("HighlightMoving").visible = false
	get_node("HighlightStatic").visible = false
	
func delete(g):
	unhighlight(g)
	print_debug("delete the moving platform")
	if deleteNumber==1:
		queue_free()
	else: 
		get_node("moving").visible = false
		get_node("static").visible = true
		deleteNumber=1
		speed=0
