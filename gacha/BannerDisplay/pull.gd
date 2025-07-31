extends KURO_Component

func decide_on_error_text(json):
	var text = "unknown error"
	var error = json.get("error")
	match error:
		"not enough Asahi":
			text = "Not enough [as]Asahi[/as] to pull"
		null:
			text = "You got: %s (#%d)" % [json.get("name"), json.get("id")]
		_:
			text = "[as]error: %s[/as]" % [error]
	return text

func _on_pressed() -> void:
	$Send.endpoint = "/api/gacha/banners/%s/pull/1" % [sg.banner_name]
	await $Send.apply()
	var json = $Send.responce.body_json()
	var text
	if json == null:
		push_error("failed to pull, server did not respond with valid JSON")
		text = "[as]error: server did not respond[/as]"
	else:
		text = decide_on_error_text(json)

	$EffectSummonDialouge.rich_text = text
	await $EffectSummonDialouge.apply()
