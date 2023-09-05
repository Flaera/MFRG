extends Spatial


var rotate_y: float = 0.0
var car_loaded: Object
var cars_list = []


func _ready():
	var file = File.new()
	file.open("res://data_files/player_cars.txt",File.READ)
	cars_list = file.get_as_text().rsplit("\n")
	file.close()
	car_loaded = load("res://scenes/cars/"+cars_list[0]+"_only_asset.tscn")
	get_node("invoker").add_child(car_loaded.instance())
	get_node("CanvasLayer/VBoxContainer/HBoxContainer/B_CARRO_1").grab_focus()
	for i in range(len(cars_list)):
		if (cars_list[i]==""):
			cars_list[i]="VAZIO"
	get_node("CanvasLayer/VBoxContainer/HBoxContainer/B_CARRO_1").text = cars_list[0]
	get_node("CanvasLayer/VBoxContainer/HBoxContainer/B_CARRO_2").text = cars_list[1]
	get_node("CanvasLayer/VBoxContainer/HBoxContainer/B_CARRO_3").text = cars_list[2]


func _process(_delta):
	get_node("Spatial/Spatial").rotation_degrees.y = rotate_y
	rotate_y += 10*_delta#lerp(rotate_y,360,10*_delta)
	if (rotate_y >= 360.0):
		rotate_y=0.0


func carSelect(var index: int):
	if (cars_list[index]!="VAZIO"):
		var file = File.new()
		file.open("res://data_files/car_seleted.txt",File.WRITE)
		file.store_string(cars_list[index])


func _on_B_CARRO_1_pressed():
	if (cars_list[0]!="VAZIO"):
		carSelect(0)
		get_tree().change_scene("res://scenes/map/map.scn")


func _on_B_CARRO_2_pressed():
	if (cars_list[1]!="VAZIO"):
		carSelect(1)
		get_tree().change_scene("res://scenes/map/map.scn")


func _on_B_CARRO_3_pressed():
	if (cars_list[2]!="VAZIO"):
		carSelect(2)
		get_tree().change_scene("res://scenes/map/map.scn")


func changeCar(var index: int):
	get_node("invoker").get_child(0).queue_free()
	car_loaded = load("res://scenes/cars/"+cars_list[index]+"_only_asset.tscn")
	get_node("invoker").add_child(car_loaded.instance())


func _on_B_CARRO_1_mouse_entered():
	carSelect(0)
	if (cars_list[0]!="VAZIO"):
		#remove_child(get_node("invoker").get_child(0))
		changeCar(0)
	get_node("CanvasLayer/VBoxContainer/HBoxContainer/B_CARRO_1").grab_focus()


func _on_B_CARRO_2_mouse_entered():
	carSelect(1)
	if (cars_list[1]!="VAZIO"):
		changeCar(1)
	get_node("CanvasLayer/VBoxContainer/HBoxContainer/B_CARRO_2").grab_focus()


func _on_B_CARRO_3_mouse_entered():
	carSelect(2)
	if (cars_list[2]!="VAZIO"):
		#remove_child(get_node("invoker").get_child(0))
		changeCar(2)
	get_node("CanvasLayer/VBoxContainer/HBoxContainer/B_CARRO_3").grab_focus()


func _on_B_CARRO_1_focus_entered():
	carSelect(0)
	if (cars_list[0]!="VAZIO"):
		changeCar(0)


func _on_B_CARRO_2_focus_entered():
	carSelect(1)
	if (cars_list[1]!="VAZIO"):
		changeCar(1)


func _on_B_CARRO_3_focus_entered():
	carSelect(2)
	if (cars_list[2]!="VAZIO"):
		changeCar(2)
