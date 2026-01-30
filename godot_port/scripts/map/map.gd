extends Control


onready var unconfirmed: Object = load("res://assets/blender2.79_old/textures/event_icons/unconfirmed_icon.png")
onready var confirmed: Object = load("res://assets/blender2.79_old/textures/event_icons/confirmed_icon.png")
onready var intro_carlos_anne_scene_name: String = "res://scenes/dialog_carlos_intro/dialog_carlos_intro.scn"
onready var intro_maria_anne_scene_name: String = "res://scenes/dialog_maria_intro/dialog_maria_intro.tscn"
onready var intro_vitoria_anne_scene_name: String = "res://scenes/dialog_vitoria_intro/dialog_vitoria_intro.tscn"
onready var saved_manager: Resource = ResourceLoader.load("user://saved_game.tres")
onready var select_lang


func _ready():
	$ViewportContainer/Viewport/CanvasLayer/LabelCar.text=saved_manager.car_selected
	#print("O que é:",$ViewportContainer/Viewport/CanvasLayer/LabelCar.text, "|",saved_manager.car_selected)
	$ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotFuncButtons/ButtonShop.grab_focus()
	#print("get_path=",get_node("CanvasLayer/AnimationPlayer"))
	get_node("ViewportContainer/Viewport/CanvasLayer/AnimationPlayer").play("map_anim_buttons2")
	#get_node("CanvasLayer/PivotButtons/PivotFuncButtons/ButtonShop").grab_focus()
	
	#var file_state = File.new()
	#file_state.open("res://data_files/progress_in_game.txt", File.READ)
	#var state: int = int(file_state.get_csv_line()[0])
	#file_state.close()
	var condition0: bool = saved_manager.event1_char1 and saved_manager.event2_char1 and saved_manager.event3_char1 and saved_manager.event4_char1 and saved_manager.event5_char1
	var condition1: bool = saved_manager.event1_char2 and saved_manager.event2_char2 and saved_manager.event3_char2 and saved_manager.event4_char2 and saved_manager.event5_char2
	var condition2: bool = saved_manager.event1_char3 and saved_manager.event2_char3 and saved_manager.event3_char3 and saved_manager.event4_char3
	#print("condition1=",saved_manager.event1_char1==false)
	#print("condition2=",int(saved_manager.state)==int(0))
	if (saved_manager.event1_char1==false and int(saved_manager.state)==int(0)):
		saved_manager.state = 1
		ResourceSaver.save("user://saved_game.tres", saved_manager)
		#cutscene da entrada da Anne no RUA
		get_tree().change_scene(intro_carlos_anne_scene_name)
		#add_child(intro_carlos_anne.instance())
		#var file_state0 = File.new()
		#file_state0.open("res://data_files/progress_in_game.txt", File.WRITE)
		#file_state0.store_string("1")
		#file_state0.close()
	elif (condition0==true and condition1==false and condition2==false and saved_manager.state==1):
		saved_manager.state = 2
		ResourceSaver.save("user://saved_game.tres", saved_manager)
		#cutscene:
		get_tree().change_scene(intro_maria_anne_scene_name)
	elif (condition0==true and condition1==true and condition2==false and saved_manager.state==2):
		saved_manager.state = 3
		ResourceSaver.save("user://saved_game.tres", saved_manager)
		#Colocar cutscene
		get_tree().change_scene(intro_vitoria_anne_scene_name)
	elif (condition0==true and condition1==true and condition2==true):
		saved_manager.state = 4
		ResourceSaver.save("user://saved_game.tres", saved_manager)
		#Colocar cutscene final
		get_tree().change_scene("res://scenes/dialog_end_game/dialog_end_game.tscn")
	var acc: int = 0
	var constant: float = 0.125
	for i in get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents").get_children():
		if (saved_manager.state==0 or saved_manager.state==1):
			if (acc==0 and saved_manager.event1_char1==false):
				i.visible = true
			elif (saved_manager.event1_char1==true and acc>=0 and acc<=4):
				i.visible = true
			else:
				i.visible = false
		elif (saved_manager.state==2 or saved_manager.state==3 or saved_manager.state==4):
			if (acc>=0 and acc<=9):
				i.visible = true
			else:
				i.visible = false
		elif (saved_manager.state==5 or saved_manager.state==6):
			if (acc>=0 and acc<=14):
				i.visible = true
			else:
				i.visible = false
		elif (saved_manager.state>=7):
			i.visible = true
		acc+=1
	
	##############################################
	#var file_event1_char1 = File.new()
	#file_event1_char1.open("res://data_files/event1_char1.txt", File.READ)
	#if int(file_event1_char1.get_csv_line()[0])==1:
	if (int(saved_manager.event1_char1)):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent0/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent0/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent0/TextureRect").rect_scale = Vector2(constant, constant)
	#file_event1_char1.close()
	
	#var file_event2_char1 = File.new()
	#file_event2_char1.open("res://data_files/event2_char1.txt", File.READ)
	if int(saved_manager.event2_char1):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent1/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent1/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent1/TextureRect").rect_scale = Vector2(constant, constant)
	#file_event2_char1.close()
	
	if int(saved_manager.event3_char1):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent2/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent2/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent2/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event4_char1):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent4/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent4/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent4/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event5_char1):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent5/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent5/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent5/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event4_char2):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent3/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent3/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent3/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event1_char2):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent6/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent6/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent6/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event2_char2):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent7/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent7/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent7/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event1_char3):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent8/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent8/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent8/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event3_char2):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent9/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent9/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent9/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event5_char2):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent12/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent12/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent12/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event2_char3):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent10/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent10/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent10/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event3_char3):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent11/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent11/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent11/TextureRect").rect_scale = Vector2(constant, constant)
	
	if int(saved_manager.event4_char3):
		get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent13/TextureRect").set_texture(confirmed)
	else:get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent13/TextureRect").set_texture(unconfirmed)
	get_node("ViewportContainer/Viewport/CanvasLayer/PivotButtons/PivotEvents/ButtonEvent13/TextureRect").rect_scale = Vector2(constant, constant)
	
	##############################################
	
	select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))



