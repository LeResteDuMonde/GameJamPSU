extends CharacterBody2D

var speed : float = 0.01
var amplitude : float = 100
var direction : float = 1
var zero

var isDeadly = false

func _ready():
	#DEBUG
	makeDeadly()
	
func makeDeadly():#TODO connect to click
	isDeadly = true
	#TODO change sprit to animated sprit

func _physics_process(delta):
	# var velocity = get_velocity()\
	if isDeadly : 
		var move = Vector2( direction * speed * amplitude,0)
		var deltax = global_position.x - zero.x
		if deltax > amplitude:
			direction = -1
		if deltax < -amplitude: 
			direction = 1
		
	collision_event = move_and_collide(move)
	if kill in collision_event.get_collider(): 
		print_debug("kill")
		
func _process(delta):
	
