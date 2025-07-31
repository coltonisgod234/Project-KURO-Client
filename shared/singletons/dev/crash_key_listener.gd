extends Node

func apply():
	Globals.crash("manually initiated crash (CrashKeyListener)")

func _input(ev: InputEvent):
	if ev is InputEventKey:
		if ev.is_action_pressed("CrashGame"):
			apply()
