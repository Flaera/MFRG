extends Control


func _ready():
	get_node("CanvasLayer/button_pause").grab_focus()


func invokeResume():
	var in_pause = get_tree().paused
	get_tree().paused = !in_pause
	get_node("ui_pause/CanvasLayer").visible = !in_pause
	get_node("ui_pause/CanvasLayer/VBoxContainer/resume").grab_focus()


func _process(_delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		invokeResume()


func _on_button_pause_pressed():
	invokeResume()

