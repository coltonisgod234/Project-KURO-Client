extends KURO_Component
class_name KURO_CharacterTextIndicator

@export var property_name: String
@export var check: Node
@export var constantly_check := true
enum OperationMode {
	ATTIRBUTE,
	FUNCTION,
	EXPRESSION
}
@export var operation_mode: OperationMode
@export_category("FUNCTION mode only")
@export_category("ATTRIBUTE mode only")
@export var fstring: String
@export_category("EXPRESSION mode only")
#@export var component_includes: Dictionary[String, String]

func kuro_init():
	await self.wait_till_init(check)
	update()

func evaluate_complex_argument(arg):
	var x = Expression.new()
	x.parse(arg)
	return x.execute([])

func update():
	if check == null:
		return
	
	var value
	match operation_mode:
		OperationMode.ATTIRBUTE:
			value = check.get(property_name)
		OperationMode.FUNCTION:
			var fn = Callable(check, property_name)
			value = fn.call()
		OperationMode.EXPRESSION:
			var x = Expression.new()
			#TODO: component_includes
			x.parse(property_name)
			x.execute()

	if value is String:
		if value == "":
			randomize()
			return
	
	self.text = fstring % [value]

func _process(_delta):
	if constantly_check:
		update()
