extends KURO_Component

func apply():
	sg.buffer.append({
		"type" = "map_complete",
		"time" = Globals.get_global_timer(),
	})
