extends CharacterBody2D

var speed : float = 0.01
var amplitude : float = 100
var direction : float = 1
var zero
var deleteNumber = 0
func _ready():
	zero = global_position;
func _physics_process(delta):
	# var velocity = get_velocity()
	var move = Vector2( direction * speed * amplitude,0)
	var deltax = global_position.x - zero.x
	if deltax > amplitude:
		direction = -1
	if deltax < -amplitude: 
		direction = 1
		
	
	move_and_collide(move)
	
func delete():
	print_debug("delete the moving platform")
	if deleteNumber==2:
		queue_free()
	else: 
		deleteNumber+=1
		speed=0