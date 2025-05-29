extends Node
class_name KURO_Component

@export var sg: Node

const YOURE_NOT_PART_OF_ONE = null

func wait_till_init(component):
	print("[%s] (BASE) Waiting for initialization: %s" % [self.name, component])
	while component == null:
		await self.get_tree().process_frame
	
	return component

func wait_for_component(component_name, relative_to=null):
	if relative_to == null: relative_to = self

	print("[%s] (BASE) Waiting for component %s ON %s" % [self.name, component_name, relative_to.name])
	while component_name not in relative_to.exports:
		await get_tree().process_frame
	return self.exports.get(component_name)

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

func kuro_init():
	pass

func _ready():
	if export_under == null:
		Globals.ExportUnder(Globals, self, export_name)
	else:
		Globals.ExportUnder(export_under, self, export_name)

	self.kuro_init()
	self.component_ready.emit(self, export_name)
	initalized_yet = true
