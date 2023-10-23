extends Control


func _ready():
	TranslationServer.set_locale("en_ES")
	get_node("VBoxContainer/Button_EN").grab_focus()


func _on_Button_EN_pressed():
	get_tree().change_scene("res://scenes/intro_game_scene/intro_game_scene1.scn")


func _on_Button_PT_BR_pressed():
	get_tree().change_scene("res://scenes/intro_game_scene/intro_game_scene1.scn")


func _on_Button_EN_focus_entered():
	TranslationServer.set_locale("en_US")


func _on_Button_PT_BR_focus_entered():
	TranslationServer.set_locale("pt_BR")


func _on_Button_EN_mouse_entered():
	get_node("VBoxContainer/Button_EN").grab_focus()


func _on_Button_PT_BR_mouse_entered():
	get_node("VBoxContainer/Button_PT_BR").grab_focus()
