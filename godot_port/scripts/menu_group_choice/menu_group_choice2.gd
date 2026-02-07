extends Control


onready var res_savefile: Resource = load("user://saved_game.tres")
onready var max_index: int = 4
onready var anne_array = [0,1,2,3]
onready var index_anne: int = 0
onready var select_lang


func saveStyle(var index: int):
	res_savefile.anne_id=index
	ResourceSaver.save("user://saved_game.tres", res_savefile)


func _ready():
	
	
	anne_array[0]=$ViewportContainer/Viewport/ControlAnneIndigena/SpriteAnneIndigena
	anne_array[1]=$ViewportContainer/Viewport/ControlAnneIndigena/SpriteAnneIndigena2
	anne_array[2]=$ViewportContainer/Viewport/ControlAnneIndigena/SpriteAnneIndigena3
	anne_array[3]=$ViewportContainer/Viewport/ControlAnneIndigena/SpriteAnneIndigena4

	get_node("ViewportContainer/Viewport/ButtonLeft").grab_focus()
	
	select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	select_lang.contrast_in_texturesrects(get_node("."))


func _exit_tree():
	select_lang.free()


func _process(delta):
	print(index_anne)
	for i in range(0,max_index):
		if (index_anne==i):
			anne_array[i].visible=true
		else:
			anne_array[i].visible=false
			print("i=",i)


func _on_ButtonLeft_pressed():
	if (index_anne==0):
		index_anne=max_index-1
	else:
		index_anne-=1
	saveStyle(index_anne)
	

func _on_ButtonRight_pressed():
	if (index_anne==max_index-1):
		index_anne=0
	else:
		index_anne+=1
	saveStyle(index_anne)


func _on_ButtonConfirm_pressed():
	saveStyle(index_anne)
	get_tree().change_scene("res://scenes/ng_prologue/ng_prologue.tscn")
