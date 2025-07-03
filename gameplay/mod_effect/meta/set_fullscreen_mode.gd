extends KURO_Effect
class_name EffectSetFullscreenMode

@export var value: DisplayServer.WindowMode
func apply():
	DisplayServer.window_set_mode(value)
