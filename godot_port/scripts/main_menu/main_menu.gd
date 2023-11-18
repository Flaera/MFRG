extends Control


var ng_load: Object


func _ready():
	ng_load = preload("res://scenes/main_menu/new_game_conf_screen.tscn")
	var file_state = File.new()
	file_state.open("res://data_files/progress_in_game.txt", File.READ)
	if (int(file_state.get_csv_line()[0])==0):
		get_node("VBoxContainer/ButtonNG").grab_focus()
	else:
		get_node("VBoxContainer/ButtonContinue").grab_focus()


func _on_ButtonNG_pressed():
	var ng = ng_load.instance()
	add_child(ng)


func _on_ButtonContinue_pressed():
	var file_state = File.new()
	file_state.open("res://data_files/progress_in_game.txt", File.READ)
	if (int(file_state.get_csv_line()[0])==0):
		var ng = ng_load.instance()
		add_child(ng)
	else:
		get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")



func _on_ButtonSettings_pressed():
	var settings_load = load("res://scenes/main_menu/main_settings.tscn")
	var settings = settings_load.instance()
	add_child(settings)


func _on_ButtonAbout_pressed():
	pass # Replace with function body.


func _on_ButtonQuit_pressed():
	get_tree().quit()

