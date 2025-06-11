extends KURO_Component
var map
var map_timings
var map_song
var map_num_keys
var map_length
var load_characters

var character_manager = null
func init_CharacterManager():
	print("[Main] Initalizing CharacterManager...")
	character_manager = Scenes.CharacterManager.instantiate()
	character_manager.position.x = 250.0
	print("[Main] Loading characters...")
	for i in range(len(load_characters)):
		var character = load_characters.get(i)
		print("[Main] Load %s to slot %s..." % [character, i])
		character_manager.load_character(character, i)

	self.add_child(character_manager)

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

func kuro_init():
	Engine.max_fps = 0
	randomize()
	print("[Main] Got map data: %s | %s | audiofile is %s | #%s keys" % [map, map_timings, map_song, map_num_keys])
	init_LaneManager()
	init_SongPlayer()
	init_HUD()
	init_CharacterManager()
	print("[Main] FULLY ready")

func apply():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

	await lanemgr.map_complete
	$AnimationPlayer.play("fade_away")
	await $AnimationPlayer.animation_finished
