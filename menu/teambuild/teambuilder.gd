extends KURO_Effect

func fade_away():
	var player = self.s_wait_for_component("AnimationPlayer")
	player.play("fade_away")
	await player.animation_finished

func fade_in():
	var player = self.s_wait_for_component("AnimationPlayer")
	player.play("fade_in")
	await player.animation_finished

func apply():
	#await fade_in()

	var done_button = self.s_wait_for_component("Done")
	var final_selection = await done_button.user_hit_done
	
	#await fade_away()
	return final_selection
