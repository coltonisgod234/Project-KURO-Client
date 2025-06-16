extends KURO_Effect

var mgr
func kuro_init():
	mgr = Globals.s_wait_for_component("LaneManager")

func apply():
	mgr.allow_miss = !mgr.allow_miss
