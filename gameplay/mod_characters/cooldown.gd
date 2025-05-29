extends Timer

func stun_for(t: float):
	self.one_shot = true
	self.stop()
	self.wait_time = t
	self.start()
	print("Waiting for %s" % t)

func is_stunned():
	if self.is_stopped():
		print("[Cooldown.gd] Not stunned")
		return false
	elif not self.is_stopped():
		print("[Cooldown.gd] Yes stunned")
		return true
