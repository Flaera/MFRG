extends Control


onready var talk: Dictionary
var index_dic: String
var index: int
var lenght: int
var bg: Object
var delta_time: float = 0.0
var delta_inc: float = 0.0


func _ready():
	
	bg = preload("res://assets/blender2.79_old/assets/talk_scenes/backgrounds/bg_intro_scene.png") 
	talk = preload("res://data_files/events_talks.gd").new().events_talks
	index_dic = '5'
	index = 0
	lenght = len(talk[index_dic])

	get_node("CanvasLayer/Sprite/TextureRectBG").set_texture(bg)
	get_node("CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/Button").align=true
	get_node("CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/Button").grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("index=", index, "len=",lenght)
	if index==lenght:
		index=-1
		get_tree().change_scene("res://scenes/main_menu/main_menu.scn")
	
	get_node("CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/LabelNameCharacter").text=talk[index_dic][index][0]
	var text_char = get_node("CanvasLayer/ColorRect/VBoxContainer2/LabelText")
	text_char.text=talk[index_dic][index][1]
	
	if (delta_time<0.5):
		delta_time += _delta
	elif (delta_time>=0.5 and delta_inc<1.0):
		delta_inc += 0.01
	else:
		delta_time = float(0.0)
	text_char.percent_visible = delta_inc
	print("delta_inc=",delta_inc)


func _on_Button_pressed():
	if (delta_inc<1.0):
		delta_time = float(0.0)
		delta_inc = float(1.0)
	elif (delta_inc>=1.0 and index<lenght):
		index+=1
		delta_inc = float(0.0)
