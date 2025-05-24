extends Node
class_name KURO_Component

@export var dependency_name := ""
@export var dependencies: Array[String] = []

var depends: Dictionary = {}

func _enter_tree():
	var sys = get_node("/root/Main/DependencySystem")
	if dependency_name != "":
		sys.register_component(dependency_name, self)

func get_required_dependencies() -> Array:
	return dependencies
