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
			if g != "_physics_process" and not 'root_canvas'.is_subsequence_of(g):
				get_tree().call_group(g, "highlight", g)

func unhighlightAll():
	if selected != null:
		for g in selected.get_groups():
			if g != "_physics_process" and not 'root_canvas'.is_subsequence_of(g):
				get_tree().call_group(g, "unhighlight", g)

func onAreaExited(area):
	unhighlightAll()
	selected = null

func _input(event):
	if event.is_action_pressed("click") && selected != null && GameManager.isDeletePhase:
		var deletedSomething = false
		for g in selected.get_groups():
			if g != "_physics_process" and not 'root_canvas'.is_subsequence_of(g):
				print_debug("groupe %s is called to be deleted" % g)
				get_tree().call_group(g, "delete",g)
				deletedSomething = true
				AudioManager.play("clic",1,0,1.5)
		if deletedSomething:
			unhighlightAll()
			await get_tree().create_timer(.1).timeout
			GameManager.endDeletePhase()
