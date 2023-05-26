extends Node

var main
var main_r = preload("res://scene/Main.tscn")
var root
var web 
# Called when the node enters the scene tree for the first time.
func _ready():
	if(OS.get_distribution_name() == ""): web = true
	root = get_tree().root
	main = root.get_node("Main")
