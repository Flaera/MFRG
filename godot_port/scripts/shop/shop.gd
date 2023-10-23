extends Spatial


var cars: Dictionary
var car_loaded: Object
var cars_list: Array = []
var player_cars: Array = []
var car_in_shop: String
var acc: int = 0
var final_acc: int
var prices: Array = []
var money: int


func loadCarList():
	var file = File.new()
	file.open("res://data_files/cars_list.txt", File.READ_WRITE)
	for i in cars.keys():
		file.store_string((i+"\n"))
		acc+=1
	cars_list = file.get_as_text().rsplit("\n")
	file.close()
	#print(cars_list)
	final_acc = acc-1
	acc = 0


func loadMoney():
	var file = File.new()
	file.open("res://data_files/gold.txt", File.READ)
	money = int(file.get_csv_line()[0])
	file.close()
	print(money)


func updatePrice():
	get_node("CanvasLayer/Control2/LabelPrices").text = String(prices[acc])


func _ready():
	get_node("CanvasLayer/Control/ButtonRightShop").grab_focus()
	cars = preload("res://data_files/cars_specs.gd").new().specs
	loadCarList()
	for i in cars.keys():
		prices.append(cars[i][0])
	car_loaded = load("res://scenes/cars/"+cars_list[acc]+"_only_asset.tscn")
	get_node("car_invoker").add_child(car_loaded.instance())
	updatePrice()
	
	var file2 = File.new()
	file2.open("res://data_files/player_cars.txt", File.READ)
	player_cars = file2.get_as_text().rsplit("\n")
	loadMoney()


func changeCar(var index: int):
	get_node("car_invoker").get_child(0).queue_free()
	car_loaded = load("res://scenes/cars/"+cars_list[index]+"_only_asset.tscn")
	get_node("car_invoker").add_child(car_loaded.instance())
	updatePrice()


func _process(_delta):
	get_node("rot_cam").rotation_degrees.y += _delta*10
	var file = File.new()
	file.open("res://data_files/car_in_shop.txt", File.WRITE)
	file.store_string(cars_list[acc])
	
	#print(get_node("CanvasLayer/TimerWarning").time_left)
	if (get_node("CanvasLayer/TimerWarning").time_left<=0.0):
		get_node("CanvasLayer/CAR_ALREYD_GARAGE").visible=false
		get_node("CanvasLayer/NO_SPACE_HOLLOW").visible=false
		get_node("CanvasLayer/CAR_BUIED").visible=false
		get_node("CanvasLayer/NO_MONEY").visible=false

	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://scenes/map/map.scn")


func _on_ButtonLeftShop_pressed():
	acc -= 1
	if (acc<0):
		acc = final_acc
	changeCar(acc)


func _on_ButtonRightShop_pressed():
	acc+=1
	if (acc>final_acc): acc = 0
	changeCar(acc)


func saveMoney(var less_money: int):
	var file: File = File.new()
	money -= less_money
	file.open("res://data_files/gold.txt", File.WRITE)
	file.store_string(String(money))
	file.close()


func _on_ButtonConfirmShop_pressed():
	print("--",cars_list,"--",player_cars)
	if (cars_list[acc] in player_cars):
		print("Carro já comprado")
		get_node("CanvasLayer/CAR_ALREYD_GARAGE").visible=true
		get_node("CanvasLayer/TimerWarning").start(5)
	elif (len(player_cars)>=3 and not("VAZIO" in player_cars)):
		print("Não há espaço vazio para carros na sua garagem")
		get_node("CanvasLayer/NO_SPACE_HOLLOW").visible=true
		get_node("CanvasLayer/TimerWarning").start(5)
	elif (prices[acc]>money):
		print("DEBUGGER: ", money, "--", prices[acc])
		get_node("CanvasLayer/NO_MONEY").visible=true
		get_node("CanvasLayer/TimerWarning").start(5)
	elif (("VAZIO" in player_cars) and (prices[acc]<=money)):
		print("Carro comprado")
		get_node("CanvasLayer/CAR_BUIED").visible=true
		get_node("CanvasLayer/TimerWarning").start(5)
		for i in range(len(player_cars)):
			if (player_cars[i]=="VAZIO"):
				player_cars[i] = cars_list[acc]
				break
		var file = File.new()
		file.open("res://data_files/player_cars.txt", File.WRITE)
		var acc1: int = 0
		for j in player_cars:
			if (acc1<2):
				file.store_string(j+"\n")
			elif (acc1==2):
				file.store_string(j)
			acc1+=1
		saveMoney(prices[acc])
		loadCarList()
		loadMoney()
		print("Update cars_list=",cars_list)


func _on_ButtonQuit_pressed():
	get_tree().change_scene("res://scenes/map/map.scn")
