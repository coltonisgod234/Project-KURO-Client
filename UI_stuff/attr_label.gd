extends KURO_Component
class_name KURO_CharacterTextIndicator

@export var fstring: String
@export var property_name: String
@export var check: Node
@export var constantly_check := true

func kuro_init():
	await self.wait_till_init(check)
	update()

func update():
	if check == null:
		return
	
	var value = check.get(property_name)

	if value is String:
		if value == "":
			randomize()
			return
	
	self.text = fstring % [value]

func _process(delta):
	if constantly_check:
		update()
