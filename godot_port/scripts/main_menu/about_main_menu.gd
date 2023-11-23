extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/ColorRect/VBoxContainer/B_BACK").grab_focus()


func quit():
	var file_state = File.new()
	file_state.open("res://data_files/progress_in_game.txt", File.READ)
	if (int(file_state.get_csv_line()[0])==0):
		get_node("/root/ControlMenu/VBoxContainer/ButtonNG").grab_focus()
	else:
		get_node("/root/ControlMenu/VBoxContainer/ButtonContinue").grab_focus()
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		quit()


func _on_B_NO_pressed():
	quit()

