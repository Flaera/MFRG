extends Control


onready var talk: Dictionary
var index_dic: String
var index: int
var lenght: int
var bg: Object

func _ready():
	bg = preload("res://assets/blender2.79_old/assets/talk_scenes/backgrounds/bg_intro_scene.png") 
	talk = preload("res://data_files/events_talks.gd").new().events_talks
	index_dic = '5'
	index = 0
	lenght = len(talk[index_dic])

	get_node("Sprite/TextureRectBG").set_texture(bg)
	get_node("VBoxContainer/HBoxContainer/Button").align=true
	get_node("VBoxContainer/HBoxContainer/Button").grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("index=", index, "len=",lenght)
	if index==lenght:
		index=-1
		get_tree().change_scene("res://scenes/main_menu/main_menu.scn")
	
	get_node("VBoxContainer/HBoxContainer/LabelNameCharacter").text=talk[index_dic][index][0]
	get_node("VBoxContainer/LabelText").text=talk[index_dic][index][1]
	


func _on_Button_pressed():
	if (index<lenght):
		index+=1
