extends Control


onready var talk: Dictionary
var index_dic: String
var index: int
var lenght: int
var bg: Object
var delta_time: float = 0.0
var delta_inc: float = 0.0
onready var anne = [preload("res://assets/blender2.79_old/assets/talk_scenes/characters/anne/new_anne_update/Anne1.png"),
			preload("res://assets/blender2.79_old/assets/talk_scenes/characters/anne/new_anne_update/Anne2.png"),
			preload("res://assets/blender2.79_old/assets/talk_scenes/characters/anne/new_anne_update/Anne3.png"),
			preload("res://assets/blender2.79_old/assets/talk_scenes/characters/anne/new_anne_update/Anne4.png")]
var char_load: Object
var char_name: String
var anne_id: int
var path_event: String


func setCharText(anne_id,
 var character: Object, var pos: int):
	get_node("ViewportContainer/Viewport/CanvasLayer/Left/TextureRectBG").set_texture(null)
	get_node("ViewportContainer/Viewport/CanvasLayer/Right/TextureRectBG").set_texture(null)
	if (talk[index_dic][index][0]==char_name and pos==1):
		get_node("ViewportContainer/Viewport/CanvasLayer/Left/TextureRectBG").set_texture(character)
	elif (talk[index_dic][index][0]=="Anne" and pos==1):
		get_node("ViewportContainer/Viewport/CanvasLayer/Left/TextureRectBG").set_texture(anne[anne_id])
	elif (talk[index_dic][index][0]==char_name and pos==2):
		get_node("ViewportContainer/Viewport/CanvasLayer/Right/TextureRectBG").set_texture(character)
	elif (talk[index_dic][index][0]=="Anne" and pos==2):
		get_node("ViewportContainer/Viewport/CanvasLayer/Right/TextureRectBG").set_texture(anne[anne_id])
	


func _ready():
	char_load = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/iua/02.png")
	bg = preload("res://assets/blender2.79_old/assets/talk_scenes/talk_scene_iua/05.png") 
	talk = preload("res://data_files/events_talks.gd").new().events_talks
	index_dic = '2'
	index = 0
	lenght = len(talk[index_dic])

	get_node("ViewportContainer/Viewport/CanvasLayer/BG/TextureRectBG").set_texture(bg)
	var bt = get_node("ViewportContainer/Viewport/CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/D_Button_CONTINUE")
	bt.align=true
	bt.grab_focus()

	#var file = File.new()
	#file.open("res://data_files/style.txt", File.READ)
	#anne_id = file.get_8()
	#file.close()
	var res = ResourceLoader.load("res://resources/saved_game/saved_game.tres")
	anne_id = res.anne_id
	char_name = "Iuá"
	print("talk=",talk[index_dic][index][0])
	setCharText(anne_id, char_load, talk[index_dic][index][2])
	path_event = "res://scenes/event2_char1/event2_char1_v1.tscn"
	
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))

	select_lang.contrast_in_texturesrects(get_node("."))



func changeScene():
	if index==lenght:
		index=-1
		get_tree().change_scene(path_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("index=", index, "len=",lenght)
	changeScene()
	
	get_node("ViewportContainer/Viewport/CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/LabelNameCharacter").text=talk[index_dic][index][0]
	var text_char = get_node("ViewportContainer/Viewport/CanvasLayer/ColorRect/VBoxContainer2/LabelText")
	text_char.text="DiagIua"+String(index)
	
	if (delta_time<0.5):
		delta_time += _delta
	elif (delta_time>=0.5 and delta_inc<1.0):
		delta_inc += 0.01
	else:
		delta_time = float(0.0)
	text_char.percent_visible = delta_inc
	print("delta_inc=",delta_inc)
	
	setCharText(anne_id,char_load,talk[index_dic][index][2])


func _on_D_Button_CONTINUE_pressed():
	if (delta_inc<1.0):
		delta_time = float(0.0)
		delta_inc = float(1.0)
	elif (delta_inc>=1.0 and index<lenght):
		index+=1
		delta_inc = float(0.0)


func _on_ButtonSkip_pressed():
	index = lenght
	changeScene()
