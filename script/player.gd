extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func jump():
#	#jump
	
func move(delta, direction,jump):
	if not is_on_floor():
		velocity.y += gravity * delta
	elif jump:
		velocity.y = JUMP_VELOCITY 
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

	
func kill():
	print_debug("kill the player")
