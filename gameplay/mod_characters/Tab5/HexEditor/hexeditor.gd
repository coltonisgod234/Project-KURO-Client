extends KURO_Component

@export var vboxcontainer: VBoxContainer
var attributes: Array = ["notset"]

func get_attributes_for_character(char, _cholder):
	var allowed = char.get_meta("tab5_allowed_attributes")
	return allowed

func kuro_init():
	vboxcontainer.Tab5Himself = sg
	var cmgr = Globals.s_wait_for_component("CharacterManager")
	var cholder = cmgr.s_wait_for_component("CharacterHolder")
	var character = 0
	match int(sg.export_name):
		0, 2:
			character = int(sg.export_name) + 1
		1, 3:
			character = int(sg.export_name) - 1
		_:
			print("[Tab5/HexEditor] no character")
			Globals.crash("[Tab5/HexEditor] unregognized character slot")

	var char_obj = cholder.s_wait_for_component("%s" % character)
	vboxcontainer.node = char_obj
	self.attributes = get_attributes_for_character(char_obj, cholder)
	print("[Tab5/HexEditor] Debug info, attribute = ", self.attributes)
	vboxcontainer.set_list(self.attributes)

func activate():
	$StopTimer.start()
	await $StopTimer.timeout
	return
