extends KURO_Effect
class_name EffectAttributeModify

var last_result

@export var operation: Ops
@export_category("Source A")
@export var node_source_a: Node
@export var attribute_name_source_a: String
@export var literal_a: String
@export_category("Source B")
@export var node_source_b: Node
@export var attribute_name_source_b: String
@export var literal_b: String
@export_category("Destination")
@export var node_destination: Node
@export var attribute_name_destination: String
enum Ops {
	ADD,
	SUBTRACT,
	MULTIPLY,
	RANDOMIZE_INT,
	RANDOMIZE_FLOAT,
}

func perform_op(a, b, op):
	var result
	match op:
		Ops.ADD:
			result = float(a) + float(b)
		Ops.SUBTRACT:
			result = float(a) - float(b)
		Ops.MULTIPLY:
			result = float(a) * float(b)
		Ops.RANDOMIZE_INT:
			result = randi_range(float(a), float(b))
		Ops.RANDOMIZE_FLOAT:
			result = randf_range(float(a), float(b))
		_:
			Globals.crash("attributemodify: unknown operation")
	
	return result

func apply():
	var value = perform_op(
		node_source_a.get(attribute_name_source_a) if literal_a == "" else literal_a,
		node_source_b.get(attribute_name_source_b) if literal_b == "" else literal_b,
		operation
	)
	node_destination.set(
		attribute_name_destination,
		value
	)
	last_result = value
