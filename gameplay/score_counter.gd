extends Label

signal score_changed(new_score:int)

var score = 0

func verify_score(s:int):
	if s < 0:
		return 0
	else:
		return s

func add_score(s:int):
	s = verify_score(s)
	score += s
	print("The score have been change yay %s" % score)
	self.text = "%s!" % score
	score_changed.emit(score)

func set_score(s:int):
	s = verify_score(s)
	score = s
	self.text = "%s!" % score
	score_changed.emit(score)
