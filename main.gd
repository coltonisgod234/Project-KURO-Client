extends Node2D
var map = MapParser.load_map("res://testdata/testmap.json")
var map_timings = MapParser.parse_map_notes(map)
var map_song = MapParser.parse_map_songfile(map)
var map_num_keys = MapParser.parse_map_num_lanes(map)

var character_manager = null
func init_CharacterManager():
	print("[Main] Initalizing CharacterManager...")
	character_manager = Scenes.CharacterManager.instantiate()
	self.add_child(character_manager)
	character_manager.load_character(Scenes.CharacterViolet)

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
	
	self.add_child(lanemgr)

var songplayer = null
func init_SongPlayer():
	print("[Main] Initalizing SongPlayer...")
	songplayer = Scenes.SongPlayer.instantiate()
	self.add_child(songplayer)
	songplayer.start_song(map_song)

func _ready():
	print("[Main] Parsed map: %s | %s | audiofile is %s | %s keys" % [map, map_timings, map_song, map_num_keys])
	init_LaneManager()
	init_SongPlayer()
	init_HUD()
	init_CharacterManager()
