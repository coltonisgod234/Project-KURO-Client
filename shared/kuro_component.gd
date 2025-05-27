extends Node
class_name KURO_Component

const YOURE_NOT_PART_OF_ONE = null

func wait_for_component(component_name):
	print("[%s] (BASE) Waiting for component" % [self.name])
	while component_name not in self.exports:
		await get_tree().process_frame
	return self.exports.get(component_name)

func get_scene_root(me_myself_and_i):
	var current = me_myself_and_i
	if me_myself_and_i.get_parent() != null:
		current = me_myself_and_i.get_parent()
	return current

func WhatIsTheRootComponent(me_myself_and_i):
	print("[%s] (BASE) Finding root component" % [self.name])
	var export = get_scene_root(me_myself_and_i)
	print("[%s] (BASE) Got %s" % [self.name, export])
	return export  # null is checkable as YOURE_NOT_PART_OF_ONE too

func ExportUnder(parent, me_myself_and_i, name=null):
	if name is not String:
		name = me_myself_and_i.name
	
	if name == "":
		name = me_myself_and_i.name
	
	print("[%s] (BASE) Exporting... %s UNDER %s AS %s" % [self.name, me_myself_and_i.name, parent.name, name])
	parent.exports.set(name, me_myself_and_i)


signal component_ready(component, globals_export_name)
@export var export_name: String
@export var export_under: Node
var exports := {}
var initalized_yet := false
var sg

func kuro_init():
	pass

func _ready():
	if export_under == null:
		Globals.ExportUnder(Globals, self, export_name)
	else:
		Globals.ExportUnder(export_under, self, export_name)

	self.sg = Globals.WhatIsTheRootComponent(self)
	self.kuro_init()
	self.component_ready.emit(self, export_name)
	initalized_yet = true
