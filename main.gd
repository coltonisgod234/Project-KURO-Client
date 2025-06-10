extends Node2D
var map
var map_timings
var map_song
var map_num_keys
var map_length

var character_manager = null
func init_CharacterManager():
	print("[Main] Initalizing CharacterManager...")
	character_manager = Scenes.CharacterManager.instantiate()
	self.add_child(character_manager)
	character_manager.load_character(Scenes.CharacterViolet, 1)
	character_manager.load_character(Scenes.CharacterKuro, 2)
	character_manager.load_character(Scenes.CharacterTab5, 3)

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
		lanemgr.spawn_lane(i, map_timings, 48)
	
	lanemgr.map_len_usec = map_length
	self.add_child(lanemgr)

var songplayer = null
func init_SongPlayer():
	print("[Main] Initalizing SongPlayer...")
	songplayer = Scenes.SongPlayer.instantiate()
	self.add_child(songplayer)
	songplayer.start_song(map_song)

func apply():
	Engine.max_fps = 0
	randomize()
	print("[Main] Got map data: %s | %s | audiofile is %s | #%s keys" % [map, map_timings, map_song, map_num_keys])
	init_LaneManager()
	init_SongPlayer()
	init_HUD()
	init_CharacterManager()
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

	await lanemgr.map_complete
	$AnimationPlayer.play("fade_away")
	await $AnimationPlayer.animation_finished
