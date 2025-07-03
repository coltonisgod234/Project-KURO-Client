extends KURO_Character

@export var personality: Node
@export var personalities: Array = [
	Scenes.CharacterCloudyPersonalityThunderstorm,
]

var rng = RandomNumberGenerator.new()

func set_personality(idx):
	var inst = personalities.get(idx).instantiate()
	if personality != null:
		remove_child(personality)
		personality.queue_free()
	print_tree_pretty()
	personality = inst
	self.add_child(inst)  # kinda not that bad hack but still ugly
	print_tree_pretty()

func primary():
	if $AbilityStun.is_stunned(): return
	if $Primary/Cooldown.is_stunned(): return
	rng.randomize()
	
	set_personality(rng.randi_range(0, 1 - len(personalities)))

func secondaryA():
	if $AbilityStun.is_stunned(): return
	personality.secondaryA()

func secondaryB():
	if $AbilityStun.is_stunned(): return
	personality.secondaryB()

func secondaryC():
	if $AbilityStun.is_stunned(): return
	personality.secondaryC()
