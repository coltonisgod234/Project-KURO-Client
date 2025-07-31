extends Node2D
var map
var map_timings
var map_song
var map_num_keys
var map_length

var character_manager = null
var load_characters: Array
func init_CharacterManager():
	print("[Main] Initalizing CharacterManager...")
	character_manager = Scenes.CharacterManager.instantiate()
	character_manager.position.x = 220
	self.add_child(character_manager)
	for i in range(len(load_characters)):
		var char = load_characters.get(i)
		if char == null:
			print("[Main] Skipping character... %s in slot %s" % [char, i])
			continue

		print("[Main] Loading character... %s into slot %s" % [char, i])
		character_manager.load_character(char, i)
	await character_manager.component_ready

var hud = null
func init_HUD():
	print("[Main] Initalizing HUD...")
	hud = Scenes.HUD.instantiate()
	self.add_child(hud)
	#await replaysystem.component_ready

var lanemgr = null
func init_LaneManager():
	print("[Main] Initalizing LaneManager...")
	lanemgr = Scenes.LaneManager.instantiate()
	for i in range(map_num_keys):
		lanemgr.spawn_lane(i, map_timings, 48, songplayer)
	
	lanemgr.map_len_usec = map_length
	self.add_child(lanemgr)
	await lanemgr.component_ready

var songplayer = null
func init_SongPlayer():
	print("[Main] Initalizing SongPlayer...")
	songplayer = Scenes.SongPlayer.instantiate()
	self.add_child(songplayer)
	await songplayer.component_ready

var replaysystem = null
func init_ReplaySystem():
	print("[Main] Initializing ReplaySystem....")
	replaysystem = Scenes.ReplaySystem.instantiate()
	self.add_child(replaysystem)

func apply():
	randomize()
	#print("[Main] Got map data: %s | %s | audiofile is %s | #%s keys" % [map, map_timings, map_song, map_num_keys])
	
	# make a bunch of shit
	init_SongPlayer()
	init_LaneManager()
	init_HUD()
	init_CharacterManager()
	
	# not writing this
	#init_ReplaySystem()
	songplayer.start_song(map_song)
	$Enter.apply_in_succession()

	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

	await lanemgr.map_complete

	$AnimationPlayer.play("fade_away")
	await $AnimationPlayer.animation_finished
	
	# free the shit (dont leak memory thats bad)
	songplayer.queue_free()
	lanemgr.queue_free()
	hud.queue_free()
	character_manager.queue_free()

	#replaysystem.queue_free()
