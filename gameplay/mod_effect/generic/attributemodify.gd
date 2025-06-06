extends KURO_Effect

@export var node: Node
@export var attribute_name: String
enum Ops {
	ADD,
	SUBTRACT,
	MULTIPLY,
	RANDOMIZE_INT,
	RANDOMIZE_FLOAT
}
@export var operation: Ops
@export var b0: float
@export var b1: float
@export var b_operation: Ops

func preform_op(a, b, op):
	match op:
		Ops.ADD:
			a += b
		Ops.SUBTRACT:
			a -= b
		Ops.MULTIPLY:
			a *= b
		Ops.RANDOMIZE_INT:
			a = randi_range(a, b)
		Ops.RANDOMIZE_FLOAT:
			a = randf_range(a, b)
	
	return a

func apply():
	node.set(
		attribute_name,
		preform_op(
			node.get(attribute_name),
			preform_op(
				b0,
				b1,
				b_operation
			),
			operation
		)
	)
