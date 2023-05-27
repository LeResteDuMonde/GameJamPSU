extends Area2D

func _ready():
	area_entered.connect(onAreaEntered)
	area_exited.connect(onAreaExited)

var selected = null

func onAreaEntered(area):
	unhighlightAll()
	if GameManager.isDeletePhase:
		selected = area.get_node("..")
		for g in selected.get_groups():
			if g != "_physics_process":
				get_tree().call_group(g, "highlight", g)

func unhighlightAll():
	if selected != null:
		for g in selected.get_groups():
			if g != "_physics_process":
				get_tree().call_group(g, "unhighlight", g)

func onAreaExited(area):
	unhighlightAll()
	selected = null

func _input(event):
	if event.is_action_released("click") && selected != null && GameManager.isDeletePhase:
		var deletedSomething = false
		for g in selected.get_groups():
			if g != "_physics_process":
				print_debug("groupe %s is called to be deleted" % g)
				get_tree().call_group(g, "delete",g)
				deletedSomething = true
				
		if deletedSomething:
			unhighlightAll()
			GameManager.endDeletePhase()
			GameManager.startPlayPhase()