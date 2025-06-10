extends KURO_Component
class_name KURO_CharacterTextureIndicator

@export var property_name: String
@export var check: Node
@export var check_constantly: bool
func kuro_init():
	await self.wait_till_init(check)
	update()

func update():
	if check == null:
		return

	self.texture = check.get(property_name)
	#print(self.value)

func _process(_delta):
	if check_constantly == true:
		update()
