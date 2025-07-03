extends RichTextEffect
class_name AsahiRed

var bbcode = "as"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	match char_fx.env.get("type"):
		"selected":
			char_fx.color = Color("#ff3845")
		_:  # or "standard"
			char_fx.color = Color("#ff6159")  # selected = Color("#ff3845")
	return true
