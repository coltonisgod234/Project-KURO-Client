extends KURO_Effect

@export var missable: bool

var mgr
func kuro_init():
	mgr = await Globals.wait_for_component("LaneManager")

func apply():
	mgr.allow_miss = missable
