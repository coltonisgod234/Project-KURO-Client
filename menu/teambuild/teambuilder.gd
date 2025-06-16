extends KURO_Effect

func apply():
	var done_button = self.s_wait_for_component("Done")
	var final_selection = await done_button.user_hit_done
	return final_selection
