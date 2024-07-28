extends Control


onready var save_settings = preload("res://resources/game_settings/game_settings.tres")


func _ready():
	TranslationServer.set_locale("en_ES")
	get_node("VBoxContainer/Button_EN").grab_focus()
	
	for i in get_children():
		i.set("theme_override_colors/font_color", save_settings.color_legend)


func _on_Button_EN_pressed():
	#get_tree().change_scene("res://scenes/intro_game_scene/intro_game_scene1.scn")
	get_tree().change_scene("res://scenes/menu_group_choice/menu_group_choice2.scn")


func _on_Button_PT_BR_pressed():
	#get_tree().change_scene("res://scenes/intro_game_scene/intro_game_scene1.scn")
	get_tree().change_scene("res://scenes/menu_group_choice/menu_group_choice2.scn")


func _on_Button_EN_focus_entered():
	TranslationServer.set_locale("en_US")


func _on_Button_PT_BR_focus_entered():
	TranslationServer.set_locale("pt_BR")


func _on_Button_EN_mouse_entered():
	get_node("VBoxContainer/Button_EN").grab_focus()


func _on_Button_PT_BR_mouse_entered():
	get_node("VBoxContainer/Button_PT_BR").grab_focus()
