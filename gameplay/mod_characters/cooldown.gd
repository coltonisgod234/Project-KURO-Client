extends Timer

func stun_for(t: float):
	self.one_shot = true
	self.stop()
	self.wait_time = t
	self.start()
	print("[Cooldown.gd] Waiting for %s" % t)

func is_stunned():
	if self.is_stopped():
		#print("[Cooldown.gd] Not stunned")
		return false
	elif not self.is_stopped():
		#print("[Cooldown.gd] Yes stunned")
		return true

func wait_till_done():
	while is_stunned():
		await get_tree().process_frame
	return self

func set_and_wait(t:float):
	stun_for(t)
	return await wait_till_done()
