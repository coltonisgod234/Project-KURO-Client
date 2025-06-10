extends KURO_Effect

@export var text: String
enum LogTypes {
	CONSOLE,
	WARNING,
	ERROR,
	CRASH,
	QUIT
}
@export var to: LogTypes
@export_category("QUIT-only")
@export var return_code: int

func apply():
	match to:
		LogTypes.CONSOLE:
			print(text)
		LogTypes.WARNING:
			push_warning(text)
		LogTypes.ERROR:
			push_error(text)
		LogTypes.CRASH:
			OS.crash(text)
		LogTypes.QUIT:
			get_tree().quit(return_code)
