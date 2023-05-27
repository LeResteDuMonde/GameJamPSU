extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const ANALOGIC_JUMP_VELOCITY = -200.0
var jumpIsAnalogic = true
var jumpTime = 1
var jumpTimer = 0

var isJumping = true

@onready var bootsFlame = $BootsFlame

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
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#print_debug(collider.name)
		if collider.name == "StarShip":
			GameManager.win()
	
func kill():
#	PlayerManager.respawnPlayer()
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
		bootsFlame.visible = true
		bootsFlame.play()
		velocity.y = ANALOGIC_JUMP_VELOCITY * (1 - (jumpTime - jumpTimer) / jumpTime) ** 2
	else:
		applyGravity(delta)

func applyGravity(delta):
	bootsFlame.visible = false
	velocity.y += gravity * delta
	
func delete(g):
	if g=="oxigene":
		GameManager.timerEnable = true
		GameManager.startTimer()
	if g=="boots":
		jumpIsAnalogic = false
	
