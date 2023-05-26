extends Area2D

@onready var object = get_node("../")
var isSelected = false

func _ready():
	area_entered.connect(onAreaEntered)
	area_exited.connect(onAreaExited)
	
func isCursor(area):
	return area.get_node("../").name == "Cursor"
	
func onAreaEntered(area):
	if isCursor(area):
		for g in object.get_groups():
			print(g)
			get_tree().call_group(g, "highlight")
		isSelected = true

func onAreaExited(area):
	if isCursor(area):
		for g in object.get_groups():
			get_tree().call_group(g, "unhighlight")
		isSelected = false

func _input(event):
	if event.is_action_released("click") && isSelected:
		print("click")
		for g in object.get_groups():
			get_tree().call_group(g, "delete")
		GameManager.switchToPlayPhase()

