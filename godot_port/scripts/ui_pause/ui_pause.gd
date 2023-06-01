extends Control


func _on_resume_pressed():
	print("resumir")
	get_node("CanvasLayer").visible = false
	get_parent().paused = false


func _on_quit_map_pressed():
	print("voltar para o mapa")
	get_tree().change_scene("res://scenes/map/map.scn")

