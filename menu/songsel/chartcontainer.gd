extends KURO_Component

func performance_saver(node: Node, val: bool):
	node.set_process(val)
	node.set_process_input(val)
	node.set_process_unhandled_input(val)
	node.set_process_unhandled_key_input(val)
	node.set_process_internal(val)

func create(title: String, artist: String, length_sec: int, charter: String, BPM: int, diff_files: Array[String]):
	var chartheader = Scenes.SongSelectChartHeader.instantiate()
	chartheader.title = title
	chartheader.artist = artist
	chartheader.length_sec = length_sec
	chartheader.charter = charter
	chartheader.BPM = BPM
	chartheader.diffs = diff_files
	chartheader.toggle_mode = true
	chartheader.button_group = Resources.SongSelectChartPanelButtonGroup
	#performance_saver(chartheader, true)

	var metadata_string = "%s;%s;%s;%s;%s;%s" % [title, artist, length_sec, charter, BPM, diff_files]
	chartheader.export_name = metadata_string
	self.add_child(chartheader)

func kuro_init():
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	for i in range(10):
		create(
			"Loop Spinner",
			"Inabakumori",
			216,
			"Artemis",
			172,
			["res://testdata/testmap.json", "res://testdata/testmap.json", "res://testdata/testmap.json", "res://testdata/testmap.json"]
		)
