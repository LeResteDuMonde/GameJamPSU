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
	var move = Vector2(cos(angle)* direction * speed * amplitude * delta / 0.016,sin(angle)*direction * speed * amplitude * delta / 0.016)
	var deltax = cos(angle)*(global_position.x - zero.x) +  sin(angle)*(global_position.y - zero.y)
	#print_debug(move,deltax)
	if deltax > amplitude:
		direction = -1
	if deltax < -amplitude: 
		direction = 1
		
	var collision = move_and_collide(move,true)
	var collider
	if collision :
		collider = collision.get_collider()
		var collName = collider.name
		if collName == "StarShip":
			pass
		elif collName == "Player":
			var norm = collision.get_normal()
			#print_debug(move.length())
			var collision2 = collider.move_and_collide(move.dot(norm)*norm,true)
			#print_debug(move.dot(norm)*norm)
			#print_debug(collision.get_normal().dot(move))
			if collision2:              #and abs(collision.get_normal().dot(norm))>0.08:
				print_debug(collision2.get_collider().name)
				GameManager.killPlayer()
			#else:
			
			#print(collider.velocity)
			collider.velocity = collider.velocity-collider.velocity.dot(norm)*norm
			#print(collider.velocity)
			#print(2*move.dot(norm)*norm)
			collision2 = collider.move_and_collide(move.dot(norm)*norm,false)
			add_collision_exception_with(collider)
		else:
			direction = -direction
			
	#print(move_and_collide(move))
	if collision : 
		remove_collision_exception_with(collider)
		
	
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
