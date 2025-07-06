extends Node
class_name KURO_Component

@export var sg: Node

const YOURE_NOT_PART_OF_ONE = null

func wait_till_init(component):
	print("[%s] (BASE) Waiting for initialization: %s" % [self.name, component])
	return component

func s_wait_for_component(component_name: String):
	return self.exports.get(component_name)   # No polling because Godot is extremely retarded

func ExportUnder(parent, me_myself_and_i, name=null):
	if name is not String:
		name = me_myself_and_i.name

	if name == "":
		name = me_myself_and_i.name
	
	if me_myself_and_i == null or parent == null:
		print("Possibly silly bug %s" % self)
		return
	
	print("[%s] (BASE) Exporting... %s UNDER %s AS %s" % [self.name, me_myself_and_i.name, parent.name, name])
	if not "exports" in parent:
		Globals.crash("kuro_component: parent has no `exports` dictionary")
		return
	parent.exports.set(name, me_myself_and_i)
	#print("Done")

signal component_ready(component, globals_export_name)
@export var export_name: String
@export var export_under: Node
enum ExportModes {
	EXPORT_CHOSEN,
	EXPORT_PARENT,
	EXPORT_ROOT,
	EXPORT_DONT
}
@export var export_mode: ExportModes
var exports := {}
var initalized_yet := false

func kuro_init():
	pass

func _ready():
	if export_under == null:
		push_warning("[%s] (%s) You might have made another silly bug, Artemis!" % [self, self.name])

	match export_mode:
		ExportModes.EXPORT_CHOSEN:
			Globals.ExportUnder(export_under, self, export_name)
		ExportModes.EXPORT_PARENT:
			Globals.ExportUnder(get_parent(), self, export_name)
		ExportModes.EXPORT_ROOT:
			Globals.ExportUnder(Globals, self, export_name)
		ExportModes.EXPORT_DONT:
			pass

	self.kuro_init()
	self.component_ready.emit(self, export_name)
	initalized_yet = true
