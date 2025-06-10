extends KURO_Effect
class_name KURO_Effect_Dialouge_Button

@export var dialouge: Node
@export var text: String
@export var await_press: bool

func apply_await_press(btn):
	print("[DialougeButton.gd] Awaiting press...")
	await btn.pressed

func apply():
	var btn = await dialouge.create_button(text)
	if await_press:
		await apply_await_press(btn)
