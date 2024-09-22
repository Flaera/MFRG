extends Spatial

onready var car_invoker = $car_invoker
onready var label_prices = $CanvasLayer/Control2/LabelPrices
onready var button_right = $CanvasLayer/Control/ButtonRightShop
onready var rot_cam = $rot_cam
onready var timer_warning = $CanvasLayer/TimerWarning
onready var car_already_garage = $CanvasLayer/CAR_ALREYD_GARAGE
onready var no_space_hollow = $CanvasLayer/NO_SPACE_HOLLOW
onready var car_bought = $CanvasLayer/CAR_BUIED
onready var no_money = $CanvasLayer/NO_MONEY
onready var UI = $Control

var cars: Dictionary
var car_loaded: Car
var car_unloaded: Car
var cars_list: Array = []
var player_cars: Array = []
var car_in_shop: String
var acc: int = 0
var final_acc: int
var prices: Array = []
var money: int
var cars_folder_path = "res://scenes/cars_updated"
var res_savegame = ResourceLoader.load("res://resources/saved_game/saved_game.tres")



func loadCarList():
	var directory = Directory.new()
	if directory.open(cars_folder_path) == OK:
		directory.list_dir_begin()
		var file_name = directory.get_next()
		
		while file_name != "":
			if file_name.ends_with(".tscn"):
				var file_path = cars_folder_path + "/" + file_name
				cars_list.append(load(file_path).instance() as Car)
				
			file_name = directory.get_next()
		
		directory.list_dir_end()
		for car in cars_list:
			car.MODES.STATIC
		spawnCars()


func spawnCars():
	for car in cars_list:
		car.disable()
		car_invoker.add_child(car)
	changeCar(0, cars_list.size()-1)


func loadMoney():
	#var file = File.new()
	#file.open("res://data_files/gold.txt", File.READ)
	#money = int(file.get_csv_line()[0])
	#file.close()
	money = res_savegame.gold
	print(money)


func updatePrice():
	label_prices.text = String(car_loaded.price)


func _ready():
	button_right.grab_focus()
	cars = preload("res://data_files/cars_specs.gd").new().specs
	loadCarList()
	for i in cars.keys():
		prices.append(cars[i][0])
	car_loaded = cars_list[acc]
	car_invoker.add_child(car_loaded)
	updatePrice()
	
	#var file2 = File.new()
	#file2.open("res://data_files/player_cars.txt", File.READ)
	#player_cars = file2.get_as_text().rsplit("\n")
	player_cars = [res_savegame.car0_in_garage,res_savegame.car1_in_garage,res_savegame.car2_in_garage]
	
	loadMoney()
	
	var select_lang = SelectLang.new()
	select_lang.textInAllNodes(get_node("."))
	
	select_lang.contrast_in_texturesrects(get_node("."))
	
	Contrast3D.new().contrast_3d(get_node("."))



func changeCar(var index: int, var previous_index: int):
	car_loaded = cars_list[index]
	car_loaded.transform = car_invoker.transform
	car_loaded.enable()
	car_unloaded = cars_list[previous_index]
	car_unloaded.disable()
	car_unloaded.transform = car_invoker.transform
	updatePrice()
	UI.changeUIProperties(cars_list[index])
	


func _process(_delta):
	rot_cam.rotation_degrees.y += _delta*10
	
	#print(get_node("CanvasLayer/TimerWarning").time_left)
	if (timer_warning.time_left<=0.0):
		car_already_garage.visible=false
		no_space_hollow.visible=false
		car_bought.visible=false
		no_money.visible=false

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/map/map2.tscn")


func _on_ButtonLeftShop_pressed():
	acc -= 1
	if (acc<0):
		acc = cars_list.size()-1
		changeCar(acc,0)
		return
	changeCar(acc, acc+1)


func _on_ButtonRightShop_pressed():
	acc+=1
	print("ACC: ", acc)
	if (acc>cars_list.size()-1): acc = 0
	changeCar(acc, acc-1)


func saveMoney(var less_money: int):
	#var file: File = File.new()
	res_savegame.gold = money-less_money
	#file.open("res://data_files/gold.txt", File.WRITE)
	#file.store_string(String(money))
	#file.close()
	ResourceSaver.save("res://resources/saved_game/saved_game.tres", res_savegame)


func _on_ButtonConfirmShop_pressed():
	print("--",cars_list,"--",player_cars)
	if (cars_list[acc].name in player_cars):
		print("Carro já comprado")
		car_already_garage.visible=true
		timer_warning.start(5)
	elif (len(player_cars)>=3 and not("VAZIO" in player_cars)):
		print("Não há espaço vazio para carros na sua garagem")
		no_space_hollow.visible=true
		timer_warning.start(5)
	elif (prices[acc]>money):
		print("DEBUGGER: ", money, "--", prices[acc])
		no_money.visible=true
		timer_warning.start(5)
	elif (("VAZIO" in player_cars) and (prices[acc]<=money)):
		print("Carro comprado")
		car_bought.visible=true
		timer_warning.start(5)
		for i in range(len(player_cars)):
			if (player_cars[i]=="VAZIO"):
				player_cars[i] = cars_list[acc].name
				break
		res_savegame.car0_in_garage = player_cars[0]
		res_savegame.car1_in_garage = player_cars[1]
		res_savegame.car2_in_garage = player_cars[2]
		ResourceSaver.save("res://resources/saved_game/saved_game.tres", res_savegame)
		#var file = File.new()
		#file.open("res://data_files/player_cars.txt", File.WRITE)
		#var acc1: int = 0
		#for j in player_cars:
		#	if (acc1<2):
		#		file.store_string(j+"\n")
		#	elif (acc1==2):
		#		file.store_string(j)
		#	acc1+=1
		saveMoney(prices[acc])
		loadCarList()
		loadMoney()
		print("Update cars_list=",cars_list)


func _on_ButtonQuit_pressed():
	get_tree().change_scene("res://scenes/map/map2.tscn")
