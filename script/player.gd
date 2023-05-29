extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0
const ANALOGIC_JUMP_VELOCITY = -200.0
var jumpIsAnalogic
var jumpTime = 1
var jumpTimer = 0

var isJumping = true

var landed = false

var landingCount = 0

@onready var bootsFlame = $Sprites/Boots/Flame
@onready var bootsFlameRight = $Sprites/Boots/Particules/FlameRight
@onready var bootsFlameLeft = $Sprites/Boots/Particules/FlameLeft
@onready var dust = $Sprites/Boots/Dust
@onready var sprite = $Sprites/Body
@onready var sprites = $Sprites
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var lockAnimationTimer = 0
func _ready():
	bootsAnimation(false)
	
func _physics_process(delta):
	var boundaries = get_viewport_rect().size
	if boundaries.y < global_position.y/2:
		print_debug("killed by boundaries")
		kill()
	lockAnimationTimer -= delta
	
func move(delta, direction, jump):
	
	if (is_on_floor() and (not landed)):
		animate("landing")
#		landingCount += 1
#		print("landed " + str(landingCount))
		landed = true
	else : landed = is_on_floor()
	
	if(jumpIsAnalogic) : analogicJump(delta,jump)
	else : jump(delta,jump)
	
	if direction:
		if is_on_floor(): 
			animate("walking")
			dust.emitting = true
		else : 
			animate("default")
			dust.emitting = false
		velocity.x = direction * SPEED
		sprites.scale.x = 1 if direction > 0 else -1
	else:
		animate("default")
		dust.emitting = false
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#print_debug(collider.name)
		if !GameManager.isPlayPhase: return
		if collider.name == "StarShip":
			GameManager.win()
		elif  "CagedMonster".is_subsequence_of(collider.name):
			if collider.isDeadly:
				kill()
	
func kill():
	if GameManager.isPlayPhase:
#	PlayerManager.respawnPlayer()
		GameManager.killPlayer()

func jump(delta,jump):
	if not is_on_floor():
		applyGravity(delta)
	elif jump:
		AudioManager.play("jump",1,0,3)
		velocity.y = JUMP_VELOCITY
		
func analogicJump(delta,jump):
	if not is_on_floor():
		jumpTimer -= delta
	elif jump:
		AudioManager.play("fireReactor",1,0.7,0.9)
		jumpTimer = jumpTime

	if not jump:
		jumpTimer = 0
	
	if(jumpTimer > 0):
		bootsAnimation(true)
		velocity.y = ANALOGIC_JUMP_VELOCITY * (1 - (jumpTime - jumpTimer) / jumpTime) ** 2
	else:
		applyGravity(delta)

func applyGravity(delta):
	bootsAnimation(false)
	velocity.y += gravity * delta
	
func delete(g):
	print_debug(g)
	if g=="oxygene":
		GameManager.startTimer()
		GameManager.timeEnable = true
		var anim = get_node("Sprites/oxygene")
		anim.play("default")
		get_node("oxigene").queue_free()
		anim.show()
	if g=="boots":
		jumpIsAnalogic = false
		get_node("boots").queue_free()
	
func highlight(g):
	if g=="oxygene":
		animate("highlightOxygen")
	elif g=="boots":
		animate("highlightBoots")
	
func unhighlight(g):
	animate("default")
	
func animate(animation):
	if(lockAnimationTimer < 0):
		sprite.play(animation)
	if animation == "landing": 
		lockAnimationTimer = 0.1
	
func bootsAnimation(activate):
	bootsFlame.visible = activate
	bootsFlameLeft.emitting = activate
	bootsFlameRight.emitting = activate
	dust.emitting = false
	
	if activate : bootsFlame.play()

