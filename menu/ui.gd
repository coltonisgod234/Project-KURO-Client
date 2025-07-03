extends KURO_Component

var game
@export var not_ui_names: Array[String]

func kuro_init():
	start("user://songs/fuck2/0.json", "user://songs/fuck2", [Scenes.CharacterTab5, Scenes.CharacterViolet])

func hide_all_ui():
	for child in self.get_children():
		if child.name in not_ui_names:  # Skip
			continue
			
		Globals.set_all_process(child, false, true)
		child.visible = false
	
	# No exit yet

func show_all_ui():  # Man I wish I was good at coding
	for child in self.get_children():
		if child.name in not_ui_names:  # Skip
			continue

		child.visible = true
		Globals.set_all_process(child, true, true)
	
	$Enter.apply_in_succession()

func do_songselect_bullshit():
	## This code was written on the weekend after a field trip
	## I am fucking tired
	var aroace = Scenes.SongSelect.instantiate()   # I got to spent a lot of time with Dean and Alisa
	self.add_child(aroace)                         # No Alisa and I are not dating im aroace
	var transgenderwoman66 = await aroace.apply()  # Alisa and I went to Harvery's
	aroace.queue_free()                            # And then we went to the park but our class hates Alisa and they were rude
	return transgenderwoman66                      # I fucking crashed out because of how annoying they where

func do_teambuilder_bullshit():
	## I literally have no idea what variable names to use anymore
	var aroace = Scenes.TeamBuilder.instantiate()  # homophobia is bad
	self.add_child(aroace)                         # Literally makes no sense
	var trangenderwoman66 = await aroace.apply()   # you know today people in my class said very transphobic things
	aroace.queue_free()                            # This line makes slightly more sense
	print(trangenderwoman66)                       # They saw my transfem friend violet 
	return trangenderwoman66                       # and said "mom im a woman now" to mock her

func _input(event):
	if event is InputEventKey:
		if game != null:
			if event.is_action_pressed("reload"):
				var last_file = game.get_meta("sparams_file")
				var last_root = game.get_meta("sparams_root")
				var last_characters_to_load = game.get_meta("sparams_characters_to_load")
				force_stop_game()
				start(last_file, last_root, last_characters_to_load)
			elif event.is_action_pressed("close_map"):
				force_stop_game()
				show_all_ui()

func force_stop_game():
	game.queue_free()

func start(file: String, root: String, characters_to_load: Array):
	#Engine.time_scale = 0.5  # Slow down to 50% speed for testing
	game = Scenes.Main.instantiate()
	game.set_meta("sparams_file", file)
	game.set_meta("sparams_root", root)
	game.set_meta("sparams_characters_to_load", characters_to_load)
	game.map = MapParser.load_map(file)
	game.map_timings = MapParser.parse_map_notes(game.map)
	game.map_song = MapParser.parse_map_songfile(game.map, root)
	print("Map song is %s" % game.map_song)
	game.map_num_keys = MapParser.parse_map_num_lanes(game.map)
	game.map_length = MapParser.parse_map_length_usec(game.map)
	#game.map_length = 10_000_000  # debug
	game.load_characters = characters_to_load
	game.position = Vector2(0.0, 0.0)
	print("\n\n\nMAIN SCENE READY. It'll either crash horribly or work completely fine.\n\n\n")
	Globals.reset_global_timer()  # So main doesn't FREAK OUT
	hide_all_ui()
	add_child(game)

	await game.apply()

	print("Ok")
	# Do stuff that we want with game
	game.queue_free()  # memory leak fuck
	game = null
	show_all_ui()
