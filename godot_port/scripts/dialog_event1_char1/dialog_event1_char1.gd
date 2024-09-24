extends Control


onready var talk: Dictionary
var index_dic: String
var index: int
var lenght: int
var bg: Object
var delta_time: float = 0.0
var delta_inc: float = 0.0
var anne0: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne0.png")
var anne1: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne1.png")
var anne2: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne2.png")
var anne3: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne3.png")
var anne4: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne4.png")
var anne5: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne5.png")
var anne6: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne6.png")
var anne7: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne7.png")
var anne8: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne8.png")
var anne9: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne9.png")
var anne10: Object = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne10.png")
var anne = [anne0,anne1,anne2,anne3,anne4,anne5,anne6,
anne7,anne8,anne9,anne10]
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
	char_load = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Zu.png")
	bg = preload("res://assets/blender2.79_old/assets/talk_scenes/backgrounds/bg_front_house_zu.png") 
	talk = preload("res://data_files/events_talks.gd").new().events_talks
	index_dic = '1'
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
	char_name = "Zu"
	print("talk=",talk[index_dic][index][0])
	setCharText(anne_id, char_load, talk[index_dic][index][2])
	path_event = "res://scenes/event1_char1/event1_char1_v3.scn"
	
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
	text_char.text="DiagZu"+String(index)
	
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
