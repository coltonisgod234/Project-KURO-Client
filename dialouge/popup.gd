extends KURO_Component

@export var text: String
@export var texture: Texture
@export var title: String

@export var button_group: ButtonGroup
@export var button_container: BoxContainer

func create_button(text: String):
	var btn = Button.new()
	btn.text = text
	btn.toggle_mode = true
	btn.button_group = button_group
	button_container.add_child(btn)
	return btn
