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
var anne_id: int
var anne_obj: Object
onready var traf = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/traf_armado/08.png")


func setCharLocation(var character: Object, var pos: int):
	if (talk[index_dic][index][0]=="Carlos" and pos==1):
		$CanvasLayer/Left.set_texture(character)
		$CanvasLayer/Right.set_texture(null)
	elif (talk[index_dic][index][0]=="Carlos" and pos==2):
		$CanvasLayer/Right.set_texture(character)
		$CanvasLayer/Left.set_texture(null)
	elif (talk[index_dic][index][0]=="Anne" and pos==1):
		$CanvasLayer/Left.set_texture(anne[anne_id])
		$CanvasLayer/Right.set_texture(null)
	elif (talk[index_dic][index][0]=="Anne" and pos==2):
		$CanvasLayer/Right.set_texture(anne[anne_id])
		$CanvasLayer/Left.set_texture(null)
	elif (talk[index_dic][index][0]=="Traficante_Armado" and pos==1):
		$CanvasLayer/Left.set_texture(traf)
		$CanvasLayer/Right.set_texture(null)
	elif (talk[index_dic][index][0]=="Traficante_Armado" and pos==2):
		$CanvasLayer/Right.set_texture(traf)
		$CanvasLayer/Left.set_texture(null)
	elif (talk[index_dic][index][0]=="bg_only"):
		$CanvasLayer/Right.set_texture(null)
		$CanvasLayer/Left.set_texture(null)

func _ready():
	char_load = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/carlos/07.png")
	bg = preload("res://assets/blender2.79_old/assets/talk_scenes/backgrounds/bg_carlos_intro.png") 
	talk = preload("res://data_files/events_talks.gd").new().events_talks
	index_dic = '4'
	index = 0
	lenght = len(talk[index_dic])

	$CanvasLayer/BG/TextureRectBG.set_texture(bg)
	var bt = $CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/D_Button_CONTINUE
	bt.align=true
	bt.grab_focus()

	#var file = File.new()
	#file.open("res://data_files/style.txt", File.READ)
	#anne_id = file.get_8()
	#file.close()
	var res = ResourceLoader.load("res://resources/saved_game/saved_game.tres")
	anne_id = res.anne_id
	print("talk=",talk[index_dic][index][0])
	setCharLocation(char_load, talk[index_dic][index][2])

	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))
	

func changeScene():
	if index==lenght:
		index=-1
		get_tree().change_scene("res://scenes/map/map2.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("index=", index, "len=",lenght)
	changeScene()
	
	$CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/LabelNameCharacter.text=talk[index_dic][index][0]
	var text_char = $CanvasLayer/ColorRect/VBoxContainer2/LabelText
	text_char.text="DiagCarlos"+String(index)
	
	if (delta_time<0.5):
		delta_time += _delta
	elif (delta_time>=0.5 and delta_inc<1.0):
		delta_inc += 0.01
	else:
		delta_time = float(0.0)
	text_char.percent_visible = delta_inc
	
	setCharLocation(char_load,talk[index_dic][index][2])


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
