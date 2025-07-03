extends KURO_Effect
class_name EffectMatch

@export var conditions: Dictionary[String, KURO_EffectExecutor]
@export var check: Node
@export var attribute: String
@export var executor_function: String = "apply_in_succession"
enum Mode {
	ATTRIBUTE,
	FUNCTION
}
@export var mode: Mode

func find_got(chk, attr, m=mode):
	match m:
		Mode.FUNCTION:
			var f = Callable(chk, attr)
			var result = f.call()
			return result
		Mode.ATTRIBUTE:
			var result = chk.get(attr)
			return result
		_:
			return null

func do_exp(exp, got, chk=check):
	var x = Expression.new()
	x.parse(exp, ["check", "got"])
	return x.execute([chk, got])

func apply():
	for exp in conditions:
		var executor = conditions.get(exp)
		var result = do_exp(exp, find_got(check, attribute))
		if result:  # if truthy
			var f = Callable(executor, executor_function)
			await f.call()
