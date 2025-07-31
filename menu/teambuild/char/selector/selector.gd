extends KURO_Component

signal selected(btn)

func fadein():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func fadeout():
	$AnimationPlayer.play("fade_away")
	await $AnimationPlayer.animation_finished

func wire_signals():
	var btns = s_wait_for_component("Buttons")
	for btn in btns.get_children():
		btns.wait_till_init(btn)
		btn.pressed.connect(_on_btn_pressed.bind(btn))

func apply():
	wire_signals()
	await fadein()
	print("[Selector] Stub log 1")
	var selected_character = await selected  # Pray this works
	print("[Selector] Stub log 2 %s" % [selected_character])
	await fadeout()
	return selected_character

func _on_btn_pressed(btn):
	selected.emit(btn)
