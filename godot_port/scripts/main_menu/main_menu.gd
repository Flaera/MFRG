extends Control


func _ready():
	get_node("VBoxContainer/ButtonNG").grab_focus()


func _on_ButtonNG_pressed():
	get_tree().change_scene("res://scenes/map/map.scn")


func _on_ButtonContinue_pressed():
	pass # Replace with function body.


func _on_ButtonSettings_pressed():
	var settings_load = load("res://scenes/main_menu/main_settings.tscn")
	var settings = settings_load.instance()
	add_child(settings)


func _on_ButtonAbout_pressed():
	pass # Replace with function body.


func _on_ButtonQuit_pressed():
	get_tree().quit()

