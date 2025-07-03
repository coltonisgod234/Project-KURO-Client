extends KURO_Effect
class_name EffectChangeVSyncMode

@export var value: DisplayServer.VSyncMode
func apply():
	DisplayServer.window_set_vsync_mode(value)
