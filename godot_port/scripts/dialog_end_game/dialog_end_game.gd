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
var anne_obj: Object
onready var carlos = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/carlos/07.png")
onready var state_end = 0


func setCharLocation(var character: Object, var pos: int):
	if (talk[index_dic][index][0]=="bg_only"):
		$ViewportContainer/Viewport/CanvasLayer/Right.set_texture(null)
		$ViewportContainer/Viewport/CanvasLayer/Left.set_texture(null)



func _ready():
	#MusicController.music_play()
	char_load = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/vitória_safira/04.png")
	talk = preload("res://data_files/events_talks.gd").new().events_talks
	index_dic = '11'
	index = 0
	
	lenght = len(talk[index_dic])
	
	
	bg = preload("res://assets/blender2.79_old/assets/talk_scenes/backgrounds/final/final01.png")
	$ViewportContainer/Viewport/CanvasLayer/BG/TextureRectBG.set_texture(bg)
	
	var bt = $ViewportContainer/Viewport/CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/D_Button_CONTINUE
	bt.align=true
	bt.grab_focus()

	#var file = File.new()
	#file.open("res://data_files/style.txt", File.READ)
	#anne_id = file.get_8()
	#file.close()
	var res = ResourceLoader.load("user://saved_game.tres")
	anne_id = res.anne_id
	char_name = "Vitoria"
	print("talk=",talk[index_dic][index][0])
	setCharLocation(char_load, talk[index_dic][index][2])

	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))
	

func changeScene():
	print("index=",index," stateend=",state_end)
	if index==4 and state_end==0:
		state_end=1
		$AnimationPlayer.play("fallin_game_end")
	if index==4 and $AnimationPlayer.is_playing()==false and state_end==1:
		#get_tree().change_scene("res://scenes/map/map2.tscn")
		$AnimationPlayer.play("fallout_game_end")
		state_end=2
		bg = load("res://assets/blender2.79_old/assets/talk_scenes/backgrounds/final/final02.png")
		MusicController.music_pause()
	if index==7 and state_end==2 and $AnimationPlayer.is_playing()==false:
		state_end=3
		bg = load("res://assets/blender2.79_old/assets/talk_scenes/backgrounds/final/final03.png")
	if state_end==3 and index==8 and $AnimationPlayer.is_playing()==false:
		$AnimationPlayer.play("fallin_game_end")
		state_end=4
	if (state_end==4 and $AnimationPlayer.is_playing()==false):
		MusicController.music_play()
		var credits_scene_path = "res://scenes/credits/credits.tscn"
		get_tree().change_scene(credits_scene_path)
		
		
	$ViewportContainer/Viewport/CanvasLayer/BG/TextureRectBG.set_texture(bg)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#print("index=", index, "len=",lenght)
	changeScene()
	
	$ViewportContainer/Viewport/CanvasLayer/ColorRect/VBoxContainer2/HBoxContainer/LabelNameCharacter.text=talk[index_dic][index][0]
	var text_char = $ViewportContainer/Viewport/CanvasLayer/ColorRect/VBoxContainer2/LabelText
	text_char.text="DiagFinal"+String(index)
	
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
	elif (delta_inc>=1.0 and index<lenght-1 and $AnimationPlayer.is_playing()==false):
		index+=1
		delta_inc = float(0.0)


func _on_ButtonSkip_pressed():
	index = lenght-1
	changeScene()
