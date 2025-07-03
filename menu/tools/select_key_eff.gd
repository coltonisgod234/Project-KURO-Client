extends KURO_Effect
class_name EffectSelectKey

signal key_pressed(keycode, key_name)

@export var cancel_key: Key = Key.KEY_ESCAPE
@export var cancel_text: String = "Unbound"

func _input(event):
	if event is InputEventKey:
		if event.keycode == cancel_key:
			key_pressed.emit(Key.KEY_NONE, cancel_text)
		else:
			key_pressed.emit(event.keycode, event.key_label)


func apply():  # async
	# Godot doesn't support unpacking via await
	var got = await key_pressed
	return got
