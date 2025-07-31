extends KURO_Component

func apply(slot: String, ability: int, scene: Node):
	sg.buffer.append({
		"type" = "ability_activated",
		"time" = Globals.get_global_timer(),
		"slot" = slot,
		"ability" = ability
	})
