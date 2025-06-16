extends KURO_Component

func create(
	title: String,
	artist: String,
	length_sec: int,
	charter: String,
	BPM: int,
	diff_files: Array,
	map_root: String
):
	var chartheader = Scenes.SongSelectChartHeader.instantiate()
	chartheader.title = title
	chartheader.artist = artist
	chartheader.length_sec = length_sec
	chartheader.charter = charter
	chartheader.BPM = BPM
	chartheader.diffs = diff_files
	chartheader.root = map_root

	chartheader.toggle_mode = true
	chartheader.button_group = Resources.SongSelectChartPanelButtonGroup

	var metadata_string = "%s;%s;%s;%s;%s;%s" % [title, artist, length_sec, charter, BPM, diff_files]
	chartheader.export_name = metadata_string
	self.add_child(chartheader)
