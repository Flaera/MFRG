extends Control
class_name SelectLang



func textInAllNodes(var node_parent):
	var save_settings = load("res://resources/game_settings/game_settings.tres")
	for node in node_parent.get_children():
		if (node.get_child_count()>0):
			textInAllNodes(node)
		elif (node is Control):
			node.add_color_override("font_color",save_settings.color_legend)
			node.add_color_override("font_color_hover",save_settings.color_legend)
			node.add_color_override("font_color_focus",save_settings.color_legend)


func _ready():
	TranslationServer.set_locale("en_ES")
	get_node("VBoxContainer/Button_EN").grab_focus()
	
	#Color text:
	textInAllNodes(get_node("."))
	#for i in get_node("VBoxContainer").get_children():
	#	i.set("custom_color/font_color", save_settings.color_legend)
	

func _on_Button_EN_pressed():
	#get_tree().change_scene("res://scenes/intro_game_scene/intro_game_scene1.scn")
	get_tree().change_scene("res://scenes/intro_game_talk/intro_game_talk.scn")


func _on_Button_PT_BR_pressed():
	#get_tree().change_scene("res://scenes/intro_game_scene/intro_game_scene1.scn")
	get_tree().change_scene("res://scenes/intro_game_talk/intro_game_talk.scn")


func _on_Button_EN_focus_entered():
	TranslationServer.set_locale("en_US")


func _on_Button_PT_BR_focus_entered():
	TranslationServer.set_locale("pt_BR")


func _on_Button_EN_mouse_entered():
	get_node("VBoxContainer/Button_EN").grab_focus()


func _on_Button_PT_BR_mouse_entered():
	get_node("VBoxContainer/Button_PT_BR").grab_focus()
