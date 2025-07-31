extends Label

@export var attribute: String
@export var fstring: String
@export var hide_text: bool = true
signal hide_text_changed(current: bool)

func _process(_delta) -> void:
	var val = Resources.get(attribute)
	if val == null:
		return

	if hide_text:
		val = "*".repeat(val.length())

	self.text = fstring % [val]

func show_hide():
	hide_text = !hide_text
	hide_text_changed.emit(hide_text)

func set_enable(enable: bool) -> void:
	hide_text = enable
