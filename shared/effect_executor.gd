extends KURO_Component
class_name KURO_EffectExecutor

func apply_all_effects(name: String):
	for child in self.get_children():
		child.apply()

func apply_argument(effect: String, propname: String, value):
	var effect_object = self.get_node(effect)
	effect_object.set(propname, value)

func apply_effect(name: String):
	self.get_node(name).apply()

func apply_random_effect():
	self.get_children().pick_random().apply()
