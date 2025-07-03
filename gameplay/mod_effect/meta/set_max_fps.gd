extends KURO_Effect
class_name EffectChangeMaxFPS

@export var value: float
func apply():
	print("[set_max_fps.gd] Maximum FPS set to %s" % value)
	Engine.max_fps = value
	print("[set_max_fps.gd] Confirm %s" % Engine.max_fps)