func _exit_tree():
	select_lang.free()


#func _input(event):
	#get_tree().set_input_as_handled()


func _unhandled_input(event):
	get_tree().set_input_as_handled()


func _process(_delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://scenes/main_menu/main_menu.scn")
	


func _on_ButtonShop_pressed():
	get_tree().change_scene("res://assets/blender2.79_old/assets/assets_shop_cars/shop.tscn")


func _on_ButtonGarage_pressed():
	get_tree().change_scene("res://assets/blender2.79_old/assets/garage/garage.tscn")



func _on_ButtonEvent0_pressed():
	get_tree().change_scene("res://scenes/dialog_event1_char1/dialog_event1_char1.scn")


func _on_ButtonEvent1_pressed():
	get_tree().change_scene("res://scenes/dialog_event2_char1/dialog_event2_char1.scn")


func _on_ButtonEvent2_pressed():
	get_tree().change_scene("res://scenes/event3_char1/event3_char1.tscn")


func _on_ButtonEvent4_pressed():
	get_tree().change_scene("res://scenes/event4_char1/event4_char1.tscn")


func _on_ButtonEvent5_pressed():
	get_tree().change_scene("res://scenes/event5_char1/event5_char1_v1.tscn")


func _on_ButtonEvent6_pressed():
	get_tree().change_scene("res://scenes/dialog_event1_char2/dialog_event1_char2.scn")


func _on_ButtonEvent7_pressed():
	get_tree().change_scene("res://scenes/event2_char2/event2_char2.tscn")
	
	
func _on_ButtonEvent3_pressed():
	get_tree().change_scene("res://scenes/event4_char2/event4_char2.tscn")


func _on_ButtonEvent8_pressed():
	get_tree().change_scene("res://scenes/event1_char3/event1_char3_copy_event2_char1_v1.tscn")


func _on_ButtonEvent9_pressed():
	get_tree().change_scene("res://scenes/dialog_event3_char2/dialog_event3_char2.scn")


func _on_ButtonEvent10_pressed():
	get_tree().change_scene("res://scenes/event2_char3/event2_char3_copy_event3_char1.tscn")



func _on_ButtonEvent11_pressed():
	get_tree().change_scene("res://scenes/event3_char3/event3_char3_copy_event3_char2.tscn")


func _on_ButtonEvent12_pressed():
	get_tree().change_scene("res://scenes/event5_char2/event5_char2_copy_event1_char1_v4.tscn")



func _on_ButtonEvent13_pressed():
	get_tree().change_scene("res://scenes/event4_char3/event4_char3_copy_event4_char2.tscn")
