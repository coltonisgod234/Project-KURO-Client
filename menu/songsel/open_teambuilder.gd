extends KURO_Effect

func apply():
	var ui = Globals.s_wait_for_component("Ui")
	await ui.do_teambuilder_bullshit()  # Discard selection
