extends KURO_Component
class_name KURO_CharacterFillIndicator

@export var property_name: String
@export var check: Node
enum OperationMode {
	ATTRIBUTE,
	FUNCTION,
}
@export var operation_mode: OperationMode

func kuro_init():
	await self.wait_till_init(check)

func _process(_delta):
	if check == null:
		return

	match operation_mode:
		OperationMode.ATTRIBUTE:
			self.value = check.get(property_name)
		OperationMode.FUNCTION:
			var fn = Callable(check, property_name)
			var got = fn.call()
			if got is not int:
				return
			
			self.value = got
		_:
			Globals.crash("Invalid operation mode for attr_bar")
	#print(self.value)
