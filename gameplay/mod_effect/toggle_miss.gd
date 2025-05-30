extends KURO_Effect

var mgr
func kuro_init():
	mgr = await Globals.wait_for_component("LaneManager")

func apply():
	mgr.allow_miss = !mgr.allow_miss
