extends Spatial


onready var car_loaded
onready var curr_car
onready var camera
onready var curr_cam
onready var loser: bool = false
onready var pts: float = 0.0
onready var timer: float
onready var win: int = 0
onready var golds: int = 0.0
onready var time_end: float = 0.0
onready var curr_car_enemy
onready var checkpoints = $ViewportContainer/Viewport/checkpoints.get_children()
onready var len_checkpoints: int = len(checkpoints)
onready var index_cp: int = 0
onready var event_name0: String
onready var save_file: Resource
onready var tutorial_step: int = 0
onready var ctuto = $ViewportContainer/Viewport/checkpoints_tutorial.get_children()
onready var controls = ControlsSettings.new()


func _ready():
	# MUDAR O NOME DA VAR DO SAVED FILE RESOURCE LÀ EMBAIXO EM winPlay()!!
	

	#var file = File.new()
	#file.open("res://data_files/car_selected.txt",File.READ)
	#var car = file.get_csv_line()[0]
	save_file = preload("res://resources/saved_game/saved_game.tres")
	#print("save=",save_file)
	#Load car player:
	car_loaded = load("res://scenes/cars_updated/"+save_file.car_selected+".tscn")
	#car_loaded.MODES.PLAYER
	#file.close()
	curr_car = car_loaded.instance()
	curr_car.car_mode=0
	#curr_car.car_mode
	#curr_car._ready()
	get_node("ViewportContainer/Viewport/car_invoker").add_child(curr_car)
	#load enemy:
	var car_loaded_enemy: Object = load("res://scenes/cars_updated/"+save_file.car_selected+".tscn")
	#car_loaded_enemy.MODES.AI
	curr_car_enemy = car_loaded_enemy.instance()
	curr_car_enemy.car_mode=1
	#curr_car_enemy._ready()
	get_node("ViewportContainer/Viewport/car_invoker_enemy").add_child(curr_car_enemy)

	#camera = preload("res://scenes/camera/camera.scn")
	#curr_cam = camera.instance()
	#get_node("ViewportContainer/Viewport/car_invoker").add_child(curr_cam)
	curr_cam = $ViewportContainer/Viewport/car_invoker/Camera
	
	timer = 120.0
	get_node("ViewportContainer/Viewport/Timer").start(timer) #time in seconds
	get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label2/AnimationPlayer").play("anim_run_init_event")
	
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))

	Contrast3D.new().contrast_3d(get_node("."))
	


func camTransform():
	#var cam = get_node("Camera")
	curr_cam.translation[0] = curr_car.translation[0]
	curr_cam.translation[2] = curr_car.translation[2]
	curr_cam.translation[1] = 38.0
	#curr_cam.rotation_degrees[0] = -90.0
	#curr_cam.rotation_degrees[1] = 180.0
	#curr_cam.rotation_degrees[2] = 0.0


