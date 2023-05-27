extends CharacterBody2D

var speed : float = 0.01
var amplitude : float = 100
var direction : float = 1
var zero
var gravityScale = 100

var isDeadly = false

func _ready():
	zero = global_position;
	#DEBUG
	#makeDeadly()
	
func makeDeadly():#TODO connect to click
	isDeadly = true
	var cage  : Sprite2D = get_node("cage")
	if cage!=null:
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
	
		move.y += gravityScale * delta
		var collision_event = move_and_collide(move,false,0.08,true)
		
		if collision_event != null:
			var normal = collision_event.get_normal()
			print_debug(normal,collision_event.get_collider().name)
			if abs(normal.x) < abs(normal.y):
				move.y=-0.01
			#if "kill" in collision_event.get_collider(): 
			#	GameManager.killPlayer()
			
			collision_event = move_and_collide(move)
				
			if collision_event != null:
				normal = collision_event.get_normal()
				print_debug(normal,collision_event.get_collider().name)
				if abs(normal.x) > abs(normal.y):
					direction*=-1
				
func highlight(g):
	if not isDeadly:
		get_node("highlightCage").visible = true
	
func unhighlight(g):
	if not isDeadly:
		get_node("highlightCage").visible = false
		
func respawn():
	position = zero
		
func delete(g):
	unhighlight(g)
	makeDeadly()
	
func pauseMonster():
	print_debug("paused monster")
	direction=0
	
func resumeMonster():
	print_debug("res")
	direction=1
#func _process(delta):
