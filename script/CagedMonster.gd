extends CharacterBody2D

var speed : float = 0.01
var amplitude : float = 100
var direction : float = 1
var zero
var gravityScale = 100

var speedFlyer = 0.0005
var amplitudeFlyer = 10000


var isDeadly = true
var isFlyer = true

var animation : AnimatedSprite2D
func _ready():
	zero = global_position;
	animation = get_node("Animation")
	animation.animation = "blink"
	if isDeadly:
		makeDeadly()
	if isFlyer:
		makeFlyer(-1)
	
func makeDeadly():
	isDeadly = true
	var cage  : Sprite2D = get_node("cage")
	animation.play("walking")
	if cage!=null:
		cage.queue_free()
		
		
var Monster = preload("res://scene/CagedMonster.tscn")
var otherFlyer 
func makeFlyer(_direction=1):
	isFlyer = true
	isDeadly=true
	direction=_direction
	get_node("CollisionBig").queue_free()
	animation.play("flyer")
	animation.offset.y = -12
	if direction==-1:
		pass
		#otherFlyer = Monster.new()
		#flyerReady()
		#add_child(otherFlyer)
#func flyerReady():
#	otherFlyer.makeDeadly()
#	otherFlyer.makeFlyer()
		
func _physics_process(delta):
	# var velocity = get_velocity()\ 
	var mSpeed = speed
	var mAmplitude = amplitude
	if isFlyer:
		mSpeed = speedFlyer
		mAmplitude = amplitudeFlyer
	#print(direction)
	if isDeadly : 
		var move = Vector2( direction * mSpeed * mAmplitude * delta / 0.016,0)
		var deltax = global_position.x - zero.x
		if deltax > mAmplitude:
			direction = -1
		if deltax < -mAmplitude: 
			direction = 1
			
		if not isFlyer:
			move.y += gravityScale * delta
			
		var collision_event = move_and_collide(move,true)
		
		if collision_event != null:
			var normal = collision_event.get_normal()
			print_debug(normal,collision_event.get_collider().name)
			if abs(normal.x) < abs(normal.y):
				move.y=-0.08
			#if "kill" in collision_event.get_collider(): 
			#	GameManager.killPlayer()
			
			collision_event = move_and_collide(move,true)
				
			if collision_event != null:
				normal = collision_event.get_normal()
				print_debug(normal,collision_event.get_collider().name)
				if abs(normal.x) > abs(normal.y):
					if normal.x<0:
						direction = -1
					else:
						direction = 1
		
		collision_event = move_and_collide(move)

	if(randf_range(0,4/delta) < 1):
		print_debug("play")
		animation.play()
			
func highlight(g):
	if not isDeadly:
		get_node("highlightCage").visible = true
	elif not isFlyer:
		get_node("MonsterHighlight").visible = true
	else:
		get_node("FlyerHighlight").visible = true
		
func unhighlight(g):
	if not isDeadly:
		get_node("highlightCage").visible = false
	elif not isFlyer:
		get_node("MonsterHighlight").visible = false
	else:
		get_node("FlyerHighlight").visible = false
		
func respawn():
	position = zero
		
func delete(g):
	print_debug("delete a monster")
	unhighlight(g)
	if not isDeadly:
		makeDeadly()
	elif not isFlyer:
		makeFlyer(-1)
	else:
		queue_free()
		
	
func pauseMonster():
	print_debug("paused monster")
	direction=0
	
func resumeMonster():
	print_debug("res")
	direction=1
#func _process(delta):
