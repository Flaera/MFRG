extends Control

onready var save_file = load("user://saved_game.tres")
onready var save_settings = load("user://game_settings.tres")
var ng_load
onready var select_lang = SelectLang.new()



func _ready():
	#$ViewportContainer/Viewport/VBoxContainer.visible=true
	
	ng_load = preload("res://scenes/main_menu/new_game_conf_screen.tscn")
	var file_state = save_file.state
	if (file_state==0):
		get_node("ViewportContainer/Viewport/VBoxContainer/ButtonNG").grab_focus()
	else:
		get_node("ViewportContainer/Viewport/VBoxContainer/ButtonContinue").grab_focus()

	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))
	

func _exit_tree():
	select_lang.free()
	


func _on_ButtonNG_pressed():
	var ng = ng_load.instance()
	$ViewportContainer/Viewport.add_child(ng)


func _on_ButtonContinue_pressed():
	var file_state = save_file.state
	if (file_state==0):
		var ng = ng_load.instance()
		$ViewportContainer/Viewport.add_child(ng)
	else:
		get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")



func _on_ButtonSettings_pressed():
	var settings_load = load("res://scenes/main_menu/main_settings.tscn")
	var settings = settings_load.instance()
	$ViewportContainer/Viewport/VBoxContainer.visible=false
	$ViewportContainer/Viewport.add_child(settings)


func _on_ButtonAbout_pressed():
	var about_load = load("res://scenes/main_menu/about_main_menu.tscn")
	$ViewportContainer/Viewport.add_child(about_load.instance())


func _on_ButtonQuit_pressed():
	get_tree().quit()



func _on_VideoPlayer_finished():
	get_node("ViewportContainer/Viewport/VideoPlayer").play()
