extends KURO_Component

func fade_away():
	self.s_wait_for_component("AnimationPlayer").play("fade_away")
	Globals.set_all_process(self, false, true)

func come_back():
	self.s_wait_for_component("AnimationPlayer").play("fade_in")
	Globals.set_all_process(self, true, true)

func start(file: String):
	var game = Scenes.Main.instantiate()
	game.map = MapParser.load_map(file)
	game.map_timings = MapParser.parse_map_notes(game.map)
	game.map_song = MapParser.parse_map_songfile(game.map)
	game.map_num_keys = MapParser.parse_map_num_lanes(game.map)
	game.map_length = MapParser.parse_map_length_usec(game.map)
	game.position = Vector2(0.0, 0.0)
	print("\n\n\nMAIN SCENE READY. It'll either crash horribly or work completely fine.\n\n\n")
	Globals.reset_global_timer()  # So main doesn't FREAK OUT

	fade_away()
	get_tree().current_scene.hide_all_ui()
	get_tree().current_scene.add_child(game)
	await game.apply()

	print("Ok")
	come_back()
	# Do stuff that we want with game
	get_tree().current_scene.remove_child(game)
	get_tree().current_scene.show_all_ui()

func _on_start_button_pressed() -> void:
	var btn = Resources.SongSelectDifficultyPanelButtonGroup.get_pressed_button()
	if btn == null: return
	
	start(btn.file)

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
		diffs
	)

func add_charts_from_folder(path: String, resurs: bool, chart_conf="chart.json"):
	for dir in DirAccess.get_directories_at(path):
		dir = path.path_join(dir)
		print("[SongSelect] Processing directory %s" % [dir])
		add_chart_from_folder(dir, chart_conf)

func kuro_init():
	#add_chart_from_folder("res://testdata/test_song")
	add_charts_from_folder("res://testdata", false)
