extends Control

var index_anne: int = 0
var anne0: Object
var anne1: Object
var anne2: Object
var anne3: Object
var anne4: Object
var anne5: Object
var anne6: Object
var anne7: Object
var anne8: Object
var anne9: Object
var anne10: Object
var anne_array = [0,1,2,3,4,5,6,7,8,9,10]


func saveStyle(var index: int):
	var file = File.new()
	file.open("res://data_files/style.txt", File.WRITE)
	file.store_8(index)
	file.close()


func _ready():
	MusicController.music_play()
	
	index_anne = 9
	get_node("ButtonLeft").grab_focus()

	anne0 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne0.png")
	anne1 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne1.png")
	anne2 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne2.png")
	anne3 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne3.png")
	anne4 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne4.png")
	anne5 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne5.png")
	anne6 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne6.png")
	anne7 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne7.png")
	anne8 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne8.png")
	anne9 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne9.png")
	anne10 = preload("res://assets/blender2.79_old/assets/talk_scenes/characters/Anne10.png")
	anne_array[0]=anne0
	anne_array[1]=anne1
	anne_array[2]=anne2
	anne_array[3]=anne3
	anne_array[4]=anne4
	anne_array[5]=anne5
	anne_array[6]=anne6
	anne_array[7]=anne7
	anne_array[8]=anne8
	anne_array[9]=anne9
	anne_array[10]=anne10


func _process(delta):
	print(index_anne)
	get_node("Sprite/TextureRect").set_texture(anne_array[index_anne])


func _on_ButtonLeft_pressed():
	if (index_anne==0):
		index_anne=10
	else:
		index_anne-=1
	saveStyle(index_anne)
	

func _on_ButtonRight_pressed():
	if (index_anne==10):
		index_anne=0
	else:
		index_anne+=1
	saveStyle(index_anne)


func _on_ButtonConfirm_pressed():
	saveStyle(index_anne)
	get_tree().change_scene("res://scenes/intro_game_talk/intro_game_talk.scn")
