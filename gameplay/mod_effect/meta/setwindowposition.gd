extends KURO_Effect
class_name EffectSetWindowPosition

@export var set_position: bool
@export var pos_x: int
@export var pos_y: int

@export var set_size: bool
@export var size_x: int
@export var size_y: int

func apply():
	if set_position:
		DisplayServer.window_set_position(Vector2i(pos_x,pos_y))
	if set_size:
		DisplayServer.window_set_size(Vector2i(size_x,size_y))
		
