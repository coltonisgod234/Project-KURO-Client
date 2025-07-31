extends KURO_Character

#@export_category("Internal")
var lanemanager: Node

@export_category("Programs")
@export var programs: Dictionary[String, PackedScene]
@export var program: Node
@export var installation_delay_sec: float

@export_category("State")
enum Tab5States {
	ALPHA,
	BETA,
	GAMMA
}
@export var state: Tab5States

@export_category("Corruption")
@export var corruption: float
@export var max_corruption: float
@export var AbilityStun: Timer
@export var fully_corrupt_stun_time: float

func clear_program():
	print("[Tab5] Cleared program")
	if program != null:
		program.queue_free()

func set_program(name):
	print("[Tab5] setting program to %s" % name)
	clear_program()

	program = programs.get(name).instantiate()
	program.sg = self
	program.position.y += 190

func primary():
	if AbilityStun.is_stunned(): return
	if program == null: return
	print("[Tab5] Executing program")
	self.add_child(program)
	self.move_child(program, 0)  # execute first
	print_tree_pretty()
	await program.activate()
	clear_program()

func secondaryA():
	if AbilityStun.is_stunned(): return
	match state:
		Tab5States.ALPHA:
			set_program("ahk")
		_:
			print("[Tab5] out of range")
	
	AbilityStun.stun_for(installation_delay_sec)

func secondaryB():
	if AbilityStun.is_stunned(): return
	match state:
		Tab5States.ALPHA:
			set_program("hexeditor")
		_:
			print("[Tab5] out of range")

	AbilityStun.stun_for(installation_delay_sec)

func _process(_delta):
	if corruption >= max_corruption:
		if AbilityStun.is_stunned(): return
		print("[Tab5] at full corruption")
		AbilityStun.stun_for(fully_corrupt_stun_time)
		clear_program()
		corruption = 0.0
