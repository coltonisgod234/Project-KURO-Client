extends Timer

func stun_for(t: float):
	self.wait_time = t
	self.start()
	print("Waiting for %s" % t)

func is_stunned():
	if self.time_left <= 0.0:
		print("[Cooldown.gd] Not stunned")
		return false
	else:
		print("[Cooldown.gd] Yes stunned")
		return true
