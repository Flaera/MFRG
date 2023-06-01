extends Control


func _ready():
	get_node("CanvasLayer/button_pause").grab_focus()


func _on_button_pause_pressed():
	var in_pause = get_tree().paused
	get_tree().paused = !in_pause
	get_node("ui_pause/CanvasLayer").visible = !in_pause
	get_node("ui_pause/CanvasLayer/VBoxContainer/resume").grab_focus()

