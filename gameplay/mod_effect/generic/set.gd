extends KURO_Effect
class_name EffectSetStringAttribute

@export var node: Node
@export var attribute: String
@export var new_value: String

func apply():
	node.set(attribute, new_value)
