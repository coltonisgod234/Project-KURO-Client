extends KURO_Effect

@export var value: int
func apply():
	Engine.max_fps = value
