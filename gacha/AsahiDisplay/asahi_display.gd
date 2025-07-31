extends KURO_Effect

@export var data: int
@export var username: String
func apply():
	await $Fetch.apply()
	var body = $Fetch.responce.body_utf8()
	var json = JSON.parse_string(body)
	if json == null:
		return

	data = int(json.get("user_asahi"))
	$Label.update()
