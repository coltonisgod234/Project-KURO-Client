extends KURO_Component

func show():
	self.visible = true

func hide():
	self.visible = false

signal diff_clicked(diff, btn)

func create(file: String, name: String):
	var new_diff = Scenes.DifficultyHeader.instantiate()
	new_diff.diffname = name
	new_diff.chartfile = file
	new_diff.btn.pressed.connect(
		_on_diff_clicked.bind(
			new_diff.btn
		)
	)
	return new_diff

func _on_diff_clicked(btn):
	print(btn)
