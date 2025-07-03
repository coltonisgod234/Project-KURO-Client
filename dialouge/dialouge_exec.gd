extends KURO_EffectExecutor
class_name KURO_DialougeExecutor

func kuro_init():
	await self.apply_in_succession()
