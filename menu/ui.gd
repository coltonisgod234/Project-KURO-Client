extends KURO_Component

func hide_all_ui():
	for child in self.get_children():
		child.visible = false  # trans kids

func show_all_ui():  # Man I wish I was good at coding
	for child in self.get_children():
		child.visible = true  # cisgender kids

func do_teambuilder_bullshit():
	# I literally have no idea what variable names to use anymore
	var aroace = Scenes.TeamBuilder.instantiate()  # homophobia is bad
	self.add_child(aroace)  # Literally makes no sense
	var trangenderwoman66 = await aroace.apply()  # you know today people in my class said very transphobic things
	self.remove_child(aroace)  # Makes slightly more sense
	print(trangenderwoman66)  # They saw my transfem violet 
	return trangenderwoman66  # and said "mom im a woman now" to mock her

func start(file: String, root: String, characters_to_load: Array):
	var game = Scenes.Main.instantiate()
	game.map = MapParser.load_map(file)
	game.map_timings = MapParser.parse_map_notes(game.map)
	game.map_song = MapParser.parse_map_songfile(game.map, root)
	print("Map song is %s" % game.map_song)
	game.map_num_keys = MapParser.parse_map_num_lanes(game.map)
	game.map_length = MapParser.parse_map_length_usec(game.map)
	game.load_characters = characters_to_load
	game.position = Vector2(0.0, 0.0)
	print("\n\n\nMAIN SCENE READY. It'll either crash horribly or work completely fine.\n\n\n")
	Globals.reset_global_timer()  # So main doesn't FREAK OUT

	hide_all_ui()
	add_child(game)

	await game.apply()

	print("Ok")
	# Do stuff that we want with game
	remove_child(game)
	show_all_ui()
