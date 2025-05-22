extends Label

signal score_changed(new_score:int)

var score = 0

func add_score(s:int):
	score += s
	print("The score have been change yay %s" % score)
	self.text = "%s!" % score
	score_changed.emit(score)

func set_score(s:int):
	score = s
	self.text = "%s!" % score
	score_changed.emit(score)
