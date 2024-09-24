extends Spatial


var car_loaded: Object
var curr_car: Object
var camera: Object
var curr_cam: Object
var loser: bool = false
var pts: float = 0.0
var timer: float
var win: int = 0
var golds: int = 0.0
var time_end: float = 0.0
var curr_car_enemy: Object
var len_checkpoints: int = 23
var index_cp: int = 0
onready var event_name0: String
var save_file: Resource


func _ready():
	# MUDAR O NOME DA VAR DO SAVED FILE RESOURCE LÀ EMBAIXO EM winPlay()!!
	var event_name: String = "event2_char1_v1" # Deve ser mesmo nome do node e do file
	#event_name0 = "event2_char1" # Deve ser o nome para progressao do game
	var file_event = File.new()
	file_event.open("res://data_files/event_name.txt", File.WRITE)
	file_event.store_string(event_name)
	file_event.close()
	save_file = SaveFile.new()

	#var file = File.new()
	#file.open("res://data_files/car_selected.txt",File.READ)
	#var car = file.get_csv_line()[0]
	save_file = ResourceLoader.load("res://resources/saved_game/saved_game.tres")
	#Load car player:
	car_loaded = load("res://scenes/cars_updated/"+save_file.car_selected+".tscn")
	#file.close()
	#print("car_res=",car_loaded)
	curr_car = car_loaded.instance()
	curr_car.MODES.PLAYER
	get_node("ViewportContainer/Viewport/car_invoker").add_child(curr_car)
	#load enemy:
	var file_enemy = File.new()
	file_enemy.open("res://data_files/cp_enemy.txt", File.WRITE)
	file_enemy.store_string("0")
	file_enemy.close()
	var car_loaded_enemy: Object = load("res://scenes/cars_updated/"+save_file.car_selected+".tscn")
	curr_car_enemy = car_loaded_enemy.instance()
	get_node("ViewportContainer/Viewport/car_invoker_enemy").add_child(curr_car_enemy)
	curr_car_enemy.MODES.AI
	#camera = preload("res://scenes/camera/camera.scn")
	#curr_cam = camera.instance()
	curr_cam = $ViewportContainer/Viewport/car_invoker/Camera
	
	timer = 55.0
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
	curr_cam.rotation_degrees[0] = -90.0
	curr_cam.rotation_degrees[1] = 180.0
	curr_cam.rotation_degrees[2] = 0.0


func winPlay(_delta):
	#print("time_end=",time_end)
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
			
			var save_file: Resource = load("res://resources/saved_game/saved_game.tres")
			save_file.event2_char1 = true #MUDAR AQUI O NOME DA VARIAVEL NO RESOURCE!!
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


func _process(_delta):
	camTransform()
	var time = get_node("ViewportContainer/Viewport/Timer").time_left
	var minutes = String(int(time/60))
	var seconds = String(int(time)%60)
	get_node("ViewportContainer/Viewport/CanvasLayer/Control/Label").text = minutes+":"+seconds

	get_node("ViewportContainer/Viewport/Area/AnimationPlayer").play("anim_end_event")
	
	playerLoserOrWin(_delta, time)


func _on_Area_body_entered(body):
	if (get_node("ViewportContainer/Viewport/Timer").time_left<timer-0.05 and (body==curr_car)):
		get_node("ViewportContainer/Viewport/Timer").paused = true
		pts = get_node("ViewportContainer/Viewport/Timer").time_left*100
		win = 1
	elif (body==curr_car_enemy and win==0):
		loser=true


func _on_Area0_body_entered(body):
	if (body==curr_car_enemy and index_cp<len_checkpoints):
		index_cp+=1
		var file = File.new()
		file.open("res://data_files/cp_enemy.txt",File.WRITE)
		file.store_string(String(index_cp))
		file.close()
