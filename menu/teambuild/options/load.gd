extends KURO_Component

@export var preset_name: String
@export var preset_directory: String
@export var component_buttons: Node

func _on_pressed() -> void:
	$FileDialog.visible = true
	var file = await $FileDialog.file_selected
	var data = ld(file)
	component_buttons.set_selection(data)

func ld(full_path):
	var file = FileAccess.open(full_path, FileAccess.READ)
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	file.close()
	return data
