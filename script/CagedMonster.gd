extends CharacterBody2D

var speed : float = 0.01
var amplitude : float = 100
var direction : float = 1
var zero

var isDeadly = false

func _ready():
	zero = global_position;
	#DEBUG
	#makeDeadly()
	
func makeDeadly():#TODO connect to click
	isDeadly = true
	var cage  : Sprite2D = get_node("cage")
	cage.queue_free()
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
	
		var collision_event = move_and_collide(move)
		
		if collision_event != null:
			print_debug("collision")
			if "kill" in collision_event.get_collider(): 
				GameManager.killPlayer()
				
func highlight():
	if not isDeadly:
		get_node("cage").modulate.a = 0.5
	
func unhighlight():
	if not isDeadly:
		get_node("cage").modulate.a = 1
		
func delete():
	makeDeadly()
#func _process(delta):
