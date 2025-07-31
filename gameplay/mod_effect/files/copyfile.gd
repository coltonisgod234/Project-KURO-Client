extends KURO_Effect
class_name EffectCopyFile

@export var source: String
@export var dest: String

func save_to_file(path, content):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(content)

func load_from_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return content

func apply():
	save_to_file(
		dest,
		load_from_file(source)
	)
