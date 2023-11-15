extends Control


func _ready():
	get_node("VBoxContainer/ButtonNG").grab_focus()


func _on_ButtonNG_pressed():
	var file_state = File.new()
	file_state.open("res://data_files/progress_in_game.txt", File.WRITE)
	file_state.store_string("0")
	file_state.close()
	var acc_char: int = 1
	var acc_events: int = 1
	for i in range(1,16,1):
		var file = File.new()
		file.open("res://data_files/event"+String(acc_events)+"_char"+String(acc_char)+".txt", File.WRITE)
		file.store_string("0")
		file.close()
		if (i%5==0):
			acc_char += 1
			acc_events = 1
		else:
			acc_events += 1

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

