extends KURO_EffectExecutor

func load_from_file(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	if file is not FileAccess:
		print("[configloader.gd] The file is not file-ing.")
		file.close()
		return null

	var text = file.get_as_text()
	if text is not String:
		print("[configloader.gd] The text is not text-ing.")
		file.close()
		return null

	file.close()
	return text

func reload_config(raw_json: String):
	print("[configloader.gd] Reloading config...")
	var settings = JSON.parse_string(raw_json)
	if settings is not Dictionary:
		print("[configloader.gd] Error parsing data. Got %s" % settings)
		return ERR_INVALID_DATA
	
	return await reload(settings)

func reload(settings: Dictionary):
	self.apply_arguments_from_dictionary(settings)
	await self.apply_in_succession()
	print("[configloader.gd] Ok")
	return OK

func kuro_init(): #test
	await reload_config(load_from_file("user://config.json"))
