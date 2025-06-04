extends KURO_Ability

func reset_state():
	self.set_process(false)
	$StopTimer.stop()

func kuro_init():
	$StopTimer.timeout.connect(_on_timer_stop)
	reset_state()

func activate():
	$StopTimer.stun_for(1.0)

func _on_timer_stop():
	$Executor.apply("ResetMissable")
	reset_state()

func _process(delta):
	print("[Tab5] yay")
	$Executor.apply("SetMissable")
