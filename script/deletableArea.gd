extends Area2D

@onready var object = get_node("../")
var isSelected = false

func _ready():
	area_entered.connect(onAreaEntered)
	area_exited.connect(onAreaExited)
	
func isCursor(area):
	return area.get_node("../").name == "Cursor"
	
func onAreaEntered(area):
	
	#if (object.name=="oxigene"):
	#	print_debug("area entered")
	if isCursor(area) && GameManager.isDeletePhase:
		for g in object.get_groups():
			get_tree().call_group(g, "highlight")
		isSelected = true

func onAreaExited(area):
	if isCursor(area) && GameManager.isDeletePhase:
		for g in object.get_groups():
			get_tree().call_group(g, "unhighlight")
		isSelected = false

func _input(event):
	#if (object.name=="oxigene"):
	#	print_debug("input %s, %s" %[object.name,isSelected])
		
	if event.is_action_released("click") && isSelected && GameManager.isDeletePhase:
	#	print_debug("click")
		for g in object.get_groups():
	#		print_debug("click groupe %s"%g)
	#		if g != "_physics_process":
				print_debug("groupe %s is called to be deleted" % g)
				get_tree().call_group(g, "delete",g)
		GameManager.switchToPlayPhase()

