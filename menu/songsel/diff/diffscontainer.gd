extends KURO_Component

func create(title: String, file: String):
	var diffheader = Scenes.SongSelectDifficultyHeader.instantiate()
	diffheader.title = title
	diffheader.file = file

	var metadata_string = "%s" % [diffheader]
	diffheader.export_name = metadata_string
	self.add_child(diffheader)
	return diffheader

func reset():
	for child in get_children():
		child.queue_free()

func kuro_init():
	Resources.SongSelectChartPanelButtonGroup.pressed.connect(_on_changed)
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)

func update_list(file_list: Array):
	reset()
	for filepath in file_list:
		var json = MapParser.load_map(filepath)
		var title = MapParser.parse_map_diffname(json)
		self.create(title, filepath)

func _on_changed(btn) -> void:
	var selected_chart = Resources.SongSelectChartPanelButtonGroup.get_pressed_button()
	if selected_chart == null: return
	
	var file_list = selected_chart.diffs
	if file_list == null: return

	update_list(file_list)
