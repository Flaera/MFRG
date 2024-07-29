extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var save_file = preload("res://resources/saved_game/saved_game.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("CanvasLayer/ColorRect/VBoxContainer/B_BACK").grab_focus()
	SelectLang.new().textInAllNodes(get_node("."))


func quit():
	var file_state = save_file.state
	if (file_state==0):
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

