extends Control


onready var w = preload("res://data_files/warnings.gd").new().warnings


func saveStyleDefault():
	var file = File.new()
	file.open("res://data_files/style.txt", File.WRITE)
	file.store_8(9)
	file.close()


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicController.music_play()
	
	saveStyleDefault()
	get_node("VBoxContainer/LabelText").text = w['3']
	get_node("VBoxContainer/LabelText").align = true
	get_node("VBoxContainer/ButtonYes").grab_focus()


func _on_ButtonYes_pressed():
	var file = File.new()
	file.open("res://data_files/data_permission.txt", File.WRITE)
	file.store_string("1")
	file.close()
	get_tree().change_scene("res://scenes/menu_group_choice/menu_group_choice2.scn")


func _on_ButtonNo_pressed():
	var file = File.new()
	file.open("res://data_files/data_permission.txt", File.WRITE)
	file.store_string("0")
	file.close()
	get_tree().change_scene("res://scenes/intro_game_talk/intro_game_talk.scn")
