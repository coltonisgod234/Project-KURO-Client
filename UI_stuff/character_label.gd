extends KURO_Component
class_name KURO_CharacterTextIndicator

@export var fstring: String
@export var property_name: String
@export var check: Node
func kuro_init():
	await self.wait_till_init(check)

func _process(delta):
	if check == null:
		return
	
	var value = check.get(property_name)
	if value == "":
		randomize()
		return

	self.text = fstring % [value]
	#print(self.value)
