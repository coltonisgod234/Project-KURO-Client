extends Button

@export var endpoint: String

var default_text = self.text
func display_error(message: String):
	push_error(message)
	self.text = message
	await get_tree().create_timer(0.5).timeout
	self.text = default_text

'''
func _on_pressed_bak() -> void:
	# Unset login resources ("log out")
	Resources.unset_login_resources(server_ip.text)

	# Create a new request
	var rq = EffectSendToServer.new()
	self.add_child(rq)
	rq.method = HTTPClient.Method.METHOD_DELETE
	rq.endpoint = endpoint % [Resources.username]
	await rq.apply()

	# Make sure it returns properly
	if rq.responce.result != OK:
		await display_error("network error #%s" % rq.responce.result)

	# Validate the JSON
	var json = rq.responce.body_json()
	if json == null:
		push_error("Failed to log out (bad json)")
		return

	# Check the error
	match json.get("error"):
		null:
			await display_error("ok")
			return
		
		"unauthorized":
			await display_error("unauthorized (are you logged on?)")
			return

	rq.queue_free()
	return
'''

func _on_pressed() -> void:
	print("A", Resources.server_ip)
	if Resources.username == null:
		await display_error("no username (are you logged on?)")
		return

	var rq = EffectLoginToServer.new()
	add_child(rq)
	print("B", Resources.server_ip)

	rq.logout = true
	rq.username = Resources.username

	print("C", Resources.server_ip)
	await rq.apply()
	print("D", Resources.server_ip)
	rq.queue_free()
	print("E", Resources.server_ip)

	Resources.unset_login_resources(Resources.server_ip)
	print("F", Resources.server_ip)
