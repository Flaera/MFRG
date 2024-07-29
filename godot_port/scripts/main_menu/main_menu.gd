extends Control

onready var save_file = preload("res://resources/saved_game/saved_game.tres")
var ng_load: Object


func _ready():
	save_file.state
	ng_load = preload("res://scenes/main_menu/new_game_conf_screen.tscn")
	var file_state = save_file.state
	if (file_state==0):
		get_node("VBoxContainer/ButtonNG").grab_focus()
	else:
		get_node("VBoxContainer/ButtonContinue").grab_focus()

	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))


func _on_ButtonNG_pressed():
	var ng = ng_load.instance()
	add_child(ng)


func _on_ButtonContinue_pressed():
	var file_state = save_file.state
	if (file_state==0):
		var ng = ng_load.instance()
		add_child(ng)
	else:
		get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")



func _on_ButtonSettings_pressed():
	var settings_load = load("res://scenes/main_menu/main_settings.tscn")
	var settings = settings_load.instance()
	add_child(settings)


func _on_ButtonAbout_pressed():
	var about_load = load("res://scenes/main_menu/about_main_menu.tscn")
	add_child(about_load.instance())


func _on_ButtonQuit_pressed():
	get_tree().quit()



func _on_VideoPlayer_finished():
	get_node("VideoPlayer").play()
