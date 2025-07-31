extends Button

@export var ip: LineEdit
@export var username: LineEdit
@export var password: LineEdit

var default_text = self.text
func display_error(message: String):
	push_error(message)
	self.text = message
	await get_tree().create_timer(0.5).timeout
	self.text = default_text

func _on_pressed() -> void:
	if ip.text == "" or username.text == "" or password.text == "":
		await display_error("IP, username and password required")
		return

	Resources.unset_login_resources(ip.text)

	var rq = EffectSendToServer.new()
	self.add_child(rq)

	rq.method = HTTPClient.Method.METHOD_POST
	rq.body = JSON.stringify({
		"username": username.text,
		"plaintext_password": password.text
	})
	rq.enable_bearer = false
	rq.endpoint = "/api/users"

	await rq.apply()
	var json = rq.responce.body_json()

	rq.queue_free()  # rq isn't needed anymore

	if json == null:
		await display_error("failed to create user (server did not respond)")
		return
	
	var error = json.get("error")
	if error != null:
		await display_error("error: %s" % error)
		return

	await display_error("Ok")
