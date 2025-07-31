extends KURO_Component

@export var Violet: Node
@export var Kuro: Node
@export var Tab5: Node

func apply(slot: String, name_: String, scene: Node):
	print("[ReplaySystem/character_loaded] Ok")
	sg.buffer.append({
		"type" = "character_loaded",
		"time" = Globals.get_global_timer(),
		"slot" = slot,
		"name" = name_
	})
	match name_:
		"Violet": Violet.apply(slot, name_, scene)
		"Kuro": Kuro.apply(slot, name_, scene)
		"Tab5": Tab5.apply(slot, name_, scene)
		_: push_error("Unregognized character")
