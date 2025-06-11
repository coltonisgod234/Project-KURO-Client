extends KURO_Effect

@export var path: String
@export var data_callv_args: Array

# not used right now
enum DataTypes {
	store_8,
	store_16,
	store_32,
	store_64,
	store_buffer,
	store_csv_line,
	store_double,
	store_float,
	store_half,
	store_line,
	store_pascal_string,
	store_real,
	store_string,
	store_var
}
#@export var data_type: DataTypes
@export var method_type: String

@export var operation: FileAccess.ModeFlags = FileAccess.WRITE

func read(p):
	var file = FileAccess.open(p, operation)
	var callable = Callable(file, method_type)
	callable.callv(data_callv_args)

func write(p):
	DirAccess.remove_absolute(path)

func apply():
	pass
