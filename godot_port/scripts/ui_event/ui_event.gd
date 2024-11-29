extends Control


func _ready():
	#get_node("CanvasLayer/button_pause").grab_focus()
	
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))



func invokeResume():
	var in_pause = get_tree().paused
	get_node("ui_pause").get_tree().paused = !in_pause
	print("pause=",get_node("ui_pause").get_tree().paused)
	get_node("ui_pause/CanvasLayer").visible=true
	get_node("ui_pause/CanvasLayer/VBoxContainer/resume").grab_focus()


#func _input(event):
#	if (event.is_action_pressed("ui_cancel")):
#		invokeResume()


