extends KURO_Component

func _input(event):
	if event.is_action_pressed("volume_up"):
		$AudioStreamPlayer.volume_db += 1.0
		print("CHANGE VOL UP", $AudioStreamPlayer.volume_db)
	if event.is_action_pressed("volume_down"):
		$AudioStreamPlayer.volume_db -= 1.0
		print($AudioStreamPlayer.volume_db)
		print("CHANGE VOL DOWN", $AudioStreamPlayer.volume_db)

func calculate_max_song_offset(notes: Array, spawn_y: float, hit_y: float) -> float:
	print("[SongPlayer] Calculating the maximum song offset...")
	var max_offset = $Timer.wait_time
	for note in notes:
		var speed = note.get("speed")
		var travel_time = (spawn_y - hit_y) / speed
		print("[SongPlayer] Looked at %f" % travel_time)
		if travel_time > max_offset:
			max_offset = travel_time
			print("[SongPlayer] New largest! %f" % max_offset)

	$Timer.wait_time = max_offset
	return max_offset

func start_song(songfile):
	if songfile is not String:
		push_error("[SongPlayer] BAD PARAMETER!! UNEXPECTED NON-STRING TYPE FOR PARAMETER AUDIOFILE!!")
		return ERR_INVALID_DATA

	#var file = FileAccess.open(songfile, FileAccess.READ)
	#if not file:
	#	push_error("[SongPlayer] FAILED TO START SONG!! CANNOT OPEN FILE %s!! DOES THE FILE EXIST?" % songfile)
	#	return ERR_INVALID_DATA
		
	var stream = AudioStreamOggVorbis.load_from_file(songfile)
	#var stream = load(songfile)
	if stream is not AudioStreamOggVorbis:
		push_error("[SongPlayer] BAD MAP SONGFILE!! %s IS NOT OF TYPE AudioStreamOggVorbis!!" % [songfile])
		return ERR_INVALID_DATA
	
	print("[SongPlayer] Loaded song %s" % songfile)
	$AudioStreamPlayer.stream = stream

	print("[SongPlayer] Offset is %f, waiting..." % $Timer.wait_time)
	$Timer.start()
	await $Timer.timeout
	print("[SongPlayer] Started song %s" % songfile)
	$AudioStreamPlayer.play()

func stop_song():
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = null
