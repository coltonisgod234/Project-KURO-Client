extends KURO_Component

@export var state_changed: Node
@export var life_changed: Node
@export var motivation_changed: Node

func apply(_slot: String, _name: String, scene: Node):
	print("[ReplaySystem/CharacterViolet] Ok")
	scene.state_changed.connect(state_changed.apply)
	scene.life_changed.connect(life_changed.apply)
	scene.motivation_changed.connect(motivation_changed.apply)
