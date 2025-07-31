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

func _on_pressed():
	if username.text == "" or password.text == "":
		await display_error("username and password required!")
		return

	await ConfigManager.reload({
		"ServerLogin": {
			"username": username.text,
			"password": password.text,
			"server_ip": ip.text
		}
	})
	if not Resources.APIBearerToken:
		await display_error("Failed to log on (check your password?)")
		return

	await display_error("OK")
