extends KURO_Component

func _on_pressed() -> void:
	var difficulty = Resources.SongSelectDifficultyPanelButtonGroup.get_pressed_button()
	start(difficulty.file)
