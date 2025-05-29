extends KURO_Component
class_name KURO_CharacterFillIndicator

@export var property_name: String
@export var check: Node
func kuro_init():
	await self.wait_till_init(check)

func _process(delta):
	self.value = check.get(property_name)
	#print(self.value)
