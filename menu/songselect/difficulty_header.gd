extends KURO_Component

@export var chartfile: String
@export var diffname: String
@export var btn: Node

signal diff_clicked(diffscene, btn)

func kuro_init():
	btn.pressed.connect(_on_diff_clicked)

func _on_diff_clicked():
	diff_clicked.emit(self, btn)
