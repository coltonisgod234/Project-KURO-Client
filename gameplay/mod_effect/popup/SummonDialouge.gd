extends KURO_Effect

@export var rich_text: String
@export var character_texture: Texture
@export var character_name: String

enum PositionMode {
	EXPLICIT,
	TOP_LEFT,
	TOP_RIGHT,
	MIDDLE_LEFT,
	CENTRE,
	MIDDLE_RIGHT,
	BOTTOM_LEFT,
	BOTTOM_RIGHT
}

func resolve_position_mode(mode: PositionMode, pos: Vector2) -> Vector2:
	var viewport_size = get_viewport().get_visible_rect().size
	print("[resolve_position_mode] Viewport is %s X %s px" % [viewport_size.x, viewport_size.y])
	print("[resolve_position_mode] Halved, this is %s X %s px" % [viewport_size.x/2.0, viewport_size.y/2.0])
	match mode:
		PositionMode.EXPLICIT:
			return pos
		PositionMode.CENTRE:
			return Vector2(viewport_size.x/2.0, viewport_size.y/2.0)
		_:
			return Vector2i(0, 0)

@export var position_preset: PositionMode
@export var position: Vector2i

func apply():
	var dialouge = Scenes.CharacterDialougeBox.instantiate()
	dialouge.text = rich_text
	dialouge.texture = character_texture
	dialouge.title = character_name
	dialouge.position = resolve_position_mode(position_preset, position)

	self.add_child(dialouge)
	await apply_in_succession(dialouge)
	dialouge.queue_free()
	return

var buttons = []
func apply_in_succession(dialouge):
	for child in self.get_children():
		if not child.has_method("apply"): return
		print("[SummonDialouge.gd] set up child %s" % child)
		child.dialouge = dialouge
		await child.apply()
  
