extends KURO_Component

@export var map: Node
@export var diffcontainer: Node
signal button_pressed(button, chartdisplayer)

func kuro_init():
	map.btn.pressed.connect(_fwd_button_press)

func _fwd_button_press():
	button_pressed.emit(map.btn, self)
