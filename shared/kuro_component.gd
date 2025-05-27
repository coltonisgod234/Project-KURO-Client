extends Node
class_name KURO_Component

signal component_ready(component, globals_export_name)
@export var globals_export_name := ""
var initalized_yet := false

func kuro_init():
	pass

func _ready():
	print("[KURO_Component] Exporting to %s" % globals_export_name)
	Globals.exports[globals_export_name] = self
	self.kuro_init()
	self.component_ready.emit(self, globals_export_name)
	initalized_yet = true
