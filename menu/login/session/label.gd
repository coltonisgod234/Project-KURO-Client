extends Label

@export var attribute: String
@export var fstring: String

func _process(_delta) -> void:
	self.text = fstring % [Resources.get(attribute)]
