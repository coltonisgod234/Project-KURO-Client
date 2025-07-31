extends KURO_Effect
class_name EffectAppendDialougeButton

@export var dialouge: Node
@export var text: String

func apply():
	if dialouge == null:
		print("[DialougeButton.gd] No dialouge set. Nothing given, nothing done")
		return

	var _btn = await dialouge.create_button(text)
