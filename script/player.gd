extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const ANALOGIC_JUMP_VELOCITY = -200.0
var jumpIsAnalogic = true
var jumpTime = 1
var jumpTimer = 0

var isJumping = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _physics_process(delta):
	var boundaries = get_viewport_rect().size
	if boundaries.y < global_position.y/2:
		print_debug("killed by boundaries")
		kill()
	
	
	
func move(delta, direction, jump):
	
	if(jumpIsAnalogic) : analogicJump(delta,jump)
	else : jump(delta,jump)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func kill():
	PlayerManager.respawnPlayer()
	GameManager.killPlayer()

func jump(delta,jump):
	if not is_on_floor():
		applyGravity(delta)
	elif jump:
		velocity.y = JUMP_VELOCITY
		
func analogicJump(delta,jump):
	if not is_on_floor():
		jumpTimer -= delta
	elif jump:
		jumpTimer = jumpTime

	if not jump:
		jumpTimer = 0
	
	if(jumpTimer > 0):
		velocity.y = ANALOGIC_JUMP_VELOCITY * (1 - (jumpTime - jumpTimer) / jumpTime) ** 2
	else:
		applyGravity(delta)

func applyGravity(delta):
	velocity.y += gravity * delta
