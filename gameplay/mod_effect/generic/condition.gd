extends KURO_Effect
class_name EffectCondition

@export var on_true: Node  # KURO_EffectExecutor
@export var on_false: Node
@export var condition_expression: String
@export var check_attribute: String
@export var check: Node
@export var on_true_attr: String = "apply_in_succession"
@export var on_false_attr: String = "apply_in_succession"

func apply():
	var data = check.get(check_attribute)
	var x = Expression.new()
	x.parse(condition_expression, ["check", "self", "got"])
	var result = x.execute([check, self, data])

	var node = on_true if result else on_false
	var type = on_true_attr if result else on_false_attr
	print(node, type)
	if node.has_method("apply"):
		var fn = Callable(node, type)
		return await fn.call()
	else:
		return "wtf no apply method"
