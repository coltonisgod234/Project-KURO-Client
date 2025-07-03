extends KURO_Effect
class_name EffectSetEngineScaleMode

@export var stretch: Window.ContentScaleStretch
@export var aspect: Window.ContentScaleAspect
@export var mode: Window.ContentScaleMode
func apply():
	var root = get_tree().root
	root.content_scale_stretch = stretch
	root.content_scale_aspect = aspect
	root.content_scale_mode = mode
