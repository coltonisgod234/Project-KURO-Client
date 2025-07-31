extends KURO_Component

@export var selected_prop_idx: int
@export var key0_corruption: float
@export var key1_corruption: float
@export var key2_corruption: float
@export var key3_corruption: float
@export var up_strength: float
@export var down_strength: float
var node: Node
var Tab5Himself: Node

func del_list():
	for child in self.get_children():
		child.queue_free()

func extend_list(dict):
	for item in dict:
		var label = Label.new()
		label.text = item
		label.set_meta("item_name", item)
		self.add_child(label)

func set_list(dict):
	del_list()
	extend_list(dict)

func reset_all_labels():
	for attribute in self.get_children():
		var n = attribute.get_meta("item_name", "?FAULT!:no_meta@hexeditor/vbc")
		attribute.text = "%s: %s" % [n, node.get(n)]

func get_selected_label():
	var attribute_lbl = self.get_child(selected_prop_idx)
	if attribute_lbl == null:
		print("[Tab5/HexEditor] Attribute label is null, attempting to fix (reset index to 0!!)")
		selected_prop_idx = 0
		return null
	
	return attribute_lbl

func boooooooring_logic():
	var attribute_lbl = get_selected_label()

	self.reset_all_labels()
	var n = attribute_lbl.get_meta("item_name", "[Tab5/HexEditor] ATTRIBUTE LABEL ITEM IS NULL.")
	attribute_lbl.text = ">>> %s: %s" % [n, node.get(n)]

func add_sub_attr_label(off):
	var attribute_lbl = get_selected_label()

	var n = attribute_lbl.get_meta("item_name")
	if n == null:
		print("[Tab5/HexEditor] ATTRIBUTE LABEL ITEM NAME IS NULL. RETURNING ERROR")
		return ERR_INVALID_DATA

	node.set(n, (node.get(n) + off))

func _input(event: InputEvent) -> void:
	var child_count = self.get_child_count()
	if Input.is_action_pressed("key0"):  # up
		selected_prop_idx = (selected_prop_idx - 1) % child_count
		if Tab5Himself.corruption < Tab5Himself.max_corruption:
			Tab5Himself.corruption += key0_corruption

	if Input.is_action_pressed("key1"):  # down
		selected_prop_idx = (selected_prop_idx + 1) % child_count
		if Tab5Himself.corruption < Tab5Himself.max_corruption:
			Tab5Himself.corruption += key1_corruption

	if Input.is_action_pressed("key2"):  # add
		if Tab5Himself.corruption < Tab5Himself.max_corruption:
			Tab5Himself.corruption += key2_corruption
		add_sub_attr_label(up_strength)

	if Input.is_action_pressed("key3"):  # sub
		if Tab5Himself.corruption < Tab5Himself.max_corruption:
			Tab5Himself.corruption += key3_corruption
		add_sub_attr_label(down_strength)

func _process(_delta):
	boooooooring_logic()
