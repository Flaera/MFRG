extends Control


func _on_resume_pressed():
	get_node("CanvasLayer").visible = false
	get_parent().get_tree().paused = false
	get_parent().get_node("CanvasLayer/button_pause").grab_focus()


func _on_quit_map_pressed():
	#print("voltar para o mapa")
	get_parent().get_tree().paused = false
	get_node("CanvasLayer").visible = true	
	get_parent().get_tree().change_scene("res://scenes/map/map.scn")

