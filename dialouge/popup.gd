extends KURO_NullComponent

@export var text: String
@export var texture: Texture
@export var title: String

@export var button_group: ButtonGroup

@export var button_container: HBoxContainer

func kuro_init():
	$AnimationPlayer.play("create")
	return

func create_button(text: String):
	var btn = Button.new()
	btn.text = text
	btn.toggle_mode = true
	btn.button_group = button_group
	button_container.add_child(btn)
	return btn
