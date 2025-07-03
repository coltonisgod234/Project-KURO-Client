extends KURO_Effect
class_name EffectSummonDialouge

@export_multiline var rich_text: String
@export var character_texture: Texture
@export var character_name: String
@export var button_group: ButtonGroup = preload("res://dialouge/dialouge_buttongroup.tres")
@export_category("Default button")
@export var default_button_allowed: bool = true
@export var default_button: EffectAppendDialougeButton
var user_responce: BaseButton:  # Virtual attribute
	get:
		return button_group.get_pressed_button()

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

@export var position_preset: PositionMode = PositionMode.EXPLICIT
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

func apply_in_succession(dialouge):
	var children = self.get_children()
	if len(children) <= 1 and default_button_allowed:
		print("Default button\n")
		default_button.dialouge = dialouge
		await default_button.apply()
		
	for child in children:
		if not child.has_method("apply"): continue
		print("[SummonDialouge.gd] set up child %s" % child)
		child.dialouge = dialouge
		await child.apply()

	var pressed_button = await button_group.pressed
	return pressed_button
