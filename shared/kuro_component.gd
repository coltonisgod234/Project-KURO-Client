extends Node
class_name KURO_Component

signal component_ready(component, globals_export_name)
@export var globals_export_name := ""
var initalized_yet := false

func kuro_initialize():
	pass

func _ready():
	print("Exporting to %s" % globals_export_name)
	kuro_initialize()
	self.component_ready.emit()
	initalized_yet = true
