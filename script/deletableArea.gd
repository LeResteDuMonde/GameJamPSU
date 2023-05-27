extends Area2D

@onready var object = get_node("../")
var isSelected = false

func _ready():
	area_entered.connect(onAreaEntered)
	area_exited.connect(onAreaExited)
	
func isCursor(area):
	return area.get_node("../").name == "Cursor"
	
func onAreaEntered(area):
	if isCursor(area) && GameManager.isDeletePhase:
		for g in object.get_groups():
			if g != "_physics_process":
				get_tree().call_group(g, "highlight", g)
		isSelected = true

func onAreaExited(area):
	if isCursor(area) && GameManager.isDeletePhase:
		for g in object.get_groups():
			if g != "_physics_process":
				get_tree().call_group(g, "unhighlight", g)
		isSelected = false

var lastClick = 0
func _input(event):
	var deletedSomething = false
	if event.is_action_released("click") && isSelected && GameManager.isDeletePhase:
		for g in object.get_groups():
			if g != "_physics_process":
				print_debug("groupe %s is called to be deleted" % g)
				get_tree().call_group(g, "delete",g)
				deletedSomething = true
				
	if deletedSomething:
		#GameManager.switchToPlayPhase()
		lastClick = Time.get_ticks_msec()      
		GameManager.displayIntersticeScreen(GameManager.currPlayer)

