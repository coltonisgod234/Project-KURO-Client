extends KURO_Component

@export var root: String
func set_root(root_path):
	self.root = root_path

func create(title: String, file: String, root: String):
	var diffheader = Scenes.SongSelectDifficultyHeader.instantiate()
	diffheader.title = title
	diffheader.file = file
	diffheader.root = root

	var metadata_string = "%s" % [diffheader]
	diffheader.export_name = metadata_string
	self.add_child(diffheader)
	diffheader.print_tree_pretty()
	print("[diffscontainer.gd] created a diff %s" % [metadata_string])
	return diffheader


func kuro_init():
	# this is how the diffscontainer knows when the chartcontainer button is pressed
	Resources.SongSelectChartPanelButtonGroup.pressed.connect(_on_changed)

func reset():
	for child in get_children():
		child.queue_free()

func update_list(file_list: Array):
	reset()
	for filepath in file_list:  # Same frame as previous call (we think), might trigger slight pause
		var json = MapParser.load_map(filepath)
		var title = MapParser.parse_map_diffname(json)
		self.create(title, filepath, root)

func _on_changed(btn) -> void:
	var selected_chart = Resources.SongSelectChartPanelButtonGroup.get_pressed_button()
	self.root = btn.root
	if selected_chart == null: return
	
	var file_list = selected_chart.diffs
	if file_list == null: return

	print(file_list)
	update_list(file_list)
