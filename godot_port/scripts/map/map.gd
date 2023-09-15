extends Control


func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	get_node("PivotButtons/ButtonEvent0").grab_focus()
	get_node("PivotButtons/AnimationPlayer").play("anim_buttons_map")
	var file = File.new()
	file.open("res://data_files/gold.txt",File.READ)
	var golds = file.get_csv_line()
	get_node("HBoxContainer/Label").text = " Golds: "+golds[0]+" "


func _on_ButtonEvent0_pressed():
	get_tree().change_scene("res://scenes/dialog_event1_char1/dialog_event1_char1.scn")


func _on_ButtonEvent1_pressed():
	get_tree().change_scene("res://scenes/dialog_event2_char1/dialog_event2_char1.scn")


func _on_ButtonShop_pressed():
	get_tree().change_scene("res://assets/blender2.79_old/assets/assets_shop_cars/shop.tscn")



func _on_ButtonGarage_pressed():
	get_tree().change_scene("res://assets/blender2.79_old/assets/garage/garage.tscn")
