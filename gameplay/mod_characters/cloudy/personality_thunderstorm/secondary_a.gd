extends KURO_Ability

@export var stun_time_sec: float
@export var AbilityStun: KURO_CharacterStunTimer
@export var strength: float
@export var beer_amount: int

func apply():
	sg.drunkness -= strength
	sg.beer += beer_amount
	AbilityStun.stun_for(stun_time_sec)

func activate():
	if $Cooldown.is_stunned(): return
	await apply()
