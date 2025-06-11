extends KURO_Component

signal user_hit_done(final_selection)
@export var component_buttons: Node

func _on_pressed() -> void:
	user_hit_done.emit(component_buttons.selection)
