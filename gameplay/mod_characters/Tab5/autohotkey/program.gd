extends KURO_Ability

func reset_state():
	print("[Tab5] [AutoHotKey] Reset state")
	self.set_process(false)
	$StopTimer.stop()

func kuro_init():
	reset_state()
	$StopTimer.timeout.connect(_on_timer_stop)

func activate():
	$StopTimer.stun_for(1.0)

func _on_timer_stop():
	$Executor.apply("ResetMissable")
	reset_state()

func _process(delta):
	$Executor.apply("SetMissable")
