extends Label

signal combo_changed(new_combo:int)

var combo = 0

func add_combo(c:int):
	combo += c
	print("The combo have been change yay %s" % combo)
	self.text = "%sx" % combo
	combo_changed.emit(combo)

func set_combo(c:int):
	combo = c
	self.text = "%sx" % combo
	combo_changed.emit(combo)
