extends KURO_Component

@export var buffer: Array
#@export var listeners: Dictionary[String, Node]

func get_listener_method(name_: String):
	#return self.listeners.get(name_).apply
	return self.get_node(name_).apply

func kuro_init():
	var lanemgr: KURO_LaneManager = Globals.s_wait_for_component("LaneManager")
	if lanemgr == null:
		push_error("lanemgr == null, ReplaySystem nonfunctional")
		return

	# ugly but I'm lazy rn
	lanemgr.note_judged.connect(get_listener_method("KURO_LaneManager!note_judged"))
	lanemgr.map_complete.connect(get_listener_method("KURO_LaneManager!map_complete"))

	var charactermgr: KURO_CharacterManager = Globals.s_wait_for_component("CharacterManager")
	if lanemgr == null:
		push_error("charactermgr == null, ReplaySystem nonfunctional")
		return

	charactermgr.character_loaded.connect(get_listener_method("KURO_CharacterManager!character_loaded"))
	charactermgr.ability_activated.connect(get_listener_method("KURO_CharacterManager!ability_activated"))
	#charactermgr.ability_returned.connect(get_listener_method("KURO_CharacterManager!ability_returned"))

	print("[ReplaySystem] OK")

func save(path: String):
	var fd = FileAccess.open(path, FileAccess.WRITE)
	var json = JSON.stringify(buffer)
	fd.store_string(json)
	fd.close()

func _input(ev: InputEvent):
	if ev is InputEventKey:
		if ev.is_action_pressed("ReplayDump"):
			print("Replay buffer shown below")
			print("=========================")
			print("")
			print(buffer)
			save("user://replay_dump.json")
