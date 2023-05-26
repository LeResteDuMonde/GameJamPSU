extends Node

var player

func _ready():
	player = GameManager.main.get_node("Player")

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	movePlayer(delta,player,direction)
	
func movePlayer(delta,player,direction):
	player.move(delta,direction)
