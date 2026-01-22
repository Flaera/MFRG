extends Control


# Declare member variables here. Examples:
# var a = 2
func change_save():
	var res = ResourceLoader.load("res://resources/saved_game/saved_game.tres")
	res.state = 8
	ResourceSaver.save("res://resources/saved_game/saved_game.tres",res)
	get_tree().change_scene("res://scenes/main_menu/main_menu.scn")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ($ViewportContainer/Viewport/CanvasLayer/ColorRect/AnimationPlayer.is_playing()==false):
		change_save()


func _on_ButtonSkip_pressed():
	change_save()


