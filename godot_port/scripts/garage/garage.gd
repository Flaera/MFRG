extends Spatial


var rotate_y: float = 0.0
var car_loaded: Object
var cars_list = []
var acc: int
var cars: Dictionary = {}


func loadCarList():
	var file = File.new()
	file.open("res://data_files/player_cars.txt",File.READ)
	cars_list = file.get_as_text().rsplit("\n")
	file.close()
	for i in range(len(cars_list)):
		if (cars_list[i]==""):
			cars_list[i]="VAZIO"
	print("--",cars_list)
	var acc1: int = 0
	for j in range(len(cars_list)):
		if (cars_list[j]!="VAZIO"):
			acc1 = j
			break
	acc = acc1


func _ready():
	cars = preload("res://data_files/cars_specs.gd").new().specs
	loadCarList()	
	print("acc=",acc)
	car_loaded = load("res://scenes/cars/"+cars_list[acc]+"_only_asset.tscn")
	get_node("invoker").add_child(car_loaded.instance())
	get_node("CanvasLayer/VBoxContainer/HBoxContainer"+String(acc)+"/B_CARRO_"+String(acc+1)).grab_focus()
	
	SelectLang.new().textInAllNodes(get_node("."))


func carSelect(var index: int):
	if (cars_list[index]!="VAZIO"):
		var file = File.new()
		file.open("res://data_files/car_selected.txt",File.WRITE)
		file.store_string(cars_list[index])
		file.close()


func changeCar(var index: int):
	get_node("invoker").get_child(0).queue_free()
	car_loaded = load("res://scenes/cars/"+cars_list[index]+"_only_asset.tscn")
	print("cl=",cars_list)
	get_node("invoker").add_child(car_loaded.instance())
	#print(get_node("invoker"))


func _process(_delta):
	get_node("Spatial/Spatial").rotation_degrees.y = rotate_y
	rotate_y += 10*_delta#lerp(rotate_y,360,10*_delta)
	if (rotate_y >= 360.0):
		rotate_y=0.0

	get_node("CanvasLayer/VBoxContainer/HBoxContainer0/B_CARRO_1").text = cars_list[0]
	get_node("CanvasLayer/VBoxContainer/HBoxContainer1/B_CARRO_2").text = cars_list[1]
	get_node("CanvasLayer/VBoxContainer/HBoxContainer2/B_CARRO_3").text = cars_list[2]

	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://scenes/map/map2.tscn")


func _on_B_CARRO_1_pressed():
	if (cars_list[0]!="VAZIO"):
		carSelect(0)
		get_tree().change_scene("res://scenes/map/map2.tscn")


func _on_B_CARRO_2_pressed():
	if (cars_list[1]!="VAZIO"):
		carSelect(1)
		get_tree().change_scene("res://scenes/map/map2.tscn")


func _on_B_CARRO_3_pressed():
	if (cars_list[2]!="VAZIO"):
		carSelect(2)
		get_tree().change_scene("res://scenes/map/map2.tscn")


func _on_B_CARRO_1_mouse_entered():
	print("acc=",acc," cl=", cars_list)
	carSelect(0)
	if (cars_list[0]!="VAZIO"):
		changeCar(0)
	acc = 0


func _on_B_CARRO_2_mouse_entered():
	print("acc=",acc," cl=", cars_list)
	carSelect(1)
	if (cars_list[1]!="VAZIO"):
		changeCar(1)
	acc = 1


func _on_B_CARRO_3_mouse_entered():
	print("acc=",acc," cl=", cars_list)
	carSelect(2)
	if (cars_list[2]!="VAZIO"):
		changeCar(2)
	acc = 2

func sellCar(var index: int):
	var progress: bool = false
	var quant_cars: int = 0
	for i in cars_list:
		if (i!="VAZIO"):
			quant_cars += 1
		if quant_cars==2:
			progress = true
			break
	if (cars_list[index]!="VAZIO" and progress==true):
		var acc2: int = 0
		var file = File.new()
		var current = cars_list[index]
		print("curr=",current)
		file.open("res://data_files/player_cars.txt", File.WRITE)
		for j in cars_list:
			if (acc2==0):
				if (j==current):
					file.store_string("VAZIO\n")
				elif (j=="VAZIO"):
					file.store_string("VAZIO\n")
				elif (j!="VAZIO"):
					file.store_string(j+"\n")
			elif (acc2==1):
				if (j==current):
					file.store_string("VAZIO\n")
				elif (j=="VAZIO"):
					file.store_string("VAZIO\n")
				elif (j!="VAZIO"):
					file.store_string(j+"\n")
			elif (acc2==2):
				if (j==current):
					file.store_string("VAZIO")
				elif (j=="VAZIO"):
					file.store_string("VAZIO")
				elif (j!="VAZIO"):
					file.store_string(j)
			acc2+=1
		file.close()
		var file_gold = File.new()
		file_gold.open("res://data_files/gold.txt", File.READ)
		var curr_gold: int = int(file_gold.get_csv_line()[0])
		file_gold.close()
		curr_gold = curr_gold+int(cars[cars_list[index]][0]/2)
		var file_gold2 = File.new()
		file_gold2.open("res://data_files/gold.txt", File.WRITE)
		file_gold2.store_string(String( (curr_gold) ))
		file_gold2.close()
		loadCarList()
		carSelect(acc)
		changeCar(acc)


func _on_B_CAR_SELL1_pressed():
	sellCar(0)


func _on_B_CAR_SELL2_pressed():
	sellCar(1)


func _on_B_CAR_SELL3_pressed():
	sellCar(2)

