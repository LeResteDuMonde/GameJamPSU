extends Node

func _input(event):
	if(event.is_action("escape")):
		GameManager.quit()

func _physics_process(delta):
	var jump = Input.is_action_pressed("jump")
	var direction = Input.get_axis("left","right")
	PlayerManager.movePlayer(delta,direction,jump)
