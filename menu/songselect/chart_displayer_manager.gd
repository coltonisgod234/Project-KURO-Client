extends KURO_Component

var button_group := ButtonGroup.new()
var last_diffcontainer: Node

func time_convert(time_in_sec):
	var seconds = time_in_sec % 60
	var minutes = (time_in_sec / 60) % 60
	var hours = (time_in_sec / 60) / 60
	return "%02d:%02d:%02d" % [hours, minutes, seconds]

func create(title, artist, charter, length_secs, diffs, bpm):
	var new_displayer = Scenes.ChartDisplayer.instantiate()
	var map = new_displayer.map
	map.title = title
	map.artist = artist
	map.mapper = charter
	map.length = time_convert(length_secs)
	map.length_secs = length_secs
	map.diffcount = len(diffs)
	for diff in diffs.values():
		var new_diff = new_displayer.diffcontainer.create(
			diff["file"],
			diff["name"]
		)
		new_diff.btn.pressed.connect(
			_on_diff_clicked.bind(
				new_diff.btn,
				new_displayer
			)
		)
		new_displayer.diffcontainer.add_child(new_diff)

	map.avgbpm = bpm
	map.btn.toggle_mode = true
	map.btn.button_group = button_group
	map.btn.pressed.connect(
		_on_button_clicked.bind(
			map.btn,
			new_displayer
		)
	)
	new_displayer.diffcontainer.hide()
	self.add_child(new_displayer)

func kuro_init():
	print("\n\n\n\nplease wait as beatmaps load.")
	for i in range(20):
		create(
			"あの世行きのバスに乗ってさらば。",
			"ツユ",
			"Artemis",
			180,
			{
				0: {
					"name": "my diff 1",
					"file": "res://testdata/testmap.json"
				},
				1: {
					"name": "my diff 2",
					"file": "res://testdata/testmap.json"
				}
			},
			140
		)

	create(
		"Lost Umbrella",
		"Inabakumori",
		"Artemis",
		180,
		{
			0: {
				"name": "my diff 1",
				"file": "res://testdata/testmap.json"
			},
			1: {
				"name": "my diff 2",
				"file": "res://testdata/testmap.json"
			}
		},
		140
	)

func _on_button_clicked(btn, chartdisplayer):
	print(btn, chartdisplayer)
	var diffcontainer = chartdisplayer.diffcontainer
	print(diffcontainer)
	if last_diffcontainer == null:
		print("FUCK")
		last_diffcontainer = diffcontainer
		return
	
	print("yay")
	last_diffcontainer.hide()
	diffcontainer.show()
	last_diffcontainer = diffcontainer

func _on_diff_clicked(btn, chartdisplayer):
	print(btn, chartdisplayer)
