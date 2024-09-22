extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ViewportContainer/Viewport/CanvasLayer/Control/VBoxContainer/Button").grab_focus()
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))


func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://scenes/main_menu/main_menu.scn")


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")
