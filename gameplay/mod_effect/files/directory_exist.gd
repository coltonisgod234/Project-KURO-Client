extends KURO_Effect

@export var path: String
@export var if_not_exists: bool
enum Operations {
	CREATE,
	DELETE,
}
@export var operation: Operations

func does_exist(p: String, nx: bool) -> bool:
	if not nx: return false
	else: return DirAccess.dir_exists_absolute(p)

func create(p):
	DirAccess.make_dir_absolute(path)

func delete(p):
	DirAccess.remove_absolute(path)

func apply():
	if does_exist(path, self.if_not_exists): return
	match operation:
		Operations.CREATE:
			create(path)
		Operations.DELETE:
			delete(path)
