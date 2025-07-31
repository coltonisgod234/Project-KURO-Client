extends KURO_Component

func apply(lane: Node2D, note: Node2D, real_judge, nonfabricated_judge):
	sg.buffer.append({
		"type" = "note_judged",
		"time" = Globals.get_global_timer(),
		"lane" = lane.get_instance_id(),
		"note" = note.get_instance_id(),
		"judgement" = real_judge,
		"real_judge" = nonfabricated_judge
	})