func winPlay(_delta):
	if (loser==false and win==1 and !get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label/AnimationPlayer").is_playing()):
		get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label/AnimationPlayer").play("anim_you_win")
		get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label4/AnimationPlayer").play("anim_you_win_golds")
		win=2
	elif (loser==false and get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label/AnimationPlayer").is_playing()):
		golds = lerp(golds,pts,0.1)
		win=3
	elif (loser==false and win==3):
		golds = lerp(golds,pts,0.1)
		time_end += _delta
		if (time_end>=7.0):
			var curr_golds: int = 0
			#var file_golds = File.new()
			#file_golds.open("res://data_files/gold.txt", File.READ)
			#curr_golds = int(file_golds.get_csv_line()[0])+golds
			curr_golds = save_file.gold+golds
			print(curr_golds)
			#file_golds.close()
			#var file_golds1 = File.new()
			#file_golds1.open("res://data_files/gold.txt", File.WRITE)
			#file_golds1.store_string(String(curr_golds))
			#file_golds1.close()
			save_file.gold = curr_golds
			#ResourceSaver.save("res://resources/saved_game/saved_game.tres", save_file)
			
			
			#var save_file: Resource = load("res://resources/saved_game/saved_game.tres")
			save_file.event1_char1 = true
			ResourceSaver.save("res://resources/saved_game/saved_game.tres", save_file)
			"""var file_event = File.new()
			file_event.open("res://data_files/"+event_name0+".txt", File.WRITE)
			file_event.store_string("1")
			file_event.close()"""
			
			get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")
		get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label4").text = String(golds)+" golds"


func playerLoserOrWin(_delta, var time: float):
	#Loser by oponent first:
	if (loser==true and !get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label3/AnimationPlayer").is_playing()):
		get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label3/AnimationPlayer").play("anim_loser_event")
	elif (loser==true and get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label3/AnimationPlayer").is_playing()):
		time_end+=_delta
		if (time_end>=1.5):
			get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")
	#Loser per time out:
	if (time<=0.0 and loser==false):
		get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label3/AnimationPlayer").play("anim_loser_event")
		loser = true
	elif (time<=0.0 and loser==true and
	!get_node("ViewportContainer/Viewport/CanvasLayer/Control/Control/Label3/AnimationPlayer").is_playing()):
		get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")
	
	winPlay(_delta)


func _input(event):
	if ((event is InputEventKey and event.scancode==KEY_ENTER) or (event is InputEventJoypadButton and event.button_index==JOY_START)):
		get_tree().change_scene("res://scenes/progress_game/progress_game.tscn")
		


func tutorial(delta):
	if curr_car.car_mode==0:
		print("TUTO=", curr_car.translation.distance_to(ctuto[0].translation))
		if (tutorial_step==0):
			var action = InputMap.get_action_list("g_up")[0]
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial3.text=controls.convert_actions2bnames(action)
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial4.text="TUTO0"
			if (Input.is_action_just_pressed("g_up")):
				tutorial_step+=1
		if (tutorial_step==1):# and curr_car.translation.distance_to(ctuto[1].translation)<11):
			var action0 = InputMap.get_action_list("g_right")[0]
			var action1 = InputMap.get_action_list("g_left")[0]
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial3.text=controls.convert_actions2bnames(action0)+"/"+controls.convert_actions2bnames(action1)
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial4.text="TUTO1"
			if (curr_car.velocity>0.0 and (Input.is_action_just_pressed("g_right") or Input.is_action_just_pressed("g_left"))):
				tutorial_step+=1
		if (tutorial_step==2):
			var action = InputMap.get_action_list("g_down")[0]
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial3.text=controls.convert_actions2bnames(action)
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial4.text="TUTO2"
			if (Input.is_action_just_pressed("g_down")):
				tutorial_step+=1
		if (tutorial_step==3):
			var action = InputMap.get_action_list("g_brake")[0]
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial3.text=controls.convert_actions2bnames(action)
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial4.text="TUTO3"
			if (Input.is_action_just_pressed("g_brake")):
				tutorial_step+=1
		if (tutorial_step==4):
			var action = InputMap.get_action_list("g_nitro")[0]
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial3.text=controls.convert_actions2bnames(action)
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial4.text="TUTO4"
			if (Input.is_action_just_pressed("g_nitro")):
				tutorial_step+=1
		if (tutorial_step==5):
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial3.text=""
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial2.text=""
			$ViewportContainer/Viewport/ColorRect/TutoVBoxContainer/LabelTutorial4.text="TUTO5"
			if (curr_car.translation.distance_to(ctuto[2].translation)<11):
				tutorial_step=6
		if (tutorial_step==6):
			$ViewportContainer/Viewport/ColorRect.rect_position[1]=lerp($ViewportContainer/Viewport/ColorRect.rect_position[1],-620,2*delta)


func _process(_delta):
	camTransform()
	var time = get_node("ViewportContainer/Viewport/Timer").time_left
	var minutes = String(int(time/60))
	var seconds = String(int(time)%60)
	get_node("ViewportContainer/Viewport/CanvasLayer/Control/Label").text = minutes+":"+seconds

	get_node("ViewportContainer/Viewport/Area/AnimationPlayer").play("anim_end_event")

	playerLoserOrWin(_delta, time)

	tutorial(_delta)


func _on_Area_body_entered(body):
	if (get_node("ViewportContainer/Viewport/Timer").time_left<timer-0.05 and (body==curr_car)):
		get_node("ViewportContainer/Viewport/Timer").paused = true
		pts = get_node("ViewportContainer/Viewport/Timer").time_left*100
		win = 1
	elif (body==curr_car_enemy and win==0):
		loser=true




func _on_Area0_body_entered(body):
	if (curr_car_enemy.index_checkpoints<len_checkpoints and body==curr_car_enemy):
		#print("body=",body)
		curr_car_enemy.index_checkpoints+=1
