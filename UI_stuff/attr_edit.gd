extends KURO_Component
class_name KURO_MenuEditIndicator

@export_category("set attribute")
@export var check: Node
@export var set_attribute: String
@export var get_attribute: String
@export var extended_script: Script
@export_category("get")
@export var self_get_attribute: String
@export var self_set_attribute: String

func _process(_delta):
	if check == null:
		return

	check.set(set_attribute, self.get(get_attribute))
	self.set(self_set_attribute, check.get(self_get_attribute))
