extends KURO_Component

func start(file: String):
	var game = Scenes.Main.instantiate()
	game.map = MapParser.load_map(file)
	game.map_timings = MapParser.parse_map_notes(game.map)
	game.map_song = MapParser.parse_map_songfile(game.map)
	game.map_num_keys = MapParser.parse_map_num_lanes(game.map)
	game.position = Vector2(0.0, 0.0)
	print("\n\n\nMAIN SCENE READY. It'll either crash horribly or work completely fine.\n\n\n")
	self.s_wait_for_component("AnimationPlayer").play("fade_away")
	get_tree().current_scene.add_child(game)

	print("Ok")

func _on_start_button_pressed() -> void:
	var btn = Resources.SongSelectDifficultyPanelButtonGroup.get_pressed_button()
	if btn == null: return
	
	start(btn.file)
