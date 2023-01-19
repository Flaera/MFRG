extends Control


func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	get_node("ButtonEvent0").grab_focus()
	get_node("AnimationPlayer").play("anim_button_map")


func _on_ButtonEvent0_pressed():
	print("Amanhã é a física dos carrinhos. :D")
