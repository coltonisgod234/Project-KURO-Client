extends KURO_Character

#@export_category("Internal")
var lanemanager: Node

@export_category("Programs")
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
@export var installation_cost_corruption: float
@export var execution_cost_corruption: float
@export var termination_cost_corruption: float
@export var hit_note_recover_corruption: float

@export_category("Log")
@export var max_log_lines: int
@export var log: Array[String]

func get_program_name():
	if program == null:
		#print("No program")
		return
	return program.ability_name

func append_log(text: String):
	log.append(text)
	if log.size() > max_log_lines:
		log.pop_front()

func log_to_string():
	return "\n".join(log)

func install_program(name: String):
	append_log("$ sudo pacman -S %s" % name)
	append_log("[sudo] password for tab5: ")
	append_log(":: Retrieving packages...")
	append_log("Packages (1) %s-8.4-1" % name)
	await $AbilityStun.set_and_wait(installation_delay_sec)
	corruption += installation_cost_corruption
	append_log(":: Processing package changes...")
	program = $Programs.get_node(name)

	append_log("Installation completed!")

func primary():
	if program == null:
		append_log("Command not found.")
		return

	program.set_process(true)
	program.activate()
	append_log("$ %s" % program.ability_name)

func secondaryA():
	match state:
		Tab5States.ALPHA:
			install_program("AutoHotKey")
		_:
			print("[Tab5] I am extremely confused with the current state.")

func secondaryB():
	match state:
		Tab5States.ALPHA:
			install_program("HexEditor")
		_:
			print("[Tab5] I am extremely confused with the current state.")

func secondaryC(): install_program

func kuro_init():
	var lane_manager = Globals.s_wait_for_component("LaneManager")
	lane_manager.note_judged.connect(_on_judgement)

func _on_judgement(lane: Node2D, note: Node2D, judge:int, nonfabricated:int):
	if not corruption - hit_note_recover_corruption < 0:
		corruption -= hit_note_recover_corruption
