extends KURO_Component
class_name KURO_CharacterTextIndicator

@export var property_name: String
@export var expression: String
@export var check: Node
@export var constantly_check := true
enum OperationMode {
	ATTIRBUTE,
	FUNCTION,
	EXPRESSION_FUNC,
}
@export var operation_mode: OperationMode
@export_category("FUNCTION mode only")
@export_category("ATTRIBUTE mode only")
@export var fstring: String
@export_category("EXPRESSION mode only")
#@export var component_includes: Dictionary[String, String]

func kuro_init():
	# No longer works
	#await self.wait_till_init(check)
	update()

func resolve():
	var value
	match operation_mode:
		OperationMode.ATTIRBUTE:
			value = check.get(property_name)
		OperationMode.FUNCTION:
			var fn = Callable(check, property_name)
			value = fn.call()
		OperationMode.EXPRESSION_FUNC:
			var fn = Callable(check, property_name)
			var got = fn.call()

			var x = Expression.new()
			x.parse(expression, ["n"])
			value = x.execute([got])
		_:
			Globals.crash("Invalid operation mode for attr_label")
	
	return value

func update():
	if check == null:
		return

	var value = resolve()

	if value is String:
		if value == "":
			randomize()
			return
	
	self.text = fstring % [value]

func set_txt(s: String):
	self.text = s

func _process(_delta):
	if constantly_check:
		update()
