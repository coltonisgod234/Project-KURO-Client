extends KURO_Component
class_name KURO_CharacterTextIndicator

@export var fstring: String
@export var property_name: String
@export var check: Node
@export var constantly_check := true
enum OperationMode {
	ATTIRBUTE,
	FUNCTION
}
@export var operation_mode: OperationMode

func kuro_init():
	await self.wait_till_init(check)
	update()

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

	if value is String:
		if value == "":
			randomize()
			return
	
	self.text = fstring % [value]

func _process(delta):
	if constantly_check:
		update()
