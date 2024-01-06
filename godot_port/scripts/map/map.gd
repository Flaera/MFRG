extends Control


onready var unconfirmed: Object = load("res://assets/blender2.79_old/textures/event_icons/unconfirmed_icon.png")
onready var confirmed: Object = load("res://assets/blender2.79_old/textures/event_icons/confirmed_icon.png")
onready var intro_carlos_anne: Object = load("res://scenes/dialog_carlos_intro/dialog_carlos_intro.scn")


func _ready():
	
	print("get_path=",get_node("CanvasLayer/AnimationPlayer"))
	get_node("CanvasLayer/AnimationPlayer").play("map_anim_buttons2")
	#get_node("CanvasLayer/PivotButtons/PivotFuncButtons/ButtonShop").grab_focus()
	var events: Array = []
	var acc_events: int = 0
	var acc_events_five = 1
	var acc_char_three = 1
	for _j in range(0,15,1):
		var file_events = File.new()
		file_events.open("res://data_files/event"+String(acc_events_five)+"_char"+String(acc_char_three)+".txt", File.READ)
		var event_info: int = int(file_events.get_csv_line()[0])
		file_events.close()
		events.append(event_info)
		print("Processing accs=", acc_events, "-", acc_char_three, "-", acc_events_five)
		if (acc_events!=0 and acc_events_five%5==0):
			acc_char_three += 1
			acc_events_five = 1
		else:
			acc_events_five += 1
		acc_events += 1
	print("event array=", events)
	var file_state = File.new()
	file_state.open("res://data_files/progress_in_game.txt", File.READ)
	var state: int = int(file_state.get_csv_line()[0])
	file_state.close()
	var condition0: bool = events[0]==1 and events[1]==1 and events[2]==1 and events[3]==1 and events[4]==1
	var condition1: bool = events[5]==1 and events[6]==1 and events[7]==1 and events[8]==1 and events[9]==1
	var condition2: bool = events[10]==1 and events[11]==1 and events[12]==1 and events[13]==1 and events[14]==1
	if (events[0]==0 and state==0):
		#cutscene da entrada da Anne no RUA
		add_child(intro_carlos_anne.instance())
		var file_state0 = File.new()
		file_state0.open("res://data_files/progress_in_game.txt", File.WRITE)
		file_state0.store_string("1")
		file_state0.close()
	elif (condition0==true and condition1==true and condition2==false and state==1):
		#Colocar cutscene
		var file_state0 = File.new()
		file_state0.open("res://data_files/progress_in_game.txt", File.WRITE)
		file_state0.store_string("2")
		file_state0.close()
	elif (condition0==true and condition1==true and condition2==true and state==2):
		#Colocar cutscene
		var file_state0 = File.new()
		file_state0.open("res://data_files/progress_in_game.txt", File.WRITE)
		file_state0.store_string("3")
		file_state0.close()
	var acc: int = 0
	var constant: float = 0.125
	for i in get_node("CanvasLayer/PivotButtons/PivotEvents").get_children():
		if (state==0 or state==1 or state==2):
			if (acc==0 and events[0]==0):
				i.visible = true
			elif (events[0]==1 and acc>=0 and acc<=4):
				i.visible = true
			else:
				i.visible = false
		elif (state==3 or state==4):
			if (acc>=0 and acc<=9):
				i.visible = true
			else:
				i.visible = false
		elif (state==5 or state==6):
			if (acc>=0 and acc<=14):
				i.visible = true
			else:
				i.visible = false
		if (state>=7):
			i.visible = true
		acc+=1
	
	##############################################
	var file_event1_char1 = File.new()
	file_event1_char1.open("res://data_files/event1_char1.txt", File.READ)
	if int(file_event1_char1.get_csv_line()[0])==1:
		get_node("CanvasLayer/PivotButtons/PivotEvents/ButtonEvent0/TextureRect").set_texture(confirmed)
	else:get_node("CanvasLayer/PivotButtons/PivotEvents/ButtonEvent0/TextureRect").set_texture(unconfirmed)
	get_node("CanvasLayer/PivotButtons/PivotEvents/ButtonEvent0/TextureRect").rect_scale = Vector2(constant, constant)
	file_event1_char1.close()
	
	var file_event2_char1 = File.new()
	file_event2_char1.open("res://data_files/event2_char1.txt", File.READ)
	if int(file_event2_char1.get_csv_line()[0])==1:
		get_node("CanvasLayer/PivotButtons/PivotEvents/ButtonEvent1/TextureRect").set_texture(confirmed)
	else:get_node("CanvasLayer/PivotButtons/PivotEvents/ButtonEvent1/TextureRect").set_texture(unconfirmed)
	get_node("CanvasLayer/PivotButtons/PivotEvents/ButtonEvent1/TextureRect").rect_scale = Vector2(constant, constant)
	file_event2_char1.close()
	
	##############################################


#func _input(event):
	#get_tree().set_input_as_handled()


func _unhandled_input(event):
	get_tree().set_input_as_handled()


func _process(_delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://scenes/main_menu/main_menu.scn")
	


func _on_ButtonEvent0_pressed():
	get_tree().change_scene("res://scenes/dialog_event1_char1/dialog_event1_char1.scn")


func _on_ButtonEvent1_pressed():
	get_tree().change_scene("res://scenes/dialog_event2_char1/dialog_event2_char1.scn")


func _on_ButtonShop_pressed():
	print("HERE - AQUI FOI E AÌ!!")
	get_tree().change_scene("res://assets/blender2.79_old/assets/assets_shop_cars/shop.tscn")


func _on_ButtonGarage_pressed():
	get_tree().change_scene("res://assets/blender2.79_old/assets/garage/garage.tscn")

