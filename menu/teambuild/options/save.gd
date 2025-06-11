extends KURO_Component

@export var preset_name: String
@export var preset_directory: String
@export var component_buttons: Node

func _on_pressed() -> void:
	$FileDialog.visible = true
	var file = await $FileDialog.file_selected
	save(file)

func save(full_path):
	var file = FileAccess.open(full_path, FileAccess.WRITE)
	file.store_var(component_buttons.selection)
	file.close()
	return
