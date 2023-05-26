extends Node

var player

func _ready():
	player = GameManager.main.get_node("Player")

func _physics_process(delta):
	var jump = Input.is_action_pressed("jump")
	var direction = Input.get_axis("left","right")
	movePlayer(delta,player,direction,jump)
	
func movePlayer(delta,player,direction,jump):
	player.move(delta,direction,jump)
