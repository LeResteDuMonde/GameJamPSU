extends Node2D

func highlight(g):
	get_node("Highlight").visible = true
	
func unhighlight(g):
	get_node("Highlight").visible = false

func delete(g):
	print_debug("delete")
#	AudioManager.play("clic")
	queue_free()
