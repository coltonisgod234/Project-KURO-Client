extends KURO_Component

func fade_away():
	var player = self.s_wait_for_component("AnimationPlayer")
	player.play("fade_away")
	await player.animation_finished
	#Globals.set_all_process(self, false, true)

func come_back():
	var player = self.s_wait_for_component("AnimationPlayer")
	player.play("fade_in")
	await player.animation_finished
	#Globals.set_all_process(self, true, true)

func parse_character_shit(selection):
	# DO A BUNCH OF REALLY DUMB SHIT
	var characters = []  # I have no bitches and dont want any
	for i in selection:
		var character = selection.get(i)
		if character == null:
			push_error("aaaaaaaaa")
			continue

		var name = character.get("character_name")
		print(character, name, Scenes.CharacterList.get(name))  # debug
		characters.append(
			Scenes.CharacterList.get(name)
		)
	
	return characters

func _on_start_button_pressed() -> void:
	var btn = Resources.SongSelectDifficultyPanelButtonGroup.get_pressed_button()
	if btn == null: return
	
	var ui = Globals.s_wait_for_component("Ui")
	var selection = await ui.do_teambuilder_bullshit()
	print("You selected some shit!")
	print(selection)
	var shit = parse_character_shit(selection)
	print("You parsed some shit!")
	print(shit)
	ui.start(
		btn.file,
		btn.root,
		shit
	)

func add_chart_from_folder(path: String, chart_conf="chart.json"):
	var full_path = path.path_join(chart_conf)
	var charts = self.s_wait_for_component("Charts")
	var json = ChartMetaParser.load_map(full_path)

	var title = ChartMetaParser.parse_chart_title(json)
	var artist = ChartMetaParser.parse_chart_artist(json)
	var length = ChartMetaParser.parse_chart_length(json)
	var charter = ChartMetaParser.parse_chart_charter(json)
	var BPM = ChartMetaParser.parse_chart_BPM(json)
	var diffs = ChartMetaParser.parse_chart_diffs(json, path)
	charts.create(
		title,
		artist,
		length,
		charter,
		BPM,
		diffs,
		path
	)

func add_charts_from_folder(path: String, _resurs: bool, chart_conf="chart.json"):
	for dir in DirAccess.get_directories_at(path):
		dir = path.path_join(dir)
		print("[SongSelect] Processing directory %s" % [dir])
		add_chart_from_folder(dir, chart_conf)

func kuro_init():
	#add_chart_from_folder("res://testdata/test_song")
	print("[SongSelect] Your user:// folder is located in: %s" % OS.get_user_data_dir())
	add_charts_from_folder("user://songs", false)

func show_ui(scene):
	await fade_away()
	var ui = Globals.s_wait_for_component("Ui")
	ui.hide_all_ui()

	var interface = scene.instantiate()
	ui.add_child(interface)
	await interface.apply()
	interface.queue_free()
	await come_back()

	ui.show_all_ui()

func _on_settings_btn_press() -> void:
	await show_ui(Scenes.SettingsUI)

func _on_open_gacha_pressed() -> void:
	await show_ui(Scenes.GachaUI)
