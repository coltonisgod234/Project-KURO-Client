extends KURO_Component

var last_diffcontainer: Node
var button_group := ButtonGroup.new()

func time_convert(time_in_sec):
	var seconds = time_in_sec % 60
	var minutes = (time_in_sec / 60) % 60
	var hours = (time_in_sec / 60) / 60
	return "%02d:%02d:%02d" % [hours, minutes, seconds]

func create(title, artist, charter, length_secs, diffcount, bpm):
	var new_displayer = Scenes.ChartDisplayer.instantiate()
	var map = new_displayer.map
	map.title = title
	map.artist = artist
	map.mapper = charter
	map.length = time_convert(length_secs)
	map.length_secs = length_secs
	map.diffcount = diffcount
	map.avgbpm = bpm
	map.btn.toggle_mode = true
	map.btn.button_group = button_group
	new_displayer.button_pressed.connect(_on_button_clicked)
	self.add_child(new_displayer)

func kuro_init():
	create(
		"あの世行きのバスに乗ってさらば。",
		"ツユ",
		"Artemis",
		180,
		7,
		140
	)

	create(
		"Lost Umbrella",
		"Inabakumori",
		"Artemis",
		180,
		7,
		140
	)

func _on_button_clicked(btn, chartdisplayer):
	#print(btn, chartdisplayer)
	var diffcontainer = chartdisplayer.diffcontainer
	print(diffcontainer)
	if btn == button_group.get_pressed_button():
		if last_diffcontainer == null:
			print("FUCK")
			last_diffcontainer = diffcontainer
			return
		
		print("yay")

		last_diffcontainer.hide()
		diffcontainer.show()
		last_diffcontainer = diffcontainer
