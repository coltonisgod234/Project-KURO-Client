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
		print(i)
		var char = load_characters[i]
		character_manager.load_character(char, i)

var hud = null
func init_HUD():
	print("[Main] Initalizing HUD...")
	hud = Scenes.HUD.instantiate()
	self.add_child(hud)

var lanemgr = null
func init_LaneManager():
	print("[Main] Initalizing LaneManager...")
	lanemgr = Scenes.LaneManager.instantiate()
	for i in range(map_num_keys):
		lanemgr.spawn_lane(i, map_timings, 48, songplayer)
	
	lanemgr.map_len_usec = map_length
	self.add_child(lanemgr)

var songplayer = null
func init_SongPlayer():
	print("[Main] Initalizing SongPlayer...")
	songplayer = Scenes.SongPlayer.instantiate()
	self.add_child(songplayer)

func apply():
	Engine.max_fps = 0
	randomize()
	print("[Main] Got map data: %s | %s | audiofile is %s | #%s keys" % [map, map_timings, map_song, map_num_keys])
	init_SongPlayer()
	init_LaneManager()
	init_HUD()
	init_CharacterManager()
	songplayer.start_song(map_song)
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

	await lanemgr.map_complete
	$AnimationPlayer.play("fade_away")
	await $AnimationPlayer.animation_finished
