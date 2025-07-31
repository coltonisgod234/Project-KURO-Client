extends Button

func _on_pressed():
	var screen = Scenes.FirstTimeSetup.instantiate()
	self.add_child(screen)
	await screen.apply_in_succession()
	screen.queue_free()
