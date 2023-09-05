extends Control


func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	get_node("ButtonEvent0").grab_focus()
	get_node("AnimationPlayer").play("anim_button_map")
	var file = File.new()
	file.open("data_files/gold.txt",File.READ)
	var golds = file.get_csv_line()
	get_node("HBoxContainer/Label").text = " Golds: "+golds[0]+" "

func _on_ButtonEvent0_pressed():
	get_tree().change_scene("res://scenes/dialog_event1_char1/dialog_event1_char1.scn")

