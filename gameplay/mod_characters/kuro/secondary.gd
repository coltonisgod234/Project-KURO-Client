extends KURO_Ability

@export var MultiplexedGoodChildName: String
@export var MultiplexedBadChildName: String
@export var LifeLostPerBadEffect: float
@export var LifeGainedPerGoodEffect: float

func activate():
	print("doing the thing")
	var children := $ExecutorMultiplexer.get_children()
	var child = children.pick_random()
	#while sg.LastEffectMultiplexed == child:
	#	child = children.pick_random()

	var effect_applied = child.apply_random_effect_bagged_random(sg.LastEffectApplied)
	match child.name:
		MultiplexedBadChildName:
			sg.life -= LifeLostPerBadEffect
		MultiplexedGoodChildName:
			sg.life += LifeGainedPerGoodEffect
		_:
			Globals.crash("kuro: child name is not valid")
	
	sg.LastEffectMultiplexed = child
	sg.LastEffectApplied = effect_applied
	sg.LastEffectAppliedHumanFriendlyName = effect_applied.HumanFriendlyName
