extends KURO_Component
class_name KURO_Effect

@export var HumanFriendlyName: String
@export var apply_on_load: bool = false

func kuro_init():
	if apply_on_load:
		await apply()

func apply():
	return
