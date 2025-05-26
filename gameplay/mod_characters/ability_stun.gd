extends Timer

func stun_for(t: float):
	self.wait_time = t
	self.start()

func is_stunned():
	if self.wait_time == 0.0:
		return false
	else:
		return true
