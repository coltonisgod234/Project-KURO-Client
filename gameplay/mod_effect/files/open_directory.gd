extends KURO_Effect
class_name KURO_Effect_OpenDirectoryInShell

@export var path: String
enum Mode {
	STRING,
	EXPRESSION,
}
@export var mode: Mode

func apply_string():
	return path

func apply_expression():
	var x = Expression.new()
	x.parse(path, ["self"])
	var result = x.execute([self])
	return result

func apply() -> void:
	var value
	match mode:
		Mode.STRING: value = apply_string()
		Mode.EXPRESSION: value = apply_expression()

	OS.shell_open(value)
