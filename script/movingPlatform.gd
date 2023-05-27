extends CharacterBody2D

@export var speed : float = 0.01
@export var amplitude : float = 100
@export var direction : float = 1
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

	if deltax > amplitude:
		direction = -1
	if deltax < -amplitude: 
		direction = 1
		
	
	move_and_collide(move)
	
func delete(g):
	print_debug("delete the moving platform")
	if deleteNumber==2:
		queue_free()
	else: 
		deleteNumber+=1
		speed=0
