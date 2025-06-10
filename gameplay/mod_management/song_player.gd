extends Node2D

func _process(__delta):
	if Input.is_action_just_pressed("volume_up"):
		$AudioStreamPlayer.volume_db += 1.0
		print("CHANGE VOL UP", $AudioStreamPlayer.volume_db)
	if Input.is_action_just_pressed("volume_down"):
		$AudioStreamPlayer.volume_db -= 1.0
		print($AudioStreamPlayer.volume_db)
		print("CHANGE VOL DOWN", $AudioStreamPlayer.volume_db)

func start_song(songfile):
	if songfile is not String:
		push_error("[SongPlayer] BAD PARAMETER!! UNEXPECTED NON-STRING TYPE FOR PARAMETER AUDIOFILE!!")
		return ERR_INVALID_DATA

	#var file = FileAccess.open(songfile, FileAccess.READ)
	#if not file:
	#	push_error("[SongPlayer] FAILED TO START SONG!! CANNOT OPEN FILE %s!! DOES THE FILE EXIST?" % songfile)
	#	return ERR_INVALID_DATA
		
	#var stream = AudioStreamOggVorbis.load_from_file(songfile)
	var stream = load(songfile)
	if stream is not AudioStream:
		push_error("[SongPlayer] BAD MAP SONGFILE!! %s IS NOT OF TYPE AUDIOSTREAM!!" % [songfile])
		return ERR_INVALID_DATA
	
	print("[SongPlayer] Loaded song %s" % songfile)
	$AudioStreamPlayer.stream = stream
	$AudioStreamPlayer.play()

func stop_song():
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.stream = null
